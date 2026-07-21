import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geocoding/geocoding.dart';
import '../providers/location_provider.dart';

/// Location Bottom Sheet - ZRent Buyer App
/// 
/// Matches the design from the provided screenshot:
/// - Rounded top container.
/// - Country selection row on the top (e.g. "Country" -> "Nigeria v" with dropdown trigger).
/// - Location section with a toggle switch: "All locations within the Nigeria".
/// - Rounded input field: "Enter city or state / province".
/// - Searchable listing of cities/states within the chosen country.
/// - Uses Geocoding to query Google Maps/native database dynamically for real cities/areas.
/// - Apply button to save selected location filter.
class LocationBottomSheet extends ConsumerStatefulWidget {
  const LocationBottomSheet({super.key});

  @override
  ConsumerState<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends ConsumerState<LocationBottomSheet> {
  late String _selectedCountry;
  late bool _allLocationsEnabled;
  String? _selectedCity;
  
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Dynamic geocoded results state
  bool _isSearchingGeocoding = false;
  List<String> _geocodedSuggestions = [];

  @override
  void initState() {
    super.initState();
    final locationState = ref.read(locationProvider);
    _selectedCountry = locationState.selectedCountry;
    _allLocationsEnabled = locationState.allLocationsEnabled;
    _selectedCity = locationState.selectedCityOrState;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performGeocodingSearch(String query) async {
    if (query.trim().length < 3) {
      setState(() {
        _geocodedSuggestions = [];
      });
      return;
    }

    setState(() {
      _isSearchingGeocoding = true;
    });

    try {
      // Search within the selected country context
      final fullQuery = '$query, $_selectedCountry';
      final locations = await locationFromAddress(fullQuery);
      
      final List<String> tempSuggestions = [];
      for (final loc in locations.take(5)) {
        final placemarks = await placemarkFromCoordinates(loc.latitude, loc.longitude);
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          String? subLocality = place.subLocality;
          String? locality = place.locality;
          String? subAdmin = place.subAdministrativeArea;
          String? admin = place.administrativeArea;

          String area = '';
          if (subLocality != null && subLocality.isNotEmpty) {
            if (locality != null && locality.isNotEmpty && subLocality != locality) {
              area = '$subLocality, $locality';
            } else {
              area = subLocality;
            }
          } else if (locality != null && locality.isNotEmpty) {
            area = locality;
          } else if (subAdmin != null && subAdmin.isNotEmpty) {
            area = subAdmin;
          } else if (admin != null && admin.isNotEmpty) {
            area = admin;
          }

          if (area.isNotEmpty && !tempSuggestions.contains(area)) {
            tempSuggestions.add(area);
          }
        }
      }

      setState(() {
        _geocodedSuggestions = tempSuggestions;
        _isSearchingGeocoding = false;
      });
    } catch (e) {
      setState(() {
        _isSearchingGeocoding = false;
        // Fallback: let them select exactly what they typed if geocoding yields no results
        if (query.isNotEmpty && !_geocodedSuggestions.contains(query)) {
          _geocodedSuggestions = [query];
        }
      });
    }
  }

  void _showCountryPicker() {
    final darkTeal = const Color(0xFF042F2C);
    
    showDialog(
      context: context,
      builder: (context) {
        String localSearch = '';
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final allCountries = LocationNotifier.countryLocations.keys.toList();
            final filteredCountries = allCountries
                .where((c) => c.toLowerCase().contains(localSearch.toLowerCase()))
                .toList();

            return AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              title: Text(
                'Select Country',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: darkTeal,
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              content: SizedBox(
                width: double.maxFinite,
                height: 380,
                child: Column(
                  children: [
                    // Country Search Field
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search country...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: darkTeal),
                        ),
                      ),
                      onChanged: (val) {
                        setDialogState(() {
                          localSearch = val;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    // Country List
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          final isSelected = country == _selectedCountry;
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                            title: Text(
                              country,
                              style: GoogleFonts.poppins(
                                fontSize: 14.5,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected ? darkTeal : Colors.black87,
                              ),
                            ),
                            trailing: isSelected 
                                ? Icon(Icons.check_circle, color: darkTeal, size: 20)
                                : null,
                            onTap: () {
                              setState(() {
                                _selectedCountry = country;
                                // Reset selected city
                                final cities = LocationNotifier.countryLocations[country] ?? [];
                                _selectedCity = cities.isNotEmpty ? cities.first : null;
                                _geocodedSuggestions = [];
                                _searchController.clear();
                                _searchQuery = '';
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkTeal = const Color(0xFF042F2C);
    final limeGreen = const Color(0xFFBEF264);

    // Get available cities for selected country
    final List<String> availableCities = LocationNotifier.countryLocations[_selectedCountry] ?? [];
    
    // Filter cities by search query
    final List<String> filteredCities = availableCities
        .where((city) => city.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle at top
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // 1. Country Selection Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Country',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 17.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: _showCountryPicker,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _selectedCountry,
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.black54, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // 2. Location Toggle Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Location',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF6B7280), // grey
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'All locations within the $_selectedCountry',
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: _allLocationsEnabled,
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFF84CC16), // Lime Green/Yellow switch
                      inactiveThumbColor: Colors.grey.shade400,
                      inactiveTrackColor: Colors.grey.shade200,
                      onChanged: (val) {
                        setState(() {
                          _allLocationsEnabled = val;
                          if (val) {
                            _selectedCity = null;
                            _searchController.clear();
                            _searchQuery = '';
                            _geocodedSuggestions = [];
                          } else {
                            // Default to first city if none chosen
                            if (_selectedCity == null && availableCities.isNotEmpty) {
                              _selectedCity = availableCities.first;
                            }
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 3. Search / Input Field
            TextField(
              controller: _searchController,
              enabled: !_allLocationsEnabled,
              decoration: InputDecoration(
                hintText: 'Enter city or state / province',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey.shade400,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                suffixIcon: _isSearchingGeocoding
                    ? const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Color(0xFF042F2C))),
                        ),
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: darkTeal, width: 1.5),
                ),
                fillColor: _allLocationsEnabled ? Colors.grey.shade50 : Colors.white,
                filled: true,
              ),
              style: GoogleFonts.poppins(fontSize: 14),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
                _performGeocodingSearch(val);
              },
            ),
            const SizedBox(height: 14),

            // 4. Cities List (Visible when "All locations" toggle is OFF)
            if (!_allLocationsEnabled) ...[
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // Dynamic discovered areas section
                    if (_geocodedSuggestions.isNotEmpty) ...[
                      Text(
                        'Discovered Locations:',
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: darkTeal,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ..._geocodedSuggestions.map((city) {
                        final isSelected = city == _selectedCity;
                        return _buildLocationTile(city, isSelected, darkTeal, isDynamic: true);
                      }),
                      const SizedBox(height: 14),
                    ],

                    // Standard suggested cities section
                    Text(
                      'Suggested Locations in $_selectedCountry:',
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (filteredCities.isEmpty && _geocodedSuggestions.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'No matching locations found.',
                            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
                          ),
                        ),
                      )
                    else
                      ...filteredCities.map((city) {
                        // Skip if already listed in geocoded suggestions
                        if (_geocodedSuggestions.contains(city)) {
                          return const SizedBox.shrink();
                        }
                        final isSelected = city == _selectedCity;
                        return _buildLocationTile(city, isSelected, darkTeal);
                      }),
                  ],
                ),
              ),
            ] else ...[
              // Information message when all locations switch is active
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  'Showing properties from all cities and regions across $_selectedCountry.',
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ),
              const Spacer(),
            ],
            const SizedBox(height: 24),

            // 5. Apply Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(locationProvider.notifier).updateLocation(
                        country: _selectedCountry,
                        allLocationsEnabled: _allLocationsEnabled,
                        city: _allLocationsEnabled ? null : _selectedCity,
                      );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Apply Location Filter',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTile(String city, bool isSelected, Color darkTeal, {bool isDynamic = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCity = city;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? darkTeal.withOpacity(0.06) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? darkTeal : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isDynamic ? Icons.map_outlined : Icons.location_city,
              color: isSelected ? darkTeal : Colors.grey,
              size: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                city,
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? darkTeal : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: darkTeal, size: 18),
          ],
        ),
      ),
    );
  }
}

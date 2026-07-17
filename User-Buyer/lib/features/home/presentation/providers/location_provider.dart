import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// Enhanced Location State class to hold country, city/state, and all-location toggles
class LocationState {
  final String selectedLocation; // The display string, e.g. "Lagos, Nigeria" or "Nigeria"
  final String? _selectedCountry;  // nullable internally — use getter
  final bool? _allLocationsEnabled; // nullable internally — use getter
  final String? selectedCityOrState; // Specific city/state/province if selected
  final bool isLoading;
  final String? errorMessage;

  // Safe getter: always returns a valid non-null country string
  String get selectedCountry => _selectedCountry ?? 'Nigeria';

  // Safe getter: always returns a valid non-null bool
  bool get allLocationsEnabled => _allLocationsEnabled ?? false;

  LocationState({
    required this.selectedLocation,
    String? selectedCountry,
    bool? allLocationsEnabled,
    this.selectedCityOrState,
    this.isLoading = false,
    this.errorMessage,
  })  : _selectedCountry = selectedCountry,
        _allLocationsEnabled = allLocationsEnabled;

  LocationState copyWith({
    String? selectedLocation,
    String? selectedCountry,
    bool? allLocationsEnabled,
    String? selectedCityOrState,
    bool isNullCity = false,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LocationState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      allLocationsEnabled: allLocationsEnabled ?? this.allLocationsEnabled,
      selectedCityOrState: isNullCity ? null : (selectedCityOrState ?? this.selectedCityOrState),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Location Notifier to manage country-level, city-level selection, and GPS geocoding
class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier()
      : super(
          LocationState(
            selectedLocation: 'Lagos, Nigeria',
            selectedCountry: 'Nigeria',
            allLocationsEnabled: false,
            selectedCityOrState: 'Lagos',
          ),
        );

  /// Predefined countries and their respective cities/locations
  static const Map<String, List<String>> countryLocations = {
    'Nigeria': ['Lagos', 'Abuja', 'Ibadan', 'Port Harcourt', 'Kano', 'Enugu', 'Lekki', 'Ikeja', 'Maitama', 'Victoria Island'],
    'Indonesia': ['Jakarta', 'Bali', 'Surabaya', 'Bandung', 'Medan'],
    'United States': ['New York', 'Los Angeles', 'San Francisco', 'Chicago', 'Miami', 'Brooklyn'],
    'United Kingdom': ['London', 'Manchester', 'Birmingham', 'Chelsea'],
    'Canada': ['Toronto', 'Vancouver', 'Montreal'],
    'United Arab Emirates': ['Dubai', 'Abu Dhabi'],
    'Germany': ['Berlin', 'Munich', 'Frankfurt', 'Hamburg'],
    'France': ['Paris', 'Marseille', 'Lyon'],
    'Japan': ['Tokyo', 'Osaka', 'Kyoto'],
    'South Africa': ['Cape Town', 'Johannesburg', 'Durban'],
    'Australia': ['Sydney', 'Melbourne', 'Brisbane'],
    'Brazil': ['Rio de Janeiro', 'Sao Paulo', 'Brasilia'],
  };

  /// Set country, toggle switch, and specific city
  void updateLocation({
    required String country,
    required bool allLocationsEnabled,
    String? city,
  }) {
    String displayLocation = '';
    if (allLocationsEnabled) {
      displayLocation = country;
    } else {
      displayLocation = city != null && city.isNotEmpty ? '$city, $country' : country;
    }

    state = state.copyWith(
      selectedLocation: displayLocation,
      selectedCountry: country,
      allLocationsEnabled: allLocationsEnabled,
      selectedCityOrState: city,
      isNullCity: city == null || city.isEmpty,
    );
  }

  /// Compatibility fallback
  void setLocation(String location) {
    // Attempt to split location by comma to extract city and country
    final parts = location.split(',');
    if (parts.length >= 2) {
      final city = parts[0].trim();
      final country = parts[1].trim();
      updateLocation(country: country, allLocationsEnabled: false, city: city);
    } else {
      updateLocation(country: location.trim(), allLocationsEnabled: true, city: null);
    }
  }

  /// Request location permissions and retrieve device coordinates using reverse geocoding
  Future<void> requestAndFetchLocation() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Location services are disabled.',
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(
            isLoading: false,
            errorMessage: 'Location permission denied.',
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Location permissions are permanently denied.',
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 5),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String city = place.locality ?? place.subAdministrativeArea ?? place.administrativeArea ?? '';
        String country = place.country ?? 'Nigeria';
        
        updateLocation(
          country: country,
          allLocationsEnabled: city.isEmpty,
          city: city.isNotEmpty ? city : null,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Could not resolve address.',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error fetching location: $e',
      );
    }
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});

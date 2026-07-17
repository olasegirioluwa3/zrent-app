import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'properties_provider.dart';
import '../../features/home/presentation/providers/location_provider.dart';

/// A derived provider that returns properties already filtered by the
/// currently-selected country / city from [locationProvider].
///
/// Use this provider in ALL screens that display property cards so the
/// location picker on the home screen works app-wide.
///
/// Fallback behaviour:
///  - If [allLocationsEnabled] is true  → all properties in the country.
///  - If a city is selected             → properties whose location string
///                                        contains both the city AND country.
///  - If no city selected               → all properties in the country.
///  - If location state is malformed    → all properties (safe fallback).
final filteredPropertiesProvider = Provider<List<Property>>((ref) {
  final locationState = ref.watch(locationProvider);
  final allProperties = ref.watch(propertiesProvider);

  try {
    final country = locationState.selectedCountry.toLowerCase();
    final city = locationState.selectedCityOrState?.toLowerCase();
    final allEnabled = locationState.allLocationsEnabled;

    return allProperties.where((prop) {
      final propLoc = prop.location.toLowerCase();
      if (allEnabled) {
        return propLoc.contains(country);
      }
      if (city != null && city.isNotEmpty) {
        return propLoc.contains(city) && propLoc.contains(country);
      }
      return propLoc.contains(country);
    }).toList();
  } catch (_) {
    return allProperties;
  }
});

/// Same as [filteredPropertiesProvider] but further filtered to only
/// properties the user has marked as favourite.
final filteredFavouritesProvider = Provider<List<Property>>((ref) {
  return ref.watch(filteredPropertiesProvider)
      .where((p) => p.isFavorite)
      .toList();
});

/// Returns all saved/favourite properties regardless of location —
/// used in the Favourites screen header count and full "Saved" tab.
final allFavouritesProvider = Provider<List<Property>>((ref) {
  return ref.watch(propertiesProvider).where((p) => p.isFavorite).toList();
});

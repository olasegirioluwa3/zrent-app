import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// Location State class to hold location text and state
class LocationState {
  final String selectedLocation;
  final bool isLoading;
  final String? errorMessage;

  LocationState({
    required this.selectedLocation,
    this.isLoading = false,
    this.errorMessage,
  });

  LocationState copyWith({
    String? selectedLocation,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LocationState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Location Notifier to manage permissions and current GPS location fetching
class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(LocationState(selectedLocation: 'Lagos, Nigeria'));

  void setLocation(String location) {
    state = state.copyWith(selectedLocation: location);
  }

  /// Request location permissions and attempt to retrieve device coordinates
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
        String city = place.locality ?? place.subAdministrativeArea ?? place.administrativeArea ?? 'Unknown';
        String country = place.country ?? 'Nigeria';
        state = state.copyWith(
          selectedLocation: '$city, $country',
          isLoading: false,
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

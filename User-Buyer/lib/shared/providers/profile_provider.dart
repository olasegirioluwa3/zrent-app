import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileState {
  final String name;
  final String phoneNumber;
  final String address;
  final String? profilePicturePath;
  final bool isProfilePicLocal;

  ProfileState({
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.profilePicturePath,
    this.isProfilePicLocal = false,
  });

  ProfileState copyWith({
    String? name,
    String? phoneNumber,
    String? address,
    String? profilePicturePath,
    bool? isProfilePicLocal,
  }) {
    return ProfileState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profilePicturePath: profilePicturePath ?? this.profilePicturePath,
      isProfilePicLocal: isProfilePicLocal ?? this.isProfilePicLocal,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier()
      : super(
          ProfileState(
            name: 'Bessie Cooper',
            phoneNumber: '+234 803 123 4567',
            address: 'Ikeja, Lagos, Nigeria',
            profilePicturePath: 'assets/images/profile_placeholder.png',
            isProfilePicLocal: false,
          ),
        );

  void updateProfile({
    String? name,
    String? phoneNumber,
    String? address,
    String? profilePicturePath,
    bool? isProfilePicLocal,
  }) {
    state = state.copyWith(
      name: name,
      phoneNumber: phoneNumber,
      address: address,
      profilePicturePath: profilePicturePath,
      isProfilePicLocal: isProfilePicLocal,
    );
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});

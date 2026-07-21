import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/profile_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _addressCtrl;
  
  String? _localImagePath;
  bool _isImageLocal = false;

  // Geocoding verification state
  bool _isVerifyingAddress = false;
  bool _addressVerified = false;
  String? _verificationError;
  String? _verifiedAddressResult;
  double? _latitude;
  double? _longitude;

  final Color darkTeal = const Color(0xFF042F2C);
  final Color limeGreen = const Color(0xFFBEF264);

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider);
    _nameCtrl = TextEditingController(text: profile.name);
    _phoneCtrl = TextEditingController(text: profile.phoneNumber);
    _addressCtrl = TextEditingController(text: profile.address);
    _localImagePath = profile.profilePicturePath;
    _isImageLocal = profile.isProfilePicLocal;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _localImagePath = pickedFile.path;
          _isImageLocal = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _verifyAndLocateAddress() async {
    final addressText = _addressCtrl.text.trim();
    if (addressText.isEmpty) {
      setState(() {
        _verificationError = 'Please enter an address first';
        _addressVerified = false;
      });
      return;
    }

    setState(() {
      _isVerifyingAddress = true;
      _verificationError = null;
      _addressVerified = false;
      _verifiedAddressResult = null;
    });

    try {
      final locations = await locationFromAddress(addressText);
      if (locations.isNotEmpty) {
        final loc = locations.first;
        final placemarks = await placemarkFromCoordinates(loc.latitude, loc.longitude);
        
        String finalAddress = addressText;
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          final street = place.street ?? '';
          final subLocality = place.subLocality ?? '';
          final locality = place.locality ?? '';
          final country = place.country ?? '';

          final List<String> addressParts = [];
          if (street.isNotEmpty) addressParts.add(street);
          if (subLocality.isNotEmpty && subLocality != street) addressParts.add(subLocality);
          if (locality.isNotEmpty) addressParts.add(locality);
          if (country.isNotEmpty) addressParts.add(country);

          finalAddress = addressParts.join(', ');
        }

        setState(() {
          _latitude = loc.latitude;
          _longitude = loc.longitude;
          _verifiedAddressResult = finalAddress;
          _addressVerified = true;
          _isVerifyingAddress = false;
        });
      } else {
        setState(() {
          _verificationError = 'Could not find location coordinates.';
          _addressVerified = false;
          _isVerifyingAddress = false;
        });
      }
    } catch (e) {
      setState(() {
        _verificationError = 'Error locating address: Place not found.';
        _addressVerified = false;
        _isVerifyingAddress = false;
      });
    }
  }

  Future<void> _launchGoogleMaps() async {
    if (_latitude == null || _longitude == null) return;
    
    // Google Maps link by coordinates or queries
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$_latitude,$_longitude'
    );
    
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch Google Maps app.'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open map: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Save state in provider
    ref.read(profileProvider.notifier).updateProfile(
      name: _nameCtrl.text.trim(),
      phoneNumber: _phoneCtrl.text.trim(),
      address: _addressVerified && _verifiedAddressResult != null 
          ? _verifiedAddressResult 
          : _addressCtrl.text.trim(),
      profilePicturePath: _localImagePath,
      isProfilePicLocal: _isImageLocal,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: AppColors.success,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: darkTeal),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            color: const Color(0xFF1A1A1A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      
                      // ── Profile Picture Edit ──────────────────────────────
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 56,
                              backgroundColor: const Color(0xFFE5E7EB),
                              backgroundImage: _localImagePath != null
                                  ? (_isImageLocal
                                      ? FileImage(File(_localImagePath!)) as ImageProvider
                                      : AssetImage(_localImagePath!) as ImageProvider)
                                  : const AssetImage('assets/images/profile_placeholder.png'),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: limeGreen,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: darkTeal,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ── Inputs ──────────────────────────────────────────
                      _buildLabel('Full Name'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _nameCtrl,
                        hint: 'Enter your full name',
                        validator: (val) => val == null || val.isEmpty ? 'Please enter your name' : null,
                      ),
                      const SizedBox(height: 20),

                      _buildLabel('Phone Number'),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: _phoneCtrl,
                        hint: 'Enter your phone number',
                        keyboardType: TextInputType.phone,
                        validator: (val) => val == null || val.isEmpty ? 'Please enter phone number' : null,
                      ),
                      const SizedBox(height: 20),

                      _buildLabel('Address'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: _addressCtrl,
                              hint: 'Enter street, city, state/province',
                              validator: (val) => val == null || val.isEmpty ? 'Please enter address' : null,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _isVerifyingAddress ? null : _verifyAndLocateAddress,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkTeal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              child: _isVerifyingAddress
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                      ),
                                    )
                                  : const Icon(Icons.gps_fixed, color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),

                      // ── Verification Feedback ──────────────────────────
                      if (_isVerifyingAddress) ...[
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            'Locating address details...',
                            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12.5),
                          ),
                        ),
                      ],

                      if (_addressVerified && _verifiedAddressResult != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.success.withOpacity(0.2)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.check_circle, color: AppColors.success, size: 18),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Address verified on Google Maps',
                                    style: GoogleFonts.poppins(
                                      color: AppColors.success,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _verifiedAddressResult!,
                                style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: _launchGoogleMaps,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.map, color: darkTeal, size: 16),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Locate in Google Maps app',
                                      style: GoogleFonts.poppins(
                                        color: darkTeal,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      if (_verificationError != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.error.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline, color: AppColors.error, size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _verificationError!,
                                  style: GoogleFonts.poppins(
                                    color: AppColors.error,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // Save Button
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: limeGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
                      style: GoogleFonts.poppins(
                        color: darkTeal,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: const Color(0xFF1A1A1A),
          fontSize: 14.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: GoogleFonts.poppins(
          color: const Color(0xFF1A1A1A),
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFF9CA3AF),
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

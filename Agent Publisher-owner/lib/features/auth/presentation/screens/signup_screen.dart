import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';

/// Sign Up Screen - ZRent Agent App
///
/// Registration screen displaying:
/// - Back button and logo header
/// - Title and subtitle
/// - Full name, email, and password input fields
/// - Security badge
/// - Create account button
/// - Social sign-in options
/// - Log in link
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Header with back button and logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF1E3A8A),
                        size: 24,
                      ),
                    ),
                    Image.asset(
                      'assets/images/sign_up_logo.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 48), // Balance the row
                  ],
                ),
                const SizedBox(height: 32),
                // Title
                const Text(
                  'Join the Global Alpha',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E3A8A),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                // Subtitle
                const Text(
                  'Get exclusive access to premium properties and personalized recommendations tailored just for you.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                // Full Name field
                _buildTextField(
                  label: 'FULL NAME',
                  icon: Icons.person_outline,
                  placeholder: 'Zion Zrent',
                ),
                const SizedBox(height: 20),
                // Email field
                _buildTextField(
                  label: 'EMAIL ADDRESS',
                  icon: Icons.email_outlined,
                  placeholder: 'zrent@global.com',
                ),
                const SizedBox(height: 20),
                // Password field
                _buildPasswordField(),
                const SizedBox(height: 16),
                // Security badge
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF10B981),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'BANK-GRADE 256-BIT ENCRYPTION SECURE',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF10B981),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Create Account button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      context.go(RouteNames.dashboard);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF84CC16),
                      foregroundColor: const Color(0xFF1E3A8A),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // OR JOIN WITH separator
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR JOIN WITH',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9CA3AF),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFE5E7EB),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Social sign-in buttons
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 1,
                          ),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            // TODO: Google sign in
                          },
                          icon: const Icon(
                            Icons.g_mobiledata,
                            size: 24,
                            color: Color(0xFF1E3A8A),
                          ),
                          label: const Text(
                            'Google',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 1,
                          ),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            // TODO: Apple sign in
                          },
                          icon: const Icon(
                            Icons.apple,
                            size: 24,
                            color: Color(0xFF1E3A8A),
                          ),
                          label: const Text(
                            'Apple',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Log in link
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                      ),
                      children: [
                        const TextSpan(text: 'Already part of the network? '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              context.push(RouteNames.login);
                            },
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF84CC16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required String placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: const Color(0xFF9CA3AF),
                size: 20,
              ),
              hintText: placeholder,
              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SECURE PASSWORD',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
          child: TextField(
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Color(0xFF9CA3AF),
                size: 20,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: const Color(0xFF9CA3AF),
                  size: 20,
                ),
              ),
              hintText: '••••••••',
              hintStyle: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';

/// Get Started Screen - ZRent Agent App
///
/// Onboarding screen displaying:
/// - Background house image with dark green gradient overlay
/// - ZRent logo
/// - Title and subtitle
/// - Create account button
/// - Google and Apple sign-in buttons
/// - Log in link
class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/get_started_background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Dark green gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF1E3A8A).withOpacity(0.3),
                    const Color(0xFF064E3B).withOpacity(0.85),
                    const Color(0xFF064E3B),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  // Logo
                  Center(
                    child: Image.asset(
                      'assets/images/get_started_logo.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Title
                  const Text(
                    'All-In-One Real\nEstate Platform',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Subtitle
                  const Text(
                    'Discover Our Exceptional Properties. Crafted as Masterpieces with Lasting Value for Client',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFD1D5DB),
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  // Create account button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(RouteNames.register);
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
                        'Create account',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Social sign-in buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
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
                          color: Color(0xFFD1D5DB),
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
        ],
      ),
    );
  }
}

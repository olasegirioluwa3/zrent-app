import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Get Verified Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-1782
/// Screen ID: 233:102
class GetVerifiedScreen extends StatelessWidget {
  const GetVerifiedScreen({super.key});

  void _startVerification(BuildContext context) {
    context.push(RouteNames.documentScan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppTheme.secondary),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Get Verified',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.secondary,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Hero section
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.primary.withOpacity(0.25),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    LucideIcons.shieldCheck,
                    size: 44,
                    color: AppTheme.secondary,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Complete Document\nVerification',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondary,
                    letterSpacing: -0.8,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Upload your government-issued ID to verify your identity and unlock higher tier benefits.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Accepted Documents
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Accepted Documents',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textTertiary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppTheme.borderLight, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.secondary.withOpacity(0.02),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildDocumentOption(
                        icon: LucideIcons.creditCard,
                        title: 'National ID',
                        description: 'Government-issued national identity card',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 64, right: 20),
                        child: Divider(height: 1, color: AppTheme.borderLight, thickness: 1.5),
                      ),
                      _buildDocumentOption(
                        icon: LucideIcons.bookOpen,
                        title: 'Passport',
                        description: 'Valid international passport document',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 64, right: 20),
                        child: Divider(height: 1, color: AppTheme.borderLight, thickness: 1.5),
                      ),
                      _buildDocumentOption(
                        icon: LucideIcons.car,
                        title: 'Driver\'s License',
                        description: 'Government-issued driver\'s license',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Requirements
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.borderLight, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.secondary.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                LucideIcons.clipboardList,
                                color: AppTheme.secondary,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Requirements',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildRequirementRow('Document must be valid and not expired'),
                        _buildRequirementRow('All text must be clearly visible'),
                        _buildRequirementRow('No glare or blur on the document'),
                        _buildRequirementRow('Document must be in color', last: true),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Security Notice
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.primary.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(
                          LucideIcons.lockKeyhole,
                          color: AppTheme.secondary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Your documents are end-to-end encrypted and securely stored.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.secondary,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // CTA Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _startVerification(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.scanLine, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'Start Verification',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentOption({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.secondary.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.secondary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.secondary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Icon(LucideIcons.check, color: AppTheme.success, size: 18),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(String text, {bool last = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.check,
              color: AppTheme.secondary,
              size: 11,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


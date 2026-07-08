import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Publish Success
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-2505
/// Screen ID: 220:420
/// 
/// Actions:
/// - Copy Link
/// - Share Property
/// - Share Social Media
class PublishSuccessScreen extends StatelessWidget {
  const PublishSuccessScreen({super.key});

  void _copyLink(BuildContext context) {
    // TODO: Copy property link to clipboard
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  void _shareProperty(BuildContext context) {
    Share.share('Check out this property on ZRent!');
  }

  void _shareSocialMedia(BuildContext context, String platform) {
    // TODO: Implement social media sharing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share to $platform'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  void _goToDashboard(BuildContext context) {
    context.go(RouteNames.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // Success Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppTheme.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 64,
                  color: AppTheme.success,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Property Published!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Your property is now live and visible to potential buyers',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // Share Actions
              const Text(
                'Share your property',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context,
                      icon: Icons.link,
                      label: 'Copy Link',
                      onTap: () => _copyLink(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      context,
                      icon: Icons.share,
                      label: 'Share',
                      onTap: () => _shareProperty(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Social Media Sharing
              Row(
                children: [
                  _buildSocialButton(
                    context,
                    icon: Icons.facebook,
                    label: 'Facebook',
                    onTap: () => _shareSocialMedia(context, 'Facebook'),
                  ),
                  const SizedBox(width: 12),
                  _buildSocialButton(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Instagram',
                    onTap: () => _shareSocialMedia(context, 'Instagram'),
                  ),
                  const SizedBox(width: 12),
                  _buildSocialButton(
                    context,
                    icon: Icons.alternate_email,
                    label: 'Twitter',
                    onTap: () => _shareSocialMedia(context, 'Twitter'),
                  ),
                  const SizedBox(width: 12),
                  _buildSocialButton(
                    context,
                    icon: Icons.chat,
                    label: 'WhatsApp',
                    onTap: () => _shareSocialMedia(context, 'WhatsApp'),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _goToDashboard(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Back to Dashboard'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // TODO: Add another property
                },
                child: const Text('Add Another Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, size: 24, color: AppTheme.secondary),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

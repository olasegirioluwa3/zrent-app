import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Tier Upgrade Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-2984
/// 
/// Click on CONTINUE UPGRADE: Upgrade to Tier 2
/// https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-3152
/// Verification Submitted
/// https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-3325
/// Click on CONTINUE UPGRADE: Upgrade to Tier 3
/// https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-3237
/// 
/// Screen IDs: 257:208, 257:715, 257:1172, 257:950
class TierUpgradeScreen extends StatefulWidget {
  const TierUpgradeScreen({super.key});

  @override
  State<TierUpgradeScreen> createState() => _TierUpgradeScreenState();
}

class _TierUpgradeScreenState extends State<TierUpgradeScreen> {
  int _currentTier = 1;
  int _selectedTier = 2;

  void _upgradeToTier2() {
    setState(() => _selectedTier = 2);
    _showUpgradeDialog(
      tier: 'Tier 2',
      price: '\$29/month',
      icon: LucideIcons.zap,
      benefits: [
        '50 property listings',
        '\$10,000/month withdrawal limit',
        'Priority support',
        'Featured listings',
      ],
    );
  }

  void _upgradeToTier3() {
    setState(() => _selectedTier = 3);
    _showUpgradeDialog(
      tier: 'Tier 3',
      price: '\$99/month',
      icon: LucideIcons.crown,
      benefits: [
        'Unlimited property listings',
        '\$50,000/month withdrawal limit',
        '24/7 dedicated support',
        'Premium placement',
        'Analytics dashboard',
      ],
    );
  }

  void _showUpgradeDialog({
    required String tier,
    required String price,
    required IconData icon,
    required List<String> benefits,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppTheme.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: AppTheme.secondary, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upgrade to $tier',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondary,
                          letterSpacing: -0.4,
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'What you\'ll get:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textTertiary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12),
              ...benefits.map((b) => Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(LucideIcons.check, size: 11, color: AppTheme.secondary),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          b,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.secondary,
                        side: const BorderSide(color: AppTheme.border, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _submitVerification();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Continue Upgrade',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitVerification() {
    context.push(RouteNames.verificationSubmitted);
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
          'Tier Upgrade',
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
                const Text(
                  'Choose Your Tier',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondary,
                    letterSpacing: -0.8,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Select the verification tier that best fits your business needs.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                _buildTierCard(
                  tier: 1,
                  icon: LucideIcons.shield,
                  title: 'Tier 1',
                  subtitle: 'Basic Agent',
                  price: 'Free',
                  isCurrent: true,
                  features: [
                    '10 property listings',
                    '\$5,000/month withdrawal',
                    'Standard support',
                    'Basic analytics',
                  ],
                ),
                const SizedBox(height: 20),

                _buildTierCard(
                  tier: 2,
                  icon: LucideIcons.zap,
                  title: 'Tier 2',
                  subtitle: 'Professional Agent',
                  price: '\$29',
                  isCurrent: false,
                  features: [
                    '50 property listings',
                    '\$10,000/month withdrawal',
                    'Priority support',
                    'Featured listings',
                    'Advanced analytics',
                  ],
                  onTap: _upgradeToTier2,
                ),
                const SizedBox(height: 20),

                _buildTierCard(
                  tier: 3,
                  icon: LucideIcons.crown,
                  title: 'Tier 3',
                  subtitle: 'Premium Agent',
                  price: '\$99',
                  isCurrent: false,
                  features: [
                    'Unlimited listings',
                    '\$50,000/month withdrawal',
                    '24/7 dedicated support',
                    'Premium placement',
                    'Full analytics dashboard',
                    'Custom branding',
                  ],
                  onTap: _upgradeToTier3,
                ),
                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.borderLight, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(LucideIcons.info, color: AppTheme.secondary, size: 18),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'You can downgrade or upgrade your tier at any time.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                            ),
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

  Widget _buildTierCard({
    required int tier,
    required IconData icon,
    required String title,
    required String subtitle,
    required String price,
    required bool isCurrent,
    required List<String> features,
    VoidCallback? onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isCurrent
              ? AppTheme.primary.withOpacity(0.6)
              : AppTheme.borderLight,
          width: isCurrent ? 2 : 1.5,
        ),
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.1),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                )
              ]
            : [
                BoxShadow(
                  color: AppTheme.secondary.withOpacity(0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(icon, color: AppTheme.secondary, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.secondary,
                            letterSpacing: -0.4,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isCurrent)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Current',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondary,
                    letterSpacing: -1.0,
                  ),
                ),
                if (price != 'Free') ...[
                  const SizedBox(width: 4),
                  const Text(
                    '/mo',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppTheme.borderLight),
            const SizedBox(height: 16),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
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
                        child: const Icon(LucideIcons.check, size: 11, color: AppTheme.secondary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.secondary,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            if (onTap != null && !isCurrent) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Continue Upgrade',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

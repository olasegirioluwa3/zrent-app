import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';

/// Subscription & Plan Screen for ZRent Agent
class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _isYearly = false;
  String _selectedPlan = 'Pro'; // Default selected plan

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
          'Subscription',
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
                // Header text
                const Text(
                  'Choose your Plan',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondary,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Unlock advanced agent features, listing priorities, and analytics tools.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),

                // Toggle monthly / yearly
                _buildBillingToggle(),
                const SizedBox(height: 32),

                // Plan Cards
                _buildPlanCard(
                  name: 'Starter',
                  price: 'Free',
                  subtitle: 'Ideal for new property owners',
                  features: [
                    'Up to 2 property listings',
                    'Basic listings dashboard',
                    'Standard customer support',
                  ],
                  isActive: _selectedPlan == 'Starter',
                  isPopular: false,
                  onSelect: () {
                    setState(() {
                      _selectedPlan = 'Starter';
                    });
                  },
                ),
                const SizedBox(height: 20),

                _buildPlanCard(
                  name: 'Pro',
                  price: _isYearly ? '\$15' : '\$19',
                  subtitle: 'Our most popular plan for active agents',
                  features: [
                    'Unlimited property listings',
                    'Priority list placement (2x views)',
                    'Advanced performance analytics',
                    'Premium customer support',
                    'Exclusive verified badge',
                  ],
                  isActive: _selectedPlan == 'Pro',
                  isPopular: true,
                  onSelect: () {
                    setState(() {
                      _selectedPlan = 'Pro';
                    });
                  },
                ),
                const SizedBox(height: 20),

                _buildPlanCard(
                  name: 'Enterprise',
                  price: _isYearly ? '\$39' : '\$49',
                  subtitle: 'For large agencies and property groups',
                  features: [
                    'Everything in Pro plan',
                    'Direct broker agency branding',
                    'Dedicated account manager',
                    'Featured listings carousel slot',
                    'API integration for CRM syncing',
                  ],
                  isActive: _selectedPlan == 'Enterprise',
                  isPopular: false,
                  onSelect: () {
                    setState(() {
                      _selectedPlan = 'Enterprise';
                    });
                  },
                ),
                const SizedBox(height: 32),

                // Subscription checkout action
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      _showCheckoutBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondary,
                      foregroundColor: AppTheme.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Payment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildBillingToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.borderLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isYearly = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: !_isYearly ? AppTheme.background : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: !_isYearly
                    ? [
                        BoxShadow(
                          color: AppTheme.secondary.withOpacity(0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : null,
              ),
              child: Text(
                'Monthly',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: !_isYearly ? AppTheme.secondary : AppTheme.textSecondary,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isYearly = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: _isYearly ? AppTheme.background : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: _isYearly
                    ? [
                        BoxShadow(
                          color: AppTheme.secondary.withOpacity(0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Text(
                    'Yearly',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _isYearly ? AppTheme.secondary : AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      '-20%',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String name,
    required String price,
    required String subtitle,
    required List<String> features,
    required bool isActive,
    required bool isPopular,
    required VoidCallback onSelect,
  }) {
    return GestureDetector(
      onTap: onSelect,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isActive 
                ? AppTheme.primary
                : (isPopular ? AppTheme.secondary.withOpacity(0.15) : AppTheme.borderLight),
            width: isActive ? 2.5 : 1.5,
          ),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: AppTheme.primary.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 8),
              )
            else if (isPopular)
              BoxShadow(
                color: AppTheme.secondary.withOpacity(0.03),
                blurRadius: 12,
                offset: const Offset(0, 6),
              )
          ],
        ),
        child: Stack(
          children: [
            if (isPopular)
              Positioned(
                top: 0,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: const BoxDecoration(
                    color: AppTheme.secondary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Most Popular',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondary,
                          letterSpacing: -0.4,
                        ),
                      ),
                      if (isActive)
                        const Icon(
                          LucideIcons.checkCircle2,
                          color: AppTheme.secondary,
                          size: 24,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondary,
                          letterSpacing: -1.0,
                        ),
                      ),
                      if (price != 'Free') ...[
                        const SizedBox(width: 4),
                        Text(
                          _isYearly ? '/yr' : '/mo',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 1, color: AppTheme.borderLight),
                  const SizedBox(height: 20),
                  ...features.map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
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
                                size: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                feature,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.secondary,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCheckoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.all(24),
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
                const SizedBox(height: 24),
                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.secondary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSummaryRow(
                  label: 'Selected Plan',
                  value: 'ZRent Agent $_selectedPlan',
                ),
                _buildSummaryRow(
                  label: 'Billing Cycle',
                  value: _isYearly ? 'Yearly (-20%)' : 'Monthly',
                ),
                const Divider(height: 32, color: AppTheme.borderLight),
                _buildSummaryRow(
                  label: 'Total Due',
                  value: _selectedPlan == 'Starter' 
                      ? 'Free'
                      : (_selectedPlan == 'Pro' 
                          ? (_isYearly ? '\$180/yr' : '\$19/mo')
                          : (_isYearly ? '\$468/yr' : '\$49/mo')),
                  isTotal: true,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showSuccessDialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: AppTheme.secondary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? AppTheme.secondary : AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 22 : 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.success.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.sparkles,
                  color: AppTheme.success,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Plan Activated!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondary,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Congratulations! You are now subscribed to the ZRent Agent $_selectedPlan plan. Enjoy your premium benefits.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.pop(); // Go back to profile screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

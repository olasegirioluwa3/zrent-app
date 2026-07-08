import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Withdraw PIN Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-2891
/// Screen ID: 260:623
/// 
/// First withdrawal: Create PIN
/// Later withdrawals: Enter PIN
class WithdrawPinScreen extends StatefulWidget {
  const WithdrawPinScreen({super.key});

  @override
  State<WithdrawPinScreen> createState() => _WithdrawPinScreenState();
}

class _WithdrawPinScreenState extends State<WithdrawPinScreen> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  bool _isFirstWithdrawal = false;
  bool _showPin = false;

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _confirmWithdrawal() {
    if (_isFirstWithdrawal) {
      if (_pinController.text != _confirmPinController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PINs do not match'),
            backgroundColor: AppTheme.error,
          ),
        );
        return;
      }
      if (_pinController.text.length != 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN must be 4 digits'),
            backgroundColor: AppTheme.error,
          ),
        );
        return;
      }
      // TODO: Store PIN
    } else {
      if (_pinController.text.length != 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid PIN'),
            backgroundColor: AppTheme.error,
          ),
        );
        return;
      }
      // TODO: Verify PIN
    }

    context.push(RouteNames.withdrawalSuccess);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.secondary),
          onPressed: () => context.pop(),
        ),
        title: const Text('Security PIN'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              const Icon(
                Icons.lock,
                size: 64,
                color: AppTheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                _isFirstWithdrawal ? 'Create Withdrawal PIN' : 'Enter Withdrawal PIN',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _isFirstWithdrawal
                    ? 'Create a 4-digit PIN for future withdrawals'
                    : 'Enter your 4-digit PIN to confirm withdrawal',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // PIN Input
              TextFormField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                obscureText: !_showPin,
                maxLength: 4,
                decoration: InputDecoration(
                  labelText: _isFirstWithdrawal ? 'Create PIN' : 'Enter PIN',
                  hintText: '****',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_showPin ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() => _showPin = !_showPin);
                    },
                  ),
                  counterText: '',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  letterSpacing: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (_isFirstWithdrawal)
                TextFormField(
                  controller: _confirmPinController,
                  keyboardType: TextInputType.number,
                  obscureText: !_showPin,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: 'Confirm PIN',
                    hintText: '****',
                    prefixIcon: const Icon(Icons.lock_outline),
                    counterText: '',
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 32),
              // Withdrawal Summary
              Card(
                color: AppTheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Withdrawal Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildSummaryRow('Amount', '\$500.00'),
                      _buildSummaryRow('Bank', 'Chase Bank ****4532'),
                      _buildSummaryRow('Processing Time', '1-3 business days'),
                      const Divider(height: 24),
                      _buildSummaryRow('Total', '\$500.00', isBold: true),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _confirmWithdrawal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Confirm Withdrawal'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.secondary,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

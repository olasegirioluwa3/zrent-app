import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Select Bank Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-1596
/// 
/// If Agent wants to withdraw and has not added their Bank and set Withdraw PIN
class SelectBankScreen extends StatefulWidget {
  const SelectBankScreen({super.key});

  @override
  State<SelectBankScreen> createState() => _SelectBankScreenState();
}

class _SelectBankScreenState extends State<SelectBankScreen> {
  String _selectedBank = '';
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();

  @override
  void dispose() {
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  void _continueToSetPin() {
    if (_selectedBank.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a bank'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }
    if (_accountNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter account number'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }
    if (_accountNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter account name'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    // TODO: Store bank details
    context.push(RouteNames.setPin);
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
        title: const Text('Select Bank'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            const SizedBox(height: 24),
            const Icon(
              Icons.account_balance,
              size: 64,
              color: AppTheme.primary,
            ),
            const SizedBox(height: 24),
            const Text(
              'Add Your Bank Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Select your bank to enable withdrawals',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Bank Selection
            const Text(
              'Select Bank',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.secondary,
              ),
            ),
            const SizedBox(height: 12),
            _buildBankOption('Chase Bank', 'assets/icons/chase.png'),
            _buildBankOption('Bank of America', 'assets/icons/boa.png'),
            _buildBankOption('Wells Fargo', 'assets/icons/wells.png'),
            _buildBankOption('Citibank', 'assets/icons/citi.png'),
            _buildBankOption('US Bank', 'assets/icons/usbank.png'),
            _buildBankOption('Other', 'assets/icons/other.png'),
            const SizedBox(height: 24),
            // Account Details
            TextFormField(
              controller: _accountNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Account Number',
                hintText: 'Enter account number',
                prefixIcon: Icon(Icons.account_balance_wallet),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _accountNameController,
              decoration: const InputDecoration(
                labelText: 'Account Name',
                hintText: 'Enter account holder name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 24),
            // Security Notice
            Card(
              color: AppTheme.primary.withOpacity(0.1),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.security, color: AppTheme.secondary),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your bank information is encrypted and secure',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _continueToSetPin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBankOption(String bankName, String iconPath) {
    final isSelected = _selectedBank == bankName;
    return InkWell(
      onTap: () {
        setState(() => _selectedBank = bankName);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary.withOpacity(0.1) : AppTheme.surface,
          border: Border.all(
            color: isSelected ? AppTheme.primary : AppTheme.border,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.borderLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.account_balance, color: AppTheme.textTertiary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                bankName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.secondary,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.primary),
          ],
        ),
      ),
    );
  }
}

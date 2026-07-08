import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Withdraw Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-2847
/// Screen ID: 257:1359
class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _selectedBank = 'Chase Bank';
  bool _hasBank = true;
  bool _hasPin = true;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _proceedToPin() {
    if (!_formKey.currentState!.validate()) return;

    if (!_hasBank) {
      context.push(RouteNames.selectBank);
    } else if (!_hasPin) {
      context.push(RouteNames.setPin);
    } else {
      context.push(RouteNames.withdrawPin);
    }
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
        title: const Text('Withdraw Funds'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const SizedBox(height: 24),
              // Available Balance
              Card(
                color: AppTheme.primary.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Available Balance',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const Text(
                        '\$4,200.00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Bank Selection
              const Text(
                'Select Bank',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              if (_hasBank)
                DropdownButtonFormField<String>(
                  value: _selectedBank,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_balance),
                    suffixIcon: Icon(Icons.chevron_right),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Chase Bank', child: Text('Chase Bank ****4532')),
                    DropdownMenuItem(value: 'Bank of America', child: Text('Bank of America ****7891')),
                    DropdownMenuItem(value: 'Wells Fargo', child: Text('Wells Fargo ****2345')),
                  ],
                  onChanged: (value) {
                    setState(() => _selectedBank = value!);
                  },
                )
              else
                OutlinedButton.icon(
                  onPressed: () {
                    context.push(RouteNames.selectBank);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Bank Account'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                  ),
                ),
              const SizedBox(height: 16),
              // Amount Input
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Withdrawal Amount',
                  hintText: 'Enter amount',
                  prefixIcon: Icon(Icons.attach_money),
                  prefixText: '\$ ',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter withdrawal amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  if (amount > 4200) {
                    return 'Insufficient balance';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Quick Amount Buttons
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildQuickAmountButton('\$500'),
                  _buildQuickAmountButton('\$1,000'),
                  _buildQuickAmountButton('\$2,000'),
                  _buildQuickAmountButton('All'),
                ],
              ),
              const SizedBox(height: 24),
              // Info Card
              Card(
                color: AppTheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: AppTheme.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Withdrawals are processed within 1-3 business days',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _proceedToPin,
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
      ),
    );
  }

  Widget _buildQuickAmountButton(String amount) {
    return OutlinedButton(
      onPressed: () {
        if (amount == 'All') {
          _amountController.text = '4200';
        } else {
          _amountController.text = amount.replaceAll('\$', '').replaceAll(',', '');
        }
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(amount),
    );
  }
}

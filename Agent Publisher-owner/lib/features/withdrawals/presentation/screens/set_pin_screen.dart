import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Set PIN Screen
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-1673
class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  bool _showPin = false;

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  void _createPin() {
    if (_pinController.text.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PIN must be 4 digits'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }
    if (_pinController.text != _confirmPinController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PINs do not match'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    // TODO: Store PIN securely
    context.pop(); // Go back to withdraw screen
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
        title: const Text('Set Withdrawal PIN'),
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
              const Text(
                'Create Withdrawal PIN',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Create a 4-digit PIN to secure your withdrawals',
                style: TextStyle(
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
                  labelText: 'Create PIN',
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
              // Security Tips
              Card(
                color: AppTheme.surface,
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Security Tips',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.secondary,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '• Use a PIN you can remember but others cannot guess',
                        style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                      ),
                      Text(
                        '• Avoid using common patterns like 1234 or 0000',
                        style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                      ),
                      Text(
                        '• Do not share your PIN with anyone',
                        style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _createPin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Create PIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

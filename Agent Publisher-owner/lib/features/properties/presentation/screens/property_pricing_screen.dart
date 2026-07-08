import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Property Pricing
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-2404
/// Screen ID: 210:20
/// 
/// Must support:
/// - Country
/// - Currency
/// - Sale Price
/// - Rental Price
/// - Ownership Type
/// 
/// AI Feature:
/// - Apply AI Strategy
class PropertyPricingScreen extends StatefulWidget {
  const PropertyPricingScreen({super.key});

  @override
  State<PropertyPricingScreen> createState() => _PropertyPricingScreenState();
}

class _PropertyPricingScreenState extends State<PropertyPricingScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedCountry = 'United States';
  String _selectedCurrency = 'USD';
  String _selectedOwnership = 'Sale';
  final _salePriceController = TextEditingController();
  final _rentalPriceController = TextEditingController();
  bool _applyAIStrategy = false;

  @override
  void dispose() {
    _salePriceController.dispose();
    _rentalPriceController.dispose();
    super.dispose();
  }

  void _publishProperty() {
    if (_formKey.currentState!.validate()) {
      // TODO: Store pricing and publish property
      context.push(RouteNames.publishSuccess);
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
        title: const Text('Property Pricing'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const SizedBox(height: 24),
              // Country Selection
              const Text(
                'Country',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.public),
                ),
                items: const [
                  DropdownMenuItem(value: 'United States', child: Text('United States')),
                  DropdownMenuItem(value: 'United Kingdom', child: Text('United Kingdom')),
                  DropdownMenuItem(value: 'Canada', child: Text('Canada')),
                  DropdownMenuItem(value: 'Australia', child: Text('Australia')),
                  DropdownMenuItem(value: 'Nigeria', child: Text('Nigeria')),
                  DropdownMenuItem(value: 'Kenya', child: Text('Kenya')),
                  DropdownMenuItem(value: 'South Africa', child: Text('South Africa')),
                ],
                onChanged: (value) {
                  setState(() => _selectedCountry = value!);
                },
              ),
              const SizedBox(height: 16),
              // Currency Selection
              const Text(
                'Currency',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCurrency,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.attach_money),
                ),
                items: const [
                  DropdownMenuItem(value: 'USD', child: Text('USD - US Dollar')),
                  DropdownMenuItem(value: 'GBP', child: Text('GBP - British Pound')),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR - Euro')),
                  DropdownMenuItem(value: 'CAD', child: Text('CAD - Canadian Dollar')),
                  DropdownMenuItem(value: 'AUD', child: Text('AUD - Australian Dollar')),
                  DropdownMenuItem(value: 'NGN', child: Text('NGN - Nigerian Naira')),
                  DropdownMenuItem(value: 'KES', child: Text('KES - Kenyan Shilling')),
                  DropdownMenuItem(value: 'ZAR', child: Text('ZAR - South African Rand')),
                ],
                onChanged: (value) {
                  setState(() => _selectedCurrency = value!);
                },
              ),
              const SizedBox(height: 16),
              // Ownership Type
              const Text(
                'Ownership Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'Sale',
                    label: Text('Sale'),
                    icon: Icon(Icons.sell),
                  ),
                  ButtonSegment(
                    value: 'Rent',
                    label: Text('Rent'),
                    icon: Icon(Icons.receipt_long),
                  ),
                  ButtonSegment(
                    value: 'Both',
                    label: Text('Both'),
                    icon: Icon(Icons.swap_horiz),
                  ),
                ],
                selected: {_selectedOwnership},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() => _selectedOwnership = newSelection.first);
                },
              ),
              const SizedBox(height: 16),
              // Sale Price
              if (_selectedOwnership == 'Sale' || _selectedOwnership == 'Both')
                TextFormField(
                  controller: _salePriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Sale Price',
                    hintText: 'Enter sale price',
                    prefixIcon: const Icon(Icons.sell),
                    prefixText: '$_selectedCurrency ',
                  ),
                  validator: (value) {
                    if (_selectedOwnership == 'Sale' || _selectedOwnership == 'Both') {
                      if (value == null || value.isEmpty) {
                        return 'Please enter sale price';
                      }
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 16),
              // Rental Price
              if (_selectedOwnership == 'Rent' || _selectedOwnership == 'Both')
                TextFormField(
                  controller: _rentalPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rental Price (per month)',
                    hintText: 'Enter rental price',
                    prefixIcon: const Icon(Icons.receipt_long),
                    prefixText: '$_selectedCurrency ',
                  ),
                  validator: (value) {
                    if (_selectedOwnership == 'Rent' || _selectedOwnership == 'Both') {
                      if (value == null || value.isEmpty) {
                        return 'Please enter rental price';
                      }
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 24),
              // AI Strategy Feature
              Card(
                color: AppTheme.primary.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: AppTheme.secondary),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Apply AI Pricing Strategy',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.secondary,
                              ),
                            ),
                            Text(
                              'Let AI optimize your pricing for maximum visibility',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _applyAIStrategy,
                        onChanged: (value) {
                          setState(() => _applyAIStrategy = value);
                        },
                        activeColor: AppTheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _publishProperty,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Publish Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

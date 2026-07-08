import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';

/// Property Details
/// 
/// Figma: https://www.figma.com/design/MwxOsKuN9q6b815CH3IcLJ/Untitled?node-id=304-1993
/// Screen ID: 199:333
class PropertyDetailsScreen extends StatefulWidget {
  const PropertyDetailsScreen({super.key});

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _areaController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  void _continueToPreview() {
    if (_formKey.currentState!.validate()) {
      // TODO: Store property details
      context.push(RouteNames.propertyPreview);
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
        title: const Text('Property Details'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Property Title',
                  hintText: 'Enter property title',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter property title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Describe your property',
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter property description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _bedroomsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Bedrooms',
                        hintText: '0',
                        prefixIcon: Icon(Icons.bed),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _bathroomsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Bathrooms',
                        hintText: '0',
                        prefixIcon: Icon(Icons.bathtub),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _areaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Area (sq ft)',
                  hintText: 'Enter area',
                  prefixIcon: Icon(Icons.square_foot),
                  suffixText: 'sq ft',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter property area';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text(
                'Property Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildPropertyTypeChip('Apartment'),
                  _buildPropertyTypeChip('House'),
                  _buildPropertyTypeChip('Villa'),
                  _buildPropertyTypeChip('Studio'),
                  _buildPropertyTypeChip('Condo'),
                  _buildPropertyTypeChip('Townhouse'),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Amenities',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.secondary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildAmenityChip('Parking'),
                  _buildAmenityChip('Pool'),
                  _buildAmenityChip('Gym'),
                  _buildAmenityChip('Security'),
                  _buildAmenityChip('Garden'),
                  _buildAmenityChip('Balcony'),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _continueToPreview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Continue to Preview'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyTypeChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: false,
      onSelected: (selected) {
        // TODO: Handle selection
      },
      selectedColor: AppTheme.primary,
      labelStyle: const TextStyle(color: AppTheme.secondary),
    );
  }

  Widget _buildAmenityChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: false,
      onSelected: (selected) {
        // TODO: Handle selection
      },
      selectedColor: AppTheme.primary,
      labelStyle: const TextStyle(color: AppTheme.secondary),
    );
  }
}

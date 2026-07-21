import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:zrent_buyer/shared/providers/saved_cards_provider.dart';
import 'payment_success_screen.dart';

/// Make Payment Screen — ZRent Buyer App
class PaymentsScreen extends ConsumerStatefulWidget {
  const PaymentsScreen({super.key});

  @override
  ConsumerState<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends ConsumerState<PaymentsScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for new card input
  final _nameCtrl = TextEditingController();
  final _cardNoCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvcCtrl = TextEditingController();
  
  String _selectedCountry = 'Nigeria';
  bool _saveCardToProfile = false;
  bool _isProcessing = false;

  // Selected card reference. Null means "Add another card / Use new card"
  SavedCard? _selectedCard;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final savedCards = ref.read(savedCardsProvider);
      if (savedCards.isNotEmpty) {
        // Auto-select the default card if one exists
        _selectedCard = savedCards.firstWhere((c) => c.isDefault, orElse: () => savedCards.first);
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cardNoCtrl.dispose();
    _expiryCtrl.dispose();
    _cvcCtrl.dispose();
    super.dispose();
  }

  void _submitPayment() {
    // If using a new card, we must validate the form
    if (_selectedCard == null) {
      if (!_formKey.currentState!.validate()) {
        return;
      }
    }

    setState(() {
      _isProcessing = true;
    });

    // Simulate short processing
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });

      // Save card to profile if chosen
      if (_selectedCard == null && _saveCardToProfile) {
        final newCard = SavedCard(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          nameOnCard: _nameCtrl.text.trim(),
          cardNumber: _cardNoCtrl.text.trim(),
          expiryDate: _expiryCtrl.text.trim(),
          cvc: _cvcCtrl.text.trim(),
          country: _selectedCountry,
          isDefault: false,
        );
        ref.read(savedCardsProvider.notifier).addCard(newCard);
      }

      // Route to Payment Success Screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentSuccessScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const darkTeal = Color(0xFF042F2C);
    final savedCards = ref.watch(savedCardsProvider);

    // If a saved card was selected but it was deleted in profile, reset to another saved card or new card
    if (_selectedCard != null && !savedCards.any((c) => c.id == _selectedCard!.id)) {
      if (savedCards.isNotEmpty) {
        _selectedCard = savedCards.firstWhere((c) => c.isDefault, orElse: () => savedCards.first);
      } else {
        _selectedCard = null;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Make Payment',
          style: GoogleFonts.poppins(
            color: const Color(0xFF1A1A1A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Saved Cards Section ─────────────────────────────
                          if (savedCards.isNotEmpty) ...[
                            Text(
                              'Choose Payment Method',
                              style: GoogleFonts.poppins(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ...savedCards.map((card) => _buildSavedCardOption(card)),
                            _buildNewCardOption(),
                            const SizedBox(height: 24),
                          ],

                          // ── New Card Input Form ─────────────────────────────
                          if (_selectedCard == null) ...[
                            if (savedCards.isNotEmpty) ...[
                              Text(
                                'Card Details',
                                style: GoogleFonts.poppins(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Name on Card
                            _buildLabel('Name on Card'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _nameCtrl,
                              hint: 'Name on Card',
                              validator: (val) => val == null || val.isEmpty ? 'Please enter name' : null,
                            ),
                            const SizedBox(height: 20),

                            // Card Number
                            _buildLabel('Card Number'),
                            const SizedBox(height: 8),
                            _buildTextField(
                              controller: _cardNoCtrl,
                              hint: 'Card Number',
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(16),
                                CardNumberInputFormatter(),
                              ],
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 16, right: 12),
                                child: Icon(
                                  Icons.credit_card_outlined,
                                  color: Color(0xFF4B5563),
                                  size: 22,
                                ),
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) return 'Please enter card number';
                                final clean = val.replaceAll(' ', '');
                                if (clean.length < 16) return 'Invalid card number';
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // MMYY & CVC Row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel('MMYY'),
                                      const SizedBox(height: 8),
                                      _buildTextField(
                                        controller: _expiryCtrl,
                                        hint: 'MM/YY',
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                          CardExpiryInputFormatter(),
                                        ],
                                        validator: (val) {
                                          if (val == null || val.isEmpty) return 'Required';
                                          if (val.length < 5) return 'Invalid';
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildLabel('CVC'),
                                      const SizedBox(height: 8),
                                      _buildTextField(
                                        controller: _cvcCtrl,
                                        hint: 'CVC',
                                        obscureText: true,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(3),
                                        ],
                                        validator: (val) {
                                          if (val == null || val.isEmpty) return 'Required';
                                          if (val.length < 3) return 'Invalid';
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Country
                            _buildLabel('Country'),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              value: _selectedCountry,
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Color(0xFFD1D5DB), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: darkTeal, width: 1.5),
                                ),
                              ),
                              items: ['Nigeria', 'Indonesia', 'United States', 'United Kingdom', 'United Arab Emirates', 'South Africa']
                                  .map((country) => DropdownMenuItem(
                                        value: country,
                                        child: Text(
                                          country,
                                          style: GoogleFonts.poppins(
                                            color: const Color(0xFF1A1A1A),
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedCountry = val;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 20),

                            // Save Card Checkbox / Switch
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFE5E7EB)),
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: _saveCardToProfile,
                                    activeColor: darkTeal,
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _saveCardToProfile = val;
                                        });
                                      }
                                    },
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Save card to profile',
                                          style: GoogleFonts.poppins(
                                            color: AppColors.textPrimary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'Keep this card saved for future transactions.',
                                          style: GoogleFonts.poppins(
                                            color: AppColors.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ] else ...[
                            // Summary of selected saved card payment
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.credit_card,
                                      color: AppColors.primary,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Paying with Saved Card',
                                          style: GoogleFonts.poppins(
                                            color: AppColors.textSecondary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '**** **** **** ${_selectedCard!.lastFour}',
                                          style: GoogleFonts.poppins(
                                            color: AppColors.textPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          _selectedCard!.nameOnCard,
                                          style: GoogleFonts.poppins(
                                            color: AppColors.textSecondary,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  
                  // ── Bottom Lime Green Button ─────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _submitPayment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBEF264), // Figma Lime Green
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: Text(
                          _selectedCard != null ? 'Continue with Existing Card' : 'Get Make Payment',
                          style: GoogleFonts.poppins(
                            color: darkTeal,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Processing Payment Loading Overlay
          if (_isProcessing)
            Container(
              color: Colors.black.withOpacity(0.4),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(darkTeal),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Processing Escrow Payment...',
                      style: GoogleFonts.poppins(
                        color: darkTeal,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
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

  Widget _buildSavedCardOption(SavedCard card) {
    final isSelected = _selectedCard?.id == card.id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCard = card;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Credit Card ending in ${card.lastFour}',
                        style: GoogleFonts.poppins(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (card.isDefault) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Default',
                            style: GoogleFonts.poppins(
                              color: AppColors.primary,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    'Expires ${card.expiryDate} • ${card.nameOnCard}',
                    style: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewCardOption() {
    final isSelected = _selectedCard == null;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCard = null;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
              size: 22,
            ),
            const SizedBox(width: 14),
            Text(
              'Add another card',
              style: GoogleFonts.poppins(
                color: AppColors.textPrimary,
                fontSize: 14.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: const Color(0xFF1A1A1A),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    Widget? prefixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: validator,
        textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.poppins(
          color: const Color(0xFF1A1A1A),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            color: const Color(0xFF9CA3AF),
            fontSize: 14,
          ),
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}

/// Custom card number formatter (adds space every 4 digits)
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      int nonSpaceLength = text.replaceFirst(RegExp(r'^\s+'), '').replaceAll(' ', '').length;
      if (nonSpaceLength % 4 == 0 && nonSpaceLength < 16 && i != text.length - 1) {
        buffer.write(' ');
      }
    }
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

/// Custom expiry date formatter (adds slash MM/YY)
class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2 && !text.contains('/')) {
        buffer.write('/');
      }
    }
    final string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

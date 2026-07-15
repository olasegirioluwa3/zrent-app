import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payment_success_screen.dart';

/// Make Payment Screen — ZRent Buyer App
///
/// Matches the Figma design:
/// - Title "Make Payment" with back navigation button.
/// - Text fields for:
///   - Name on Card (pre-filled with "Zrent Zion")
///   - Name on Card (Card number field, pre-filled with "1234 9087 9992 3655" with card icon)
///   - MMYY (pre-filled with "02/2021")
///   - CVC (pre-filled with "999")
///   - Country (Dropdown container with Nigeria flag & label)
/// - Large lime-green "Get Make Payment" button navigating to Payment Success Screen.
class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final _nameCtrl = TextEditingController(text: 'Zrent Zion');
  final _cardNoCtrl = TextEditingController(text: '1234 9087 9992 3655');
  final _expiryCtrl = TextEditingController(text: '02/2021');
  final _cvcCtrl = TextEditingController(text: '999');
  
  bool _isProcessing = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cardNoCtrl.dispose();
    _expiryCtrl.dispose();
    _cvcCtrl.dispose();
    super.dispose();
  }

  void _submitPayment() {
    setState(() {
      _isProcessing = true;
    });

    // Simulate short processing
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });

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
    const borderColor = Color(0xFFD1D5DB);

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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Field 1: Name on Card ────────────────────────────
                        _buildLabel('Name on Card'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _nameCtrl,
                          hint: 'Name on Card',
                        ),
                        const SizedBox(height: 24),

                        // ── Field 2: Card Number (labelled Name on Card in Figma) ────
                        _buildLabel('Name on Card'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _cardNoCtrl,
                          hint: 'Card Number',
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 16, right: 12),
                            child: Icon(
                              Icons.credit_card_outlined,
                              color: Color(0xFF4B5563),
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ── Row 3: MMYY & CVC ────────────────────────────────
                        Row(
                          children: [
                            // MMYY
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('MMYY'),
                                  const SizedBox(height: 8),
                                  _buildTextField(
                                    controller: _expiryCtrl,
                                    hint: 'MMYY',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            // CVC
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('CVC'),
                                  const SizedBox(height: 8),
                                  _buildTextField(
                                    controller: _cvcCtrl,
                                    hint: 'CVC',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // ── Field 4: Country dropdown ────────────────────────
                        _buildLabel('Country'),
                        const SizedBox(height: 8),
                        Container(
                          height: 56,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor, width: 1),
                          ),
                          child: Row(
                            children: [
                              // Nigeria Flag representation using container circles or simple emoji
                              Text(
                                '🇳🇬',
                                style: GoogleFonts.poppins(fontSize: 24),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Nigeria',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF1A1A1A),
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.black87,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
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
                        'Get Make Payment',
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
  }) {
    const borderColor = Color(0xFFD1D5DB);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: TextField(
        controller: controller,
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

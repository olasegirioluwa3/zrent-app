import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/providers/properties_provider.dart';
import '../../../payments/presentation/screens/payments_screen.dart';
import '../../../orders/presentation/screens/orders_list_screen.dart';

/// Checkout Screen — ZRent Buyer App
///
/// Matches the Figma design:
/// - Title "Check Out" and back navigation button.
/// - White property card container with property image, title, and location.
/// - Fee breakdown list (Consultation Fee, Market Analysis Report, Service Tax).
/// - White Total Amount card with the calculated or exact Figma total.
/// - Visa card info and "ESCROW PROTECTED" seal badge.
/// - Large lime-green "Check Out" button.
/// - Handles loading state with a premium payment processing overlay.
class CheckoutScreen extends ConsumerStatefulWidget {
  final String? propertyId;

  const CheckoutScreen({super.key, this.propertyId});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  bool _isProcessing = false;

  void _processPayment(BuildContext context) {
    setState(() {
      _isProcessing = true;
    });

    // Simulate standard payment processing delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
      });

      // Navigate to PaymentsScreen (Make Payment)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentsScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(propertiesProvider);
    
    // Find the property if ID was passed, otherwise default to "Wings Tower" mock
    Property? selectedProperty;
    if (widget.propertyId != null) {
      selectedProperty = properties.firstWhere(
        (p) => p.id == widget.propertyId,
        orElse: () => properties.first,
      );
    }

    final String propertyTitle = selectedProperty?.title ?? 'Wings Tower';
    final String propertyLocation = selectedProperty?.location ?? 'Ikeja, Lagos, Nigeria';
    final String propertyImage = selectedProperty?.imageUrl ?? 
        'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=500&auto=format&fit=crop&q=80';
    
    // If we have a specific property, check if its price is monthly/rental
    final String basePrice = selectedProperty?.price ?? '₦12,500,000';

    // Parse numeric value if possible, else default to Figma numbers
    String feeAmountStr = '₦12,500,000';
    String marketReportStr = '₦1500.00';
    String taxStr = '₦1300.00';
    String totalStr = '₦12,500,000';

    if (selectedProperty != null) {
      // Clean up the price string (e.g. "₦350/month" -> 350)
      final cleanPrice = basePrice.replaceAll(RegExp(r'[^0-9]'), '');
      final parsedPrice = double.tryParse(cleanPrice);
      if (parsedPrice != null) {
        feeAmountStr = basePrice;
        
        // Calculate dynamic tax (5%)
        final taxVal = parsedPrice * 0.05;
        taxStr = '₦${taxVal.toStringAsFixed(2)}';
        
        // Calculate dynamic total
        final totalVal = parsedPrice + 1500 + taxVal;
        totalStr = '₦${totalVal.toStringAsFixed(2)}';
      }
    }

    const darkTeal = Color(0xFF042F2C);

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
          'Check Out',
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Property Summary Card ────────────────────────────
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Circle shape property image matching screenshot
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(propertyImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      propertyTitle,
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF1A1A1A),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      propertyLocation,
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF6B7280),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // ── Fee Breakdown Rows ───────────────────────────────
                        _FeeRow(label: 'Consultation Fee', value: feeAmountStr),
                        const SizedBox(height: 20),
                        _FeeRow(label: 'Market Analysis Report', value: marketReportStr),
                        const SizedBox(height: 20),
                        _FeeRow(label: 'Service Tax (5%)', value: taxStr),
                        const SizedBox(height: 32),

                        // ── Total Amount Card ────────────────────────────────
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Amount',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF1A1A1A),
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                totalStr,
                                style: GoogleFonts.poppins(
                                  color: darkTeal,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),

                        // ── Payment Method & Escrow Row ──────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Card Info
                            Row(
                              children: [
                                const Icon(
                                  Icons.credit_card_outlined,
                                  color: Color(0xFF4B5563),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Visa ending in 1234',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF4B5563),
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            // Escrow Protected Badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFDCFCE7), // Light Green
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.verified,
                                    color: Color(0xFF042F2C),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'ESCROW',
                                        style: GoogleFonts.poppins(
                                          color: darkTeal,
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w800,
                                          height: 1.1,
                                        ),
                                      ),
                                      Text(
                                        'PROTECTED',
                                        style: GoogleFonts.poppins(
                                          color: darkTeal,
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w800,
                                          height: 1.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
                // ── Big Lime Green Button ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _processPayment(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBEF264), // Figma Lime Green
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Check Out',
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
                      'Processing Payment...',
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
}

/// Simple Key-Value Fee Row Widget
class _FeeRow extends StatelessWidget {
  final String label;
  final String value;

  const _FeeRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: const Color(0xFF4B5563),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: const Color(0xFF1A1A1A),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Payment Success Dialog that navigates to the Orders List Screen
class _PaymentSuccessDialog extends StatelessWidget {
  const _PaymentSuccessDialog();

  @override
  Widget build(BuildContext context) {
    const darkTeal = Color(0xFF042F2C);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: Color(0xFFDCFCE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Color(0xFF22C55E),
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Payment Successful!',
              style: GoogleFonts.poppins(
                color: darkTeal,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your payment is now secured in ZRent escrow. Tap below to manage and confirm your order.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: const Color(0xFF6B7280),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  // Dismiss dialog
                  Navigator.pop(context);
                  // Pop Checkout Screen
                  Navigator.pop(context);
                  // Navigate to Orders List Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersListScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Confirm Order',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../orders/presentation/screens/orders_list_screen.dart';

/// Payment Success Screen — ZRent Buyer App
///
/// Matches the Figma design:
/// - Light grey background.
/// - Centered custom checkmark icon:
///   - Soft green filled circular base.
///   - Vibrantly bold lime green circle border.
///   - Bold lime green checkmark in the center.
/// - Bold text: "Payment Successful 🎉".
/// - Large lime-green "Confirm" button at the bottom that routes to the Orders List Screen.
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const darkTeal = Color(0xFF042F2C);
    const limeGreen = Color(0xFFBEF264);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          children: [
            // Center checkmark and message content
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Custom Lime Green/Soft Green Checkmark Circle
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEFAD2), // Very soft green base
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: limeGreen, // Vibrantly bold lime green border
                          width: 4.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.check_rounded,
                        color: limeGreen,
                        size: 80,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Success Message
                    Text(
                      'Payment Successful 🎉',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1B2A2A),
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Lime Green "Confirm" Button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Orders List Screen and clear route history back to main screen
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrdersListScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: limeGreen, // Figma Lime Green
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Confirm',
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/providers/properties_provider.dart';

/// Track Orders Screen — ZRent Buyer App
///
/// Matches the Figma design:
/// - Header: "Track Orders" (centered, back button).
/// - Green-bordered Property Order Card showing listing details.
/// - White panel "Track Order" with the 4-step progress timeline:
///   1. Order Placed (Green Check) - "We have received your order on 20-May-2026"
///   2. Payment Successful 🎉 (Green Check) - "We have received your order on 21-May-2026"
///   3. Agent Accept Order (Green Check) - "We have received your order on 21-May-2026"
///   4. Confirm Order (Grey Check initially, becomes Green Check on confirm) - "We have received your order on 21-May-2026"
/// - Footer note: "Note: don't confirm if you have not got your Order"
/// - Bottom lime-green "Confirm" button.
/// - Confirmation Pop-up Dialog: "Are you sure you want to Confirm" with "Not Yet" and "Confirm" buttons.
class OrderDetailScreen extends ConsumerStatefulWidget {
  final String propertyId;

  const OrderDetailScreen({super.key, required this.propertyId});

  @override
  ConsumerState<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen> {
  bool _isConfirmed = false;

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final limeGreen = const Color(0xFFBEF264);
        final darkTeal = const Color(0xFF042F2C);

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 8,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Text
                Text(
                  'Are you sure\nyou want to Confirm',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),
                // Dialog Buttons
                Row(
                  children: [
                    // Not Yet Button
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: limeGreen,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            'Not Yet',
                            style: GoogleFonts.poppins(
                              color: darkTeal,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Confirm Button
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            setState(() {
                              _isConfirmed = true;
                            });
                            // Show small toast or notification
                            ScaffoldMessenger.of(this.context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Order successfully confirmed!',
                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                                ),
                                backgroundColor: const Color(0xFF16A34A),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: limeGreen,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.poppins(
                              color: darkTeal,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final properties = ref.watch(propertiesProvider);
    
    // Find matching property, fallback to first if not found
    final property = properties.firstWhere(
      (p) => p.id == widget.propertyId,
      orElse: () => properties.first,
    );

    const darkTeal = Color(0xFF042F2C);
    const limeGreen = Color(0xFFBEF264);
    const greenBorder = Color(0xFF22C55E);

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
          'Track Orders',
          style: GoogleFonts.poppins(
            color: const Color(0xFF1A1A1A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Green Bordered Property Card ─────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: greenBorder,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Property Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              property.imageUrl,
                              width: 96,
                              height: 76,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 96,
                                  height: 76,
                                  color: const Color(0xFFF3F4F6),
                                  child: const Icon(Icons.image_outlined, color: Color(0xFF9CA3AF), size: 24),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Property Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Payment Successful Label
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF22C55E),
                                      size: 11,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Payment Successful 🎉',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF22C55E),
                                        fontSize: 8.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),

                                // Title
                                Text(
                                  property.title,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF1A1A1A),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),

                                // Location
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Color(0xFF9CA3AF),
                                      size: 12,
                                    ),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        property.location,
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF6B7280),
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                // Agent verified row
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        property.agentAvatarUrl,
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Color(0xFFE5E7EB),
                                            child: Icon(Icons.person, size: 10, color: Color(0xFF9CA3AF)),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFBEF264),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Agent Verified',
                                            style: GoogleFonts.poppins(
                                              color: darkTeal,
                                              fontSize: 7.5,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          const Icon(
                                            Icons.check_circle,
                                            color: darkTeal,
                                            size: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Price info
                          const SizedBox(width: 8),
                          Text(
                            property.price,
                            style: GoogleFonts.poppins(
                              color: darkTeal,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Track Order Timeline Panel ───────────────────────────
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.015),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Track Order',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF0F172A),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Step 1: Order Placed
                          _buildTimelineStep(
                            title: 'Order Placed',
                            subtitle: 'We have received your order on 20-May-2026',
                            isCompleted: true,
                            isLast: false,
                          ),
                          
                          // Step 2: Payment Successful
                          _buildTimelineStep(
                            title: 'Payment Successful 🎉',
                            subtitle: 'We have received your order on 21-May-2026',
                            isCompleted: true,
                            isLast: false,
                          ),
                          
                          // Step 3: Agent Accept Order
                          _buildTimelineStep(
                            title: 'Agent Accept Order',
                            subtitle: 'We have received your order on 21-May-2026',
                            isCompleted: true,
                            isLast: false,
                          ),
                          
                          // Step 4: Confirm Order
                          _buildTimelineStep(
                            title: 'Confirm Order',
                            subtitle: 'We have received your order on 21-May-2026',
                            isCompleted: _isConfirmed,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Note Footer ──────────────────────────────────────────
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF6B7280),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: 'Note: ',
                              style: GoogleFonts.poppins(
                                color: darkTeal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const TextSpan(
                              text: 'don\'t confirm if you have not got your Order',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // ── Bottom Confirm Action Button ─────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isConfirmed
                      ? null
                      : () => _showConfirmationDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: limeGreen,
                    disabledBackgroundColor: const Color(0xFFE5E7EB),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: GoogleFonts.poppins(
                      color: _isConfirmed ? const Color(0xFF9CA3AF) : darkTeal,
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

  Widget _buildTimelineStep({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isLast,
  }) {
    final activeColor = const Color(0xFF22C55E);
    final inactiveColor = const Color(0xFF94A3B8);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Dot and vertical line
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? activeColor : inactiveColor.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check,
                  color: isCompleted ? activeColor : inactiveColor.withOpacity(0.5),
                  size: 20,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? activeColor : const Color(0xFFE2E8F0),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Step Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF1E293B),
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF64748B),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

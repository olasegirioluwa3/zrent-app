import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Category Chips — sits inside the white floating card on the HomeHeader.
/// Dark teal = selected, light grey = unselected.
class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int _selectedIndex = 0;

  static const _categories = [
    _Cat(icon: Icons.home_outlined, label: 'All'),
    _Cat(icon: Icons.key_outlined, label: 'Rent'),
    _Cat(icon: Icons.cottage_outlined, label: 'House'),
    _Cat(icon: Icons.apartment_outlined, label: 'Properties'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(_categories.length, (i) {
          final isSelected = _selectedIndex == i;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i < _categories.length - 1 ? 10 : 0),
              child: GestureDetector(
                onTap: () => setState(() => _selectedIndex = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 64,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF042F2C)  // Dark teal
                        : const Color(0xFFF3F4F6), // Light grey
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _categories[i].icon,
                        color: isSelected ? Colors.white : const Color(0xFF6B7280),
                        size: 20,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _categories[i].label,
                        style: GoogleFonts.poppins(
                          color: isSelected ? Colors.white : const Color(0xFF6B7280),
                          fontSize: 11,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _Cat {
  final IconData icon;
  final String label;
  const _Cat({required this.icon, required this.label});
}

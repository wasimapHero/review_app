import 'package:flutter/material.dart';

class BadgeChip extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const BadgeChip({
    Key? key,
    required this.text, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, // Handles click
      child: Container(
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F4F8),
          borderRadius: BorderRadius.circular(8.684),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF34303E),
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.36,
              height: 1.3,
            ),
          ),
        ),
      ),
    );
  }
}

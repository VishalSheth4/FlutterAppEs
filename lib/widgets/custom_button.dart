// lib/widgets/custom_button.dart
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double padding;
  final double borderRadius;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.black,
    this.textColor = Colors.white,
    this.padding = 16.0,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full-width button
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color, // Correct property for background color
          padding: EdgeInsets.symmetric(vertical: padding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

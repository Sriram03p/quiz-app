import 'package:flutter/material.dart';

class AppStyles {
  // Text Styles
  static const headlineText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const bodyText = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  static const buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  // Padding Constants
  static const screenPadding = EdgeInsets.all(16.0);
  static const buttonPadding = EdgeInsets.symmetric(
    vertical: 14,
    horizontal: 24,
  );

  // Button Styles - Corrected implementation
  static final primaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: buttonPadding, // Now correctly placed in styleFrom
  );

  // Card Styles
  static final questionCard = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6,
        offset: Offset(0, 2),
      ),
    ],
  );

  // Alternative Button Style using ButtonStyle
  static final secondaryButton = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    // For ButtonStyle, padding is set through minimumSize and tapTargetSize
    minimumSize: MaterialStateProperty.all(
      Size(double.infinity, 48), // Width, Height
    ),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}
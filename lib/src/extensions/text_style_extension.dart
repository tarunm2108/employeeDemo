import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get regular => const TextStyle(
      );

  TextStyle get bold => const TextStyle(
        fontWeight: FontWeight.w600,
      );

  TextStyle get italic => const TextStyle(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
      );
}

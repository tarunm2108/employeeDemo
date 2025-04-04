import 'package:employee_demo/src/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';

class Utility {


  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle().regular.copyWith(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

import 'package:employee_demo/app_const/app_colors.dart';
import 'package:employee_demo/src/extensions/text_style_extension.dart';
import 'package:employee_demo/src/widgets/loader_widget.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool? showLoader;
  final EdgeInsets? margin;
  final bool? isWrapSize;
  final Color? textColor;
  final Color? bgColor;
  final double? width;

  const AppButtonWidget({
    required this.onPressed,
    required this.title,
    this.showLoader,
    this.margin,
    this.isWrapSize,
    this.textColor,
    this.bgColor,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return showLoader ?? false
        ? const LoaderWidget()
        : Container(
            width: isWrapSize ?? false ? double.maxFinite: width,
            margin: margin,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: bgColor ?? AppColors.color1DA1F2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
              elevation: 0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle().bold.copyWith(
                      fontSize: 15,
                      color: textColor ?? Colors.white,
                    ),
              ),
            ),
          );
  }
}

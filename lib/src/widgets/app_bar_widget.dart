import 'package:employee_demo/src/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? backButtonWidget;
  final bool? centerTitle;

  const AppBarWidget({
    this.title,
    this.actions,
    this.backButtonWidget,
    this.centerTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      leading: backButtonWidget,
      titleSpacing: 16,
      title: Text(
        title ?? '',
        style: const TextStyle().regular.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
      ),
      actions: actions,
      centerTitle: centerTitle ?? false,
      foregroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/cupertino.dart';

extension SpaceExtension on int {
  SizedBox get toSpace => SizedBox(
        height: toDouble(),
        width: toDouble(),
      );

  SizedBox get toHeight => SizedBox(
        height: toDouble(),
      );

  SizedBox get toWidth => SizedBox(
        width: toDouble(),
      );
}

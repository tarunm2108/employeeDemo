import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImageWidget extends StatelessWidget {
  final String source;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;

  const SvgImageWidget({
    super.key,
    required this.source,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
  });

  bool get isNetwork => source.startsWith('http') || source.startsWith('https');

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? SvgPicture.network(
            source,
            width: width,
            height: height,
            fit: fit,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          )
        : SvgPicture.asset(
            source,
            width: width,
            height: height,
            fit: fit,
            colorFilter: color != null
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          );
  }
}

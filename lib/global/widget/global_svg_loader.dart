import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/utils/enum.dart';
import '/utils/extension.dart';

class GlobalSvgLoader extends StatelessWidget {
  const GlobalSvgLoader({
    Key? key,
    required this.imagePath,
    this.height,
    this.width,
    this.fit,
    this.color,
    this.svgFor = SvgFor.asset,
  }) : super(key: key);
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final SvgFor? svgFor;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    if (svgFor == SvgFor.network) {
      return SvgPicture.network(
        imagePath,
        height: height,
        width: width,
        fit: fit ?? BoxFit.scaleDown,
        color: color,
        placeholderBuilder: (BuildContext context) => centerCircularProgress(),
      );
    } else {
      return SvgPicture.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        color: color,
      );
    }
  }
}
 
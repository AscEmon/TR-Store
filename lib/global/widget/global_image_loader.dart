import 'package:flutter/material.dart';
import 'package:tr_store/utils/enum.dart';
import 'package:tr_store/utils/network_connection.dart';

class GlobalImageLoader extends StatelessWidget {
  const GlobalImageLoader({
    Key? key,
    required this.imagePath,
    this.imageFor = ImageFor.asset,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);
  final String imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final ImageFor? imageFor;
  @override
  Widget build(BuildContext context) {
    if (imageFor == ImageFor.network) {
      return Image.network(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, exception, stackTrace) {
          if (NetworkConnection.instance.isInternet) {
            return const Text('😢');
          } else {
            return const Icon(Icons.wifi_off_rounded);
          }
        },
      );
    } else {
      return Image.asset(
        imagePath,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, exception, stackTrace) => const Text('😢'),
      );
    }
  }
}

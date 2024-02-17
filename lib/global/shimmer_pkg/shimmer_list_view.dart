import 'package:flutter/material.dart';
import 'package:tr_store/global/shimmer_pkg/shimmer.dart';

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({
    super.key,
    required this.child,
    this.itemCount,
  });
  final Widget child;
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    int totalItem = itemCount ?? 3;
    return Shimmer(
      linearGradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: ListView(
        children: List.generate(
          totalItem,
          (index) => child,
        ),
      ),
    );
  }
}

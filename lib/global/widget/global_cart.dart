import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalCart extends StatelessWidget {
  const GlobalCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.local_grocery_store,
        ),
        SizedBox(
          width: 20.w,
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/utils/app_routes.dart';

import '../../utils/navigation.dart';

class GlobalCart extends StatelessWidget {
  const GlobalCart({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigation.push(
          context,
          appRoutes: AppRoutes.cart,
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_grocery_store,
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
    );
  }
}

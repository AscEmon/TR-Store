import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/utils/extension.dart';

import '../../../../global/shimmer_pkg/shimmer_loading.dart';
import '../../../../utils/styles/styles.dart';

class ShimmerProductTile extends StatelessWidget {
  const ShimmerProductTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: ListTile(
        tileColor: KColor.fill.color,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6.r),
          child: Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: KColor.black.color,
            ),
          ),
        ),
        title: Container(
          height: 10.h,
          width: context.width * 0.25,
          color: KColor.black.color,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 40.h,
              width: context.width,
              color: KColor.black.color,
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 10.h,
                  width: context.width * 0.25,
                  color: KColor.black.color,
                ),
                const Spacer(),
                Container(
                  height: 10.h,
                  width: context.width * 0.25,
                  color: KColor.black.color,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/utils/extension.dart';

import '../../../../global/widget/global_text.dart';
import '../../../../utils/styles/styles.dart';
import '../../../products/model/products_response.dart';

class ProductDetailsContent extends StatelessWidget {
  const ProductDetailsContent({
    super.key,
    required this.productsDetailsData,
  });
  final Products productsDetailsData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalText(
                      str: "Product Name",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    GlobalText(
                      str: productsDetailsData.title ?? "",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      color: KColor.grey.color,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    width: 1.w,
                    color: KColor.enableBorder.color,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GlobalText(
                      str: "Price",
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    GlobalText(
                      str: productsDetailsData.id.toString(),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 6.h,
          ),
          GlobalText(
            str: "Description",
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
          GlobalText(
            str: productsDetailsData.content ?? "",
            fontSize: 10.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.justify,
            maxLines: 20,
            overflow: TextOverflow.ellipsis,
            color: KColor.grey.color,
          ),
        ],
      ),
    );
  }
}

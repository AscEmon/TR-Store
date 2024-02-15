import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_image_loader.dart';
import 'package:tr_store/modules/products/model/products_response.dart';
import 'package:tr_store/utils/enum.dart';

import '../../../../global/widget/global_text.dart';
import '../../../../utils/styles/styles.dart';

class ProductsTile extends StatelessWidget {
  const ProductsTile({
    super.key,
    required this.products,
  });

  final Products products;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: KColor.fill.color,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: GlobalImageLoader(
          imagePath: products.thumbnail ?? "",
          imageFor: ImageFor.network,
          fit: BoxFit.contain,
        ),
      ),
      title: GlobalText(
        str: products.title ?? "",
        fontSize: 10,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalText(
            str: products.content ?? "",
            maxLines: 4,
            fontSize: 10,
            color: KColor.grey.color,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 4.h,
          ),
          GlobalText(
            str: "Price : ${products.id}",
          ),
        ],
      ),
    );
  }
}
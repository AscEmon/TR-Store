import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_image_loader.dart';
import 'package:tr_store/modules/cart/bloc/cart_bloc.dart';
import 'package:tr_store/modules/cart/bloc/cart_event.dart';
import 'package:tr_store/modules/products/model/products_response.dart';
import 'package:tr_store/utils/enum.dart';

import '../../../../global/widget/global_text.dart';
import '../../../../utils/styles/styles.dart';

class ProductsTile extends StatelessWidget {
  const ProductsTile({
    super.key,
    required this.products,
    this.onTap,
  });

  final Products products;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: KColor.fill.color,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Hero(
          tag: "${products.id!}",
          child: GlobalImageLoader(
            imagePath: products.image ?? "",
            imageFor: ImageFor.network,
            fit: BoxFit.fill,
            width: 50.w,
            height: 40.h,
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlobalText(
                str: "Price : ${products.id}",
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<CartBloc>().add(DeleteProduct(products));
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GlobalText(
                      str: products.item?.toString() ?? "0",
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<CartBloc>().add(AddProduct(products));
                    },
                    child: const Icon(
                      Icons.add,
                      size: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_image_loader.dart';
import 'package:tr_store/modules/cart/bloc/cart_bloc.dart';
import 'package:tr_store/modules/cart/bloc/cart_state.dart';
import 'package:tr_store/modules/products/model/products_response.dart';
import 'package:tr_store/utils/enum.dart';

import 'global_increment_decrement.dart';
import 'global_text.dart';
import '../../utils/styles/styles.dart';

class GlobalProductTile extends StatelessWidget {
  const GlobalProductTile({
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
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return GlobalText(
                    str: "Price : ${products.price ?? products.id}",
                  );
                },
              ),
              const Spacer(),
              GlobalIncrementDecrement(
                products: products,
              ),
            ],
          )
        ],
      ),
    );
  }
}

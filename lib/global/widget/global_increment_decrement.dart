import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_text.dart';
import 'package:tr_store/utils/styles/k_colors.dart';

import '../../modules/cart/bloc/cart_bloc.dart';
import '../../modules/cart/bloc/cart_event.dart';
import '../../modules/cart/bloc/cart_state.dart';
import '../../modules/products/model/products_response.dart';
import '../../utils/enum.dart';

class GlobalIncrementDecrement extends StatelessWidget {
  const GlobalIncrementDecrement({
    super.key,
    required this.products,
  });
  final Products products;

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Row(
              children: [
                if (products.item! > 0) ...[
                  GestureDetector(
                    onTap: () {
                      cartBloc.add(AddProduct(products, Item.decrement));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: KColor.white.color.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          width: 1.w,
                          color: KColor.black.color,
                        ),
                      ),
                      child: const Icon(Icons.remove),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GlobalText(
                      str: products.item?.toString() ?? "0",
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
        GestureDetector(
          onTap: () {
            cartBloc.add(AddProduct(products, Item.increment));
          },
          child: Container(
            decoration: BoxDecoration(
              color: KColor.white.color.withOpacity(0.5),
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(
                width: 1.w,
                color: KColor.black.color,
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

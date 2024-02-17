import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_text.dart';

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
                    child: const Icon(Icons.remove, size: 16),
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
          child: const Icon(Icons.add, size: 16),
        ),
      ],
    );
  }
}

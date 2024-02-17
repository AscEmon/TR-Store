import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_text.dart';
import 'package:tr_store/modules/cart/bloc/cart_bloc.dart';
import 'package:tr_store/modules/cart/bloc/cart_event.dart';
import 'package:tr_store/modules/cart/bloc/cart_state.dart';
import 'package:tr_store/global/widget/global_product_tile.dart';
import 'package:tr_store/utils/app_routes.dart';
import 'package:tr_store/utils/view_util.dart';

import '../../../utils/navigation.dart';
import '../../../utils/styles/styles.dart';
import '/global/widget/global_appbar.dart';
import 'components/checkout_content.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: "Cart",
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              ViewUtil.showAlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const GlobalText(
                      str: "Are you sure you want to delete all the products?",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigation.pop(context);
                          },
                          child: const GlobalText(str: "No"),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<CartBloc>().add(DeleteAllProduct());
                            Navigation.pushAndRemoveUntil(
                              context,
                              appRoutes: AppRoutes.dashboard,
                            );
                          },
                          child: const GlobalText(str: "Yes"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            child: const Icon(Icons.delete),
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      bottomNavigationBar: const CheckoutContent(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  width: 1.w,
                  color: KColor.enableBorder.color,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return ListView.separated(
                          itemCount: state.carts!.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                          itemBuilder: (context, index) {
                            return GlobalProductTile(
                              products: state.carts![index],
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

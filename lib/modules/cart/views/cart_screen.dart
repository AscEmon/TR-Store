import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/modules/cart/bloc/cart_bloc.dart';
import 'package:tr_store/modules/cart/bloc/cart_state.dart';
import 'package:tr_store/modules/products/views/components/products_tile.dart';

import '../../../utils/styles/styles.dart';
import '/global/widget/global_appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: "Cart",
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
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
                            return ProductsTile(
                              products:state.carts![index],
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

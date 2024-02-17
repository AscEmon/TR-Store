import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_text.dart';
import 'package:tr_store/modules/cart/bloc/cart_bloc.dart';
import 'package:tr_store/modules/cart/bloc/cart_state.dart';
import 'package:tr_store/utils/app_routes.dart';
import 'package:tr_store/utils/view_util.dart';

import '../../utils/navigation.dart';

class GlobalCart extends StatelessWidget {
  const GlobalCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.carts?.isNotEmpty == true) {
              Navigation.push(
                context,
                appRoutes: AppRoutes.cart,
              );
            } else {
              ViewUtil.snackbar("No Product in Cart");
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(
                    Icons.local_grocery_store,
                  ),
                  if (state.carts?.isNotEmpty == true) ...[
                    Positioned(
                      right: -6,
                      top: -6,
                      child: CircleAvatar(
                        radius: 8,
                        child: GlobalText(
                          str: state.carts?.length.toString() ?? "",
                          fontSize: 8,
                        ),
                      ),
                    )
                  ]
                ],
              ),
              SizedBox(
                width: 20.w,
              )
            ],
          ),
        );
      },
    );
  }
}

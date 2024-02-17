import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/utils/extension.dart';

import '../../../../global/widget/global_button.dart';
import '../../../../global/widget/global_text.dart';
import '../../../../utils/styles/styles.dart';
import '../../bloc/cart_bloc.dart';
import '../../bloc/cart_state.dart';

class CheckoutContent extends StatelessWidget {
  const CheckoutContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: context.bottomNotch ? 30.h : 16,
        left: 10.w,
        right: 10.w,
      ),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(
              left: 20.w,
              top: 20.h,
              bottom: 20.h,
              right: 20.w,
            ),
            height: 72.h,
            decoration: BoxDecoration(
              color: KColor.secondary.color,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlobalText(
                  str: "Total Price :: ${state.totalPrice ?? 0}",
                  color: KColor.white.color,
                  textAlign: TextAlign.start,
                ),
                GlobalButton(
                  onPressed: () {},
                  buttonText: "Checkout ->",
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

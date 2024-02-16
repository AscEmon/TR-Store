import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_image_loader.dart';
import 'package:tr_store/modules/product_details/bloc/product_details_event.dart';
import 'package:tr_store/modules/product_details/bloc/product_details_state.dart';
import 'package:tr_store/utils/enum.dart';
import 'package:tr_store/utils/extension.dart';

import '../../../global/widget/global_cart.dart';
import '../../../utils/styles/styles.dart';
import '../bloc/product_details_bloc.dart';
import '/global/widget/global_appbar.dart';
import '/global/widget/global_text.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;
  const ProductDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProductDetailsBloc>();
    bloc.add(LoadProductDetailsEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: "Productdetails",
        centerTitle: true,
        actions: const [GlobalCart()],
      ),
      body: BlocBuilder<ProductDetailsBloc, ProductDetailstate>(
        builder: (context, state) {
          if (state.fetchRepoStatus == AppStatus.loading) {
            return Center(
              child: widget.centerCircularProgress(),
            );
          } else if (state.fetchRepoStatus == AppStatus.success) {
            if (state.productDetails != null) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Hero(
                      tag: "${widget.id}",
                      child: GlobalImageLoader(
                        imagePath: state.productDetails?.image ?? "",
                        imageFor: ImageFor.network,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
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
                                      str: state.productDetails?.title ?? "",
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
                                    vertical: 8.h, horizontal: 16.w),
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
                                      str: state.productDetails!.id.toString(),
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
                            str: state.productDetails?.content ?? "",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.justify,
                            maxLines: 20,
                            overflow: TextOverflow.ellipsis,
                            color: KColor.grey.color,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          } else if (state.fetchRepoStatus == AppStatus.error) {
            return Center(
              child: GlobalText(
                str: context.loc.error_occured,
                color: KColor.red.color,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_increment_decrement.dart';

import '../../../global/widget/global_cart.dart';
import '../../../utils/styles/styles.dart';
import '../../products/model/products_response.dart';
import '../bloc/product_details_bloc.dart';
import '/global/widget/global_appbar.dart';
import '/global/widget/global_image_loader.dart';
import '/global/widget/global_text.dart';
import '/modules/product_details/bloc/product_details_event.dart';
import '/modules/product_details/bloc/product_details_state.dart';
import '/modules/product_details/views/components/product_details_content.dart';
import '/utils/enum.dart';
import '/utils/extension.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Products products;
  const ProductDetailsScreen({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<ProductDetailsBloc>();
    bloc.add(LoadProductDetailsEvent(id: widget.products.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: "Productdetails",
        centerTitle: true,
        actions: const [
          GlobalCart(),
        ],
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
                      tag: "${widget.products.id}",
                      child: GlobalImageLoader(
                        imagePath: state.productDetails?.image ?? "",
                        imageFor: ImageFor.network,
                      ),
                    ),
                    ProductDetailsContent(
                      productsDetailsData: state.productDetails!,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          width: 1.w,
                          color: KColor.enableBorder.color,
                        ),
                      ),
                      child: GlobalIncrementDecrement(
                        products: widget.products,
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

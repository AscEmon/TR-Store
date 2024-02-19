import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/global/widget/global_product_tile.dart';
import 'package:tr_store/modules/cart/bloc/cart_bloc.dart';
import 'package:tr_store/modules/cart/bloc/cart_event.dart';
import 'package:tr_store/modules/products/bloc/products_bloc.dart';
import 'package:tr_store/modules/products/bloc/products_event.dart';
import 'package:tr_store/modules/products/bloc/products_state.dart';
import 'package:tr_store/utils/extension.dart';

import '../../../global/shimmer_pkg/shimmer_list_view.dart';
import '../../../global/widget/global_cart.dart';
import '../../../utils/app_routes.dart';
import '../../../utils/enum.dart';
import '../../../utils/navigation.dart';
import '../../../utils/styles/styles.dart';
import '/global/widget/global_appbar.dart';
import '/global/widget/global_text.dart';
import 'components/shimmer_product_tile.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProducsBloc>().add(LoadProductsEvent());
    context.read<CartBloc>().add(LoadDbCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: "Products",
        centerTitle: true,
        actions: const [GlobalCart()],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: BlocBuilder<ProducsBloc, ProductsState>(
                builder: (context, state) {
                  if (state.fetchRepoStatus == AppStatus.loading) {
                    return const ShimmerListView(
                      itemCount: 10,
                      child: ShimmerProductTile(),
                    );
                  } else if (state.fetchRepoStatus == AppStatus.success) {
                    if (state.products?.isNotEmpty == true) {
                      return ListView.separated(
                        itemCount: state.products!.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10.h,
                          );
                        },
                        itemBuilder: (context, index) {
                          return GlobalProductTile(
                            products: state.products![index],
                            onTap: () async {
                              Navigation.push(
                                context,
                                appRoutes: AppRoutes.productDetails,
                                arguments: state.products![index],
                              );
                            },
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: GlobalText(str: context.loc.no_data_found),
                      );
                    }
                  } else if (state.fetchRepoStatus == AppStatus.error) {
                    return Center(
                      child: GlobalText(
                        str: context.loc.error_occured,
                        color: KColor.red.color,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tr_store/modules/product_details/model/product_details_response.dart';

import '../../../utils/enum.dart';

@immutable
class ProductDetailstate {
  final AppStatus fetchRepoStatus;
  final ProductsDetailsData? productDetails;

  const ProductDetailstate({
    this.fetchRepoStatus = AppStatus.loading,
    this.productDetails,
  });

  ProductDetailstate copyWith({
    AppStatus? fetchRepoStatus,
    ProductsDetailsData? productDetails,
  }) {
    return ProductDetailstate(
      fetchRepoStatus: fetchRepoStatus ?? this.fetchRepoStatus,
      productDetails: productDetails ?? this.productDetails,
    );
  }
}

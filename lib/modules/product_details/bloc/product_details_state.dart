import 'package:flutter/material.dart';
import 'package:tr_store/modules/products/model/products_response.dart';

import '../../../utils/enum.dart';

@immutable
class ProductDetailstate {
  final AppStatus fetchRepoStatus;
  final Products? productDetails;

  const ProductDetailstate({
    this.fetchRepoStatus = AppStatus.loading,
    this.productDetails,
  });

  ProductDetailstate copyWith({
    AppStatus? fetchRepoStatus,
    Products? productDetails,
  }) {
    return ProductDetailstate(
      fetchRepoStatus: fetchRepoStatus ?? this.fetchRepoStatus,
      productDetails: productDetails ?? this.productDetails,
    );
  }
}

import 'package:flutter/material.dart';

import '../../../utils/enum.dart';
import '../model/products_response.dart';

@immutable
class ProductsState {
  final AppStatus fetchRepoStatus;
  final List<Products>? products;

  const ProductsState({
    this.fetchRepoStatus = AppStatus.loading,
    this.products,
  });

  ProductsState copyWith({
    AppStatus? fetchRepoStatus,
    List<Products>? products,
  }) {
    return ProductsState(
      fetchRepoStatus: fetchRepoStatus ?? this.fetchRepoStatus,
      products: products ?? this.products,
    );
  }
}

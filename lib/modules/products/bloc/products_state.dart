import 'package:flutter/material.dart';

import '../../../utils/enum.dart';
import '../model/products_response.dart';

@immutable
class ProductsState {
  final AppStatus fetchRepoStatus;
  final List<Products>? products;
  final bool isMoreLoaded;
  final ScrollController? scrollController;

  const ProductsState({
    this.fetchRepoStatus = AppStatus.loading,
    this.products,
    this.scrollController,
    this.isMoreLoaded = true,
  });

  ProductsState copyWith({
    AppStatus? fetchRepoStatus,
    List<Products>? products,
    int? page,
    bool? isMoreLoaded,
  }) {
    return ProductsState(
      fetchRepoStatus: fetchRepoStatus ?? this.fetchRepoStatus,
      products: products ?? this.products,
      scrollController: scrollController,
      isMoreLoaded: isMoreLoaded ?? this.isMoreLoaded,
    );
  }
}

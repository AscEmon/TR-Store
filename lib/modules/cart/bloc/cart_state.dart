import 'package:flutter/material.dart';
import 'package:tr_store/modules/products/model/products_response.dart';

@immutable
class CartState {
  final List<Products>? carts;

  const CartState({
    this.carts,
  });
  CartState copyWith({
    List<Products>? carts,
  }) {
    return CartState(
      carts: carts ?? this.carts,
    );
  }
}

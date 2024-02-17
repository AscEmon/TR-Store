import 'package:flutter/material.dart';
import 'package:tr_store/modules/products/model/products_response.dart';

@immutable
class CartState {
  final List<Products>? carts;
  final double? totalPrice;
  final Products? productById;

  const CartState({
    this.carts,
    this.totalPrice,
    this.productById,
  });
  CartState copyWith({
    List<Products>? carts,
    double? totalPrice,
    final Products? productById,
  }) {
    return CartState(
      carts: carts ?? this.carts,
      totalPrice: totalPrice ?? this.totalPrice,
      productById: productById ?? this.productById,
    );
  }
}

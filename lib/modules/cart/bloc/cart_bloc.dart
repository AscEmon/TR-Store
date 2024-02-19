import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/data_provider/local_db/db_provider.dart';
import 'package:tr_store/modules/cart/bloc/cart_event.dart';
import 'package:tr_store/modules/cart/bloc/cart_state.dart';
import 'package:tr_store/utils/enum.dart';

import '../../products/model/products_response.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(carts: [])) {
    on<AddProduct>(_addProductInCart);
    on<DeleteAllProduct>(_deleteAllProduct);
  }

  _addProductInCart(AddProduct event, Emitter<CartState> emit) async {
    int? index =
        state.carts?.indexWhere((element) => element.id == event.products.id);
   

    if (index == -1) {
      final carts = [...state.carts!, event.products];
      emit(state.copyWith(carts: carts));
    }

    _updateProduct(event, emit);
  }

  _updateProduct(AddProduct event, Emitter<CartState> emit) async {
    final Products products = _productIncrementDecrement(event);
    _calculateSingleProductPrice(products);
    _removeProductFromCart(products);

    final newCarts = state.carts!
        .map((element) => element.id == event.products.id ? products : element)
        .toList();
    _calculateTotalPrice(newCarts, emit);
    emit(state.copyWith(carts: newCarts));
  }

  Products _productIncrementDecrement(AddProduct event) {
    final products =
        state.carts!.where((element) => element.id == event.products.id).first;
    int item = products.item ?? 0;

    switch (event.item) {
      case Item.increment:
        item++;
        break;
      case Item.decrement:
        if (item > 0) {
          item--;
        }
        break;
    }
    products.item = item;
    return products;
  }

  _removeProductFromCart(Products products) {
    if (products.item == 0) {
      state.carts?.remove(products);
    }
  }

  _calculateSingleProductPrice(Products products) {
    products.price = products.item! * products.id!;
  }

  _calculateTotalPrice(List<Products> newCarts, Emitter<CartState> emit) {
    emit(state.copyWith(
        totalPrice: newCarts.fold<double>(0, (p, e) => p + e.price!)));
  }

  _deleteAllProduct(DeleteAllProduct event, Emitter<CartState> emit) {
    state.carts?.clear();
    DBProvider.db.deleteAllCart();
    emit(state.copyWith(carts: [], totalPrice: 0));
  }
}

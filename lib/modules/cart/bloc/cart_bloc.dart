import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/modules/cart/bloc/cart_event.dart';
import 'package:tr_store/modules/cart/bloc/cart_state.dart';

import '../repository/cart_interface.dart';
import '../repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository _cartRepository = CartRepository();

  CartBloc() : super(const CartState(carts: [])) {
    on<AddProduct>(_addProductInCart);
  }

  _addProductInCart(AddProduct event, Emitter<CartState> emit) async {
    int? index =
        state.carts?.indexWhere((element) => element.id == event.products.id);

    if (index == -1) {
      final carts = [...state.carts!, event.products];
      emit(state.copyWith(carts: carts));
    } 
  }
}

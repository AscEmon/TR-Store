import '../../products/model/products_response.dart';

sealed class CartEvent {}

class LoadCarts implements CartEvent {}

class AddProduct implements CartEvent {
  final Products products;
  AddProduct(this.products);
}

class DeleteProduct implements CartEvent {
  final Products products;
  DeleteProduct(this.products);
}

import '../../../utils/enum.dart';
import '../../products/model/products_response.dart';

sealed class CartEvent {}

class LoadCarts implements CartEvent {}

class AddProduct implements CartEvent {
  final Products products;
  final Item item;
  AddProduct(
    this.products,
    this.item,
  );
}

class DeleteAllProduct implements CartEvent {}

class LoadDbCart implements CartEvent {}

class GetProductByID implements CartEvent {
  final int id;
  GetProductByID({
    required this.id,
  });
}

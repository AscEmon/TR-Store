import 'package:flutter/material.dart';
import 'package:tr_store/modules/products/model/products_response.dart';

@immutable
abstract class IProductsRepository {
  Future<List<Products>> fetchProducts();
}

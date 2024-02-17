import 'package:flutter/material.dart';
import 'package:tr_store/modules/products/model/products_response.dart';

@immutable
abstract class IProductDetailsRepository {
  Future<Products> fetchProductDetails({required int id});
}

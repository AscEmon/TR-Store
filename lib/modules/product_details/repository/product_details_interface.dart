import 'package:flutter/material.dart';

import '../model/product_details_response.dart';

@immutable
abstract class IProductDetailsRepository {
  Future<ProductsDetailsData> fetchProductDetails({required int id});
}

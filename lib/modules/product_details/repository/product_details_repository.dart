import 'dart:async';

import 'package:tr_store/modules/products/model/products_response.dart';
import 'package:tr_store/utils/extension.dart';

import '../../../constant/app_url.dart';
import '../../../utils/enum.dart';
import '../../../utils/network_request_builder.dart';
import 'product_details_interface.dart';

class ProductDetailsRepository implements IProductDetailsRepository {
  @override
  Future<Products> fetchProductDetails({
    required int id,
  }) async {
    Completer<Products> completer = Completer<Products>();

    try {
      NetworkRequestBuilder()
          .setUrl("${AppUrl.productDetails.url}$id")
          .setMethod(Method.GET)
          .setOnSuccess((response) async {
        final movies = productsFromJson(response.data);
        if (movies.isNotEmpty) {
          completer.complete(movies.where((element) => element.id == id).first);
        } else {
          completer.complete(Products());
        }
      }).setOnFailed((errorMessage) {
        completer.completeError(errorMessage);
      }).executeNetworkRequest();
    } catch (e) {
      "$e".log();
    }

    return completer.future;
  }
}

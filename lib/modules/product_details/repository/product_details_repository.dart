import 'dart:async';

import 'package:tr_store/utils/extension.dart';

import '../../../constant/app_url.dart';
import '../../../utils/enum.dart';
import '../../../utils/network_request_builder.dart';
import '../model/product_details_response.dart';
import 'product_details_interface.dart';

class ProductDetailsRepository implements IProductDetailsRepository {
  @override
  Future<List<ProductsDetailsData>> fetchProductDetails({
    required int id,
  }) async {
    Completer<List<ProductsDetailsData>> completer =
        Completer<List<ProductsDetailsData>>();

    try {
      NetworkRequestBuilder()
          .setUrl("${AppUrl.productDetails.url}$id")
          .setMethod(Method.GET)
          .setOnSuccess((response) async {
        final movies = productDetailsFromJson(response.data);
        if (movies.isNotEmpty) {
          completer.complete(movies);
        } else {
          completer.complete([]);
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

import 'dart:async';

import 'package:tr_store/modules/products/model/products_response.dart';
import 'package:tr_store/utils/extension.dart';

import '../../../constant/app_url.dart';
import '../../../utils/enum.dart';
import '../../../utils/network_request_builder.dart';
import 'products_interface.dart';

class ProductsRepository implements IProductsRepository {
  @override
  Future<List<Products>> fetchProducts() async {
    Completer<List<Products>> completer = Completer<List<Products>>();

    try {
      NetworkRequestBuilder()
          .setUrl(AppUrl.products.url)
          .setMethod(Method.GET)
          .setOnSuccess((response) async {
        final movies = productsFromJson(response.data);
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

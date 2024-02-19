import 'dart:async';

import 'package:dio/dio.dart';
import 'package:tr_store/data_provider/local_db/db_provider.dart';
import 'package:tr_store/modules/products/model/products_response.dart';
import 'package:tr_store/utils/extension.dart';

import '../../../constant/app_url.dart';
import '../../../utils/enum.dart';
import '../../../utils/network_connection.dart';
import '../../../utils/network_request_builder.dart';
import 'products_interface.dart';

class ProductsRepository implements IProductsRepository {
  @override
  Future<List<Products>> fetchProducts() async {
    Completer<List<Products>> completer = Completer<List<Products>>();

    try {
      if (NetworkConnection.instance.isInternet == false) {
        List<Products> cachedData = await _loadCachedData();
        if (cachedData.isNotEmpty) {
          completer.complete(cachedData);
        } else {
          _makeNetworkRequest(completer);
        }
      } else {
        _makeNetworkRequest(completer);
      }
    } catch (e) {
      "loading data from Hive: $e".log();
    }

    return completer.future;
  }

  Future<List<Products>> _loadCachedData() async {
    return DBProvider.db.getAllProducts();
  }

  void _makeNetworkRequest(Completer<List<Products>> completer) {
    NetworkRequestBuilder()
        .setUrl(AppUrl.products.url)
        .setMethod(Method.GET)
        .setOnSuccess((response) async {
      final products = productsFromJson(response.data);

      if (products.isNotEmpty) {
        await _saveDataToDb(response);
        completer.complete(products);
      } else {
        completer.complete([]);
      }
    }).setOnFailed((errorMessage) {
      completer.completeError(errorMessage);
    }).executeNetworkRequest();
  }

  Future<void> _saveDataToDb(Response<dynamic> response) async {
    (response.data as List).map((e) {
      DBProvider.db.createProduct(Products.fromJson(e));
    }).toList();
  }
}

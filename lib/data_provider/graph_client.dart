import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '/utils/extension.dart';
import '/constant/app_url.dart';
import '/constant/constant_key.dart';
import '/data_provider/pref_helper.dart';
import '/global/model/graph_ql_error_response.dart';
import '/utils/navigation.dart';
import '/utils/view_util.dart';

class ApiClient {
  late d.Dio _dio;

  Map<String, dynamic> _header = {};

  _initDio() {
    _header = {
      HttpHeaders.contentTypeHeader: AppConstant.APPLICATION_JSON.key,
      HttpHeaders.authorizationHeader:
          "${AppConstant.BEARER.key} ${PrefHelper.getString(AppConstant.TOKEN.key)}"
    };

   _dio.options = BaseOptions(
      baseUrl: AppUrl.base.url,
      headers: _header,
      connectTimeout: const Duration(milliseconds: 60 * 1000), //miliseconds
      sendTimeout: const Duration(milliseconds: 60 * 1000),
      receiveTimeout: const Duration(milliseconds: 60 * 1000),
    );
    _initInterceptors();
  }

  
  void _initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      debugPrint(
          'REQUEST[${options.method}] => PATH: ${AppUrl.base.url}${options.path} '
          '=> Request Values: param: ${options.queryParameters}, DATA: ${options.data}, => _HEADERS: ${options.headers}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      debugPrint(
          'RESPONSE[${response.statusCode}] => DATA: ${response.data} URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}');
      return handler.next(response);
    }, onError: (err, handler) {
      debugPrint(
          'ERROR[${err.response?.statusCode}] => DATA: ${err.response?.data} Message: ${err.message} URL: ${err.response?.requestOptions.baseUrl}${err.response?.requestOptions.path}');
      return handler.next(err);
    }));
  }

//This requestFormData is actually for REST API
//Usign this we sent multipart file thats why its argument
//is different in request method
  Future requestFormData(String url, Map<String, File>? files,
      {bool isLoaderShowing = false}) async {
    try {
      if (isLoaderShowing) CircularProgressIndicator();

      d.Response response;
      _header[d.Headers.contentTypeHeader] = 'multipart/form-data';
      _initDio();

      Map<String, d.MultipartFile> fileMap = {};
      if (files != null) {
        for (MapEntry fileEntry in files.entries) {
          File file = fileEntry.value;
          fileMap[fileEntry.key] = await d.MultipartFile.fromFile(file.path);
        }
      }

      Map<String, dynamic> params = Map<String, dynamic>();
      params.addAll(fileMap);
      final data = d.FormData.fromMap(params);

      // Handle response code from api
      response = await _dio.post(url, data: data);

      if (isLoaderShowing) Navigation.pop(Navigation.key.currentContext);

      if (response.statusCode == 200) {
        return response;
      } else {
        _showExceptionSnackBar("Something went wrong");
        throw Exception();
      }

      // Handle Error type if dio catches anything
    } on d.DioError catch (e) {
      _dioErrorHandler(isLoaderShowing, e);
    } catch (e) {
      throw Exception();
    }
  }

  //GraphQL client using dio for Mutation and query
  Future request(
      {String body = "",
      String url = '',
      Map<String, dynamic> variables = const {},
      bool isLoaderShowing = false}) async {
    if (isLoaderShowing) const CircularProgressIndicator();

    d.Response response;
    _initDio();

    try {
      String paramJson = ''' 
      {
      "query" : "$body",
      "variables" : ${jsonEncode(variables)}
      }
      '''
          .replaceAll("", "");

      response = await _dio.post(url, data: paramJson);

      if (isLoaderShowing) Navigation.pop(Navigation.key.currentContext);

      if (response.statusCode == 200) {
        if (response.data['errors'] != null) {
          handleGraphQlError(response);
        } else {
          return response;
        }
      } else {
        _showExceptionSnackBar("Something went wrong");
        throw Exception();
      }

      // Handle Error type if dio catches anything
    } on d.DioError catch (e) {
      _dioErrorHandler(isLoaderShowing, e);
    } catch (e) {
      throw Exception();
    }
  }

  void handleGraphQlError(d.Response response) {
    try {
      final result = GraphQLErrorResponse.fromJson(response.data);

      if (result != null) {
        if (result.errors.isNotEmpty) {
          if (result.errors[0].message == "Invalid User" ||
              result.errors[0].message == "User does not exist") {
            PrefHelper.logout();
           
          } else {
            _showExceptionSnackBar(result.errors[0].message);
          }
        }
      }
    } catch (e) {}
  }
void _dioErrorHandler(bool isLoaderShowing, DioException error) {
 if (isLoaderShowing) Navigation.pop(Navigation.key.currentContext!);
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        ViewUtil.SSLSnackbar("Time out delay ");
        break;
      case DioExceptionType.receiveTimeout:
        ViewUtil.SSLSnackbar("Server is not responded properly");
        break;
      case DioExceptionType.unknown:
        ViewUtil.SSLSnackbar("Server is not responded properly");
        break;
      case DioExceptionType.connectionError:
        ViewUtil.SSLSnackbar("Connection error");
        break;
      case DioExceptionType.cancel:
        ViewUtil.SSLSnackbar("Connection cancel");
        break;

      case DioExceptionType.badCertificate:
        ViewUtil.SSLSnackbar("Incorrect certificate error");
        break;
      case DioExceptionType.sendTimeout:
        ViewUtil.SSLSnackbar("Send timeout error");
        break;
      case DioExceptionType.badResponse:
        final Map data = json.decode(error.response.toString());
        if (error.response?.statusCode == 502) {
          ViewUtil.SSLSnackbar("Something went wrong");
        } else {
          data.log();
        }

        break;

      default:
        ViewUtil.SSLSnackbar("Something went wrong");
        break;
    }
  }

  static _showExceptionSnackBar(String? msg) async {
    ViewUtil.SSLSnackbar(msg ?? "");
  }
}


 
 
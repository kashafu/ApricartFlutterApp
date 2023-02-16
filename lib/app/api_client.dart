import 'dart:developer';

import 'package:apricart/widgets/snackbars/app_default_snackbars.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'exceptions.dart';

class ApiClient {
  static String get _baseUrl => 'https://cbe.apricart.pk/v1';
  static int get _requestTimeout => 25;

  static final Dio _client = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      validateStatus: (status) => true,
    ),
  );

  static Future get(String endpoint, {Map<String, dynamic>? headers, CancelToken? cancelToken}) async {
    try {
      Response response = await _client
          .get(
            endpoint,
            cancelToken: cancelToken,
            options: Options(headers: headers, responseType: ResponseType.json),
          )
          .timeout(Duration(seconds: _requestTimeout));
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw (response);
    } catch (e) {
      if (e is Response) {
        throw (_getExceptionFromResponce(e));
      }

      if (e is DioError) {
        if (e.type == DioErrorType.cancel) {
          return;
        }
      }
      AppDefaultSnackbars.showErrorSnackbar("Please check your internet connection");
      throw (InternetConnectivityException());
    }
  }

  static Future post(String endpoint, {dynamic data, Map<String, dynamic>? headers, CancelToken? cancelToken}) async {
    try {
      Response response = await _client
          .post(
            endpoint,
            data: data,
            cancelToken: cancelToken,
            options: Options(headers: headers, responseType: ResponseType.json),
          )
          .timeout(Duration(seconds: _requestTimeout));
      log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw (response);
    } catch (e) {
      if (e is Response) {
        throw (_getExceptionFromResponce(e));
      }
      AppDefaultSnackbars.showErrorSnackbar("Please check your internet connection");
      throw (InternetConnectivityException());
    }
  }

  static Future delete(String endpoint, {dynamic data, Map<String, dynamic>? headers, CancelToken? cancelToken}) async {
    try {
      Response response = await _client
          .delete(
            endpoint,
            data: data,
            cancelToken: cancelToken,
            options: Options(headers: headers, responseType: ResponseType.json),
          )
          .timeout(Duration(seconds: _requestTimeout));
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw (response);
    } catch (e) {
      if (e is Response) {
        throw (_getExceptionFromResponce(e));
      }
      AppDefaultSnackbars.showErrorSnackbar("Please check your internet connection");
      throw (InternetConnectivityException());
    }
  }

  static Future postSTAG(String endpoint,
      {dynamic data, Map<String, dynamic>? headers, CancelToken? cancelToken}) async {
    try {
      Response response = await Dio(
        BaseOptions(
          baseUrl: "https://stag.apricart.pk/v1",
          validateStatus: (status) => true,
        ),
      )
          .post(
            endpoint,
            data: data,
            cancelToken: cancelToken,
            options: Options(headers: headers, responseType: ResponseType.json),
          )
          .timeout(Duration(seconds: _requestTimeout));
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw (response);
    } catch (e) {
      if (e is Response) {
        throw (_getExceptionFromResponce(e));
      }
      AppDefaultSnackbars.showErrorSnackbar("Please check your internet connection");
      throw (InternetConnectivityException());
    }
  }

  static Exception _getExceptionFromResponce(Response resp) {
    if (resp.data is Map<String, dynamic>) {
      if ((resp.data as Map<String, dynamic>).containsKey("message")) {
        if (resp.data["message"].toString().isNotEmpty) {
          AppDefaultSnackbars.showErrorSnackbar(resp.data["message"].toString());
          return NetworkException(resp.data["message"]);
        } else {
          AppDefaultSnackbars.showErrorSnackbar("Something went wrong");
          return NetworkException("Something went wrong");
        }
      } else {
        AppDefaultSnackbars.showErrorSnackbar("Something went wrong");
        return NetworkException("Something went wrong");
      }
    } else {
      AppDefaultSnackbars.showErrorSnackbar(resp.data.toString());
      return NetworkException(resp.data.toString());
    }
  }
}

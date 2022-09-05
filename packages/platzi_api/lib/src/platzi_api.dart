/// {@template platzi_api}
/// My new Flutter package
/// {@endtemplate}
// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:platzi_api/src/models/category.dart';
import 'package:platzi_api/src/models/product.dart';
import 'package:platzi_api/src/models/user.dart';

// Exception for http requrest
class HttpException implements Exception {}

// Exception for a request with 200 status code
class HttpRequestFailure implements Exception {
  const HttpRequestFailure(this.statusCode);
  final int statusCode;
}

// Exception for decode fail
class JsonDecodeException implements Exception {}

//
class JsonDeserializationException implements Exception {}

// Api Client
class DataPlatziApiClient {
  DataPlatziApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  String endPoint = "api.escuelajs.co";
  final http.Client _httpClient;

  Future<List<Product>> products() async {
    final uri = Uri.http(endPoint, "/api/v1/products");
    return _fecthProducts(uri);
  }

  Future<List<Product>> _fecthProducts(Uri uri) async {
    http.Response response;
    List body;
    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpException();
    }
    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }
    try {
      body = json.decode(response.body) as List;
    } on Exception {
      throw JsonDecodeException();
    }
    try {
      return body
          .map((dynamic item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw JsonDeserializationException();
    }
  }

  Future<Product> simpleProduct({required int index}) async {
    final uri = Uri.http(endPoint, '/api/v1/products/$index');
    return _fecthProduct(uri);
  }

  Future<Product> _fecthProduct(Uri uri) async {
    http.Response response;
    Product body;
    Map<String, dynamic> bodyJson;
    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpException();
    }
    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }
    try {
      bodyJson = json.decode(response.body) as Map<String, dynamic>;
    } on Exception {
      throw JsonDecodeException();
    }
    try {
      body = Product.fromJson(bodyJson);
      return body;
    } on Exception {
      throw JsonDeserializationException();
    }
  }

  // Functions to get categories
  Future<List<Category>> categories() async {
    final uri = Uri.http(endPoint, '/api/v1/categories');
    return _fecthCategories(uri);
  }

  Future<List<Category>> _fecthCategories(Uri uri) async {
    http.Response response;
    List body;
    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpException();
    }
    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }
    try {
      body = json.decode(response.body) as List;
    } on Exception {
      throw JsonDecodeException();
    }
    try {
      return body
          .map(
              (dynamic item) => Category.fromJson(item as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw JsonDeserializationException();
    }
  }

  // Function to get Users
  Future<List<User>> users() async {
    final uri = Uri.http(endPoint, '/api/v1/users');
    return _fecthUsers(uri);
  }

  Future<List<User>> _fecthUsers(Uri uri) async {
    http.Response response;
    List body;
    try {
      response = await _httpClient.get(uri);
    } on Exception {
      throw HttpException();
    }
    if (response.statusCode != 200) {
      throw HttpRequestFailure(response.statusCode);
    }
    try {
      body = json.decode(response.body) as List;
    } on Exception {
      throw JsonDecodeException();
    }
    try {
      return body
          .map((dynamic item) => User.fromJson(item as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw JsonDeserializationException();
    }
  }
}

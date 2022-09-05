/// {@template platzi_repository}
/// My new Flutter package
/// {@endtemplate}
// ignore_for_file: public_member_api_docs, use_super_parameters
import 'package:platzi_api/platzi_api.dart';

class PlatziException implements Exception {
  const PlatziException(this.exception, {required this.stackTrace});

  final dynamic exception;
  final StackTrace stackTrace;
}

class SimpleProductHttpRequestFailure extends PlatziException {
  SimpleProductHttpRequestFailure(
    HttpRequestFailure failure,
    StackTrace stackTrace,
  ) : super(failure, stackTrace: stackTrace);
}

class AllProductsHttpException extends PlatziException {
  AllProductsHttpException(
    HttpException exception, {
    required StackTrace stackTrace,
  }) : super(exception, stackTrace: stackTrace);
}

class AllProductsHttpRequestFailure extends PlatziException {
  AllProductsHttpRequestFailure(
    HttpRequestFailure failure, {
    required StackTrace stackTrace,
  }) : super(failure, stackTrace: stackTrace);
}

class AllProductsJsonDecodeException extends PlatziException {
  AllProductsJsonDecodeException(
    JsonDecodeException jsonDecodeException, {
    required StackTrace stackTrace,
  }) : super(jsonDecodeException, stackTrace: stackTrace);
}

class AllProductsJsonDeserializationException extends PlatziException {
  AllProductsJsonDeserializationException(
    JsonDeserializationException jsonDeserializationException, {
    required StackTrace stackTrace,
  }) : super(jsonDeserializationException, stackTrace: stackTrace);
}

class PlatziRepository {
  /// {@macro platzi_repository}
  PlatziRepository({DataPlatziApiClient? dataPlatziApiClient})
      : _dataPlatziApiClient = dataPlatziApiClient ?? DataPlatziApiClient();

  final DataPlatziApiClient _dataPlatziApiClient;

  // Return a description of a product
  Future<String> simpleProductDescription({required int index}) async {
    try {
      final product = await _dataPlatziApiClient.simpleProduct(index: index);
      return product.description;
    } on HttpRequestFailure catch (e, stackTrace) {
      throw SimpleProductHttpRequestFailure(e, stackTrace);
    }
  }

  // Return a list of description of the products
  Future<List<String>> allProducts() async {
    List<Product> products;
    try {
      products = await _dataPlatziApiClient.products();
    } on HttpException catch (e, stackTrace) {
      throw AllProductsHttpException(e, stackTrace: stackTrace);
    } on HttpRequestFailure catch (e, stackTrace) {
      throw AllProductsHttpRequestFailure(e, stackTrace: stackTrace);
    } on JsonDecodeException catch (e, stackTrace) {
      throw AllProductsJsonDecodeException(e, stackTrace: stackTrace);
    } on JsonDeserializationException catch (e, stackTrace) {
      throw AllProductsJsonDeserializationException(e, stackTrace: stackTrace);
    } on Exception catch (e) {
      throw Exception(e);
    }
    return products.map((product) => product.description).toList();
  }
}

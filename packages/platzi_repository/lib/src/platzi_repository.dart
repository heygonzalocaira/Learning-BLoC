/// {@template platzi_repository}
/// My new Flutter package
/// {@endtemplate}
// ignore_for_file: public_member_api_docs, use_super_parameters
import 'package:platzi_api/platzi_api.dart';
import 'package:platzi_repository/platzi_repository.dart';

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

class MessageException implements Exception {
  MessageException(
    this.messsage,
    this.exception,
  );
  final String messsage;
  final dynamic exception;
}

class ProductsHttpException extends PlatziException {
  ProductsHttpException(
    HttpException exception, {
    required StackTrace stackTrace,
  }) : super(exception, stackTrace: stackTrace);
}

class ProductsHttpRequestFailure extends PlatziException {
  ProductsHttpRequestFailure(
    HttpRequestFailure failure, {
    required StackTrace stackTrace,
  }) : super(failure, stackTrace: stackTrace);
}

class ProductsJsonDecodeException extends PlatziException {
  ProductsJsonDecodeException(
    JsonDecodeException jsonDecodeException, {
    required StackTrace stackTrace,
  }) : super(jsonDecodeException, stackTrace: stackTrace);
}

class ProductsJsonDeserializationException extends PlatziException {
  ProductsJsonDeserializationException(
    JsonDeserializationException jsonDeserializationException, {
    required StackTrace stackTrace,
  }) : super(jsonDeserializationException, stackTrace: stackTrace);
}

class ProductsJsonEmpty extends PlatziException {
  ProductsJsonEmpty(
    dynamic exception, {
    required StackTrace stackTrace,
  }) : super(exception, stackTrace: stackTrace);
}

class PlatziRepository {
  /// {@macro platzi_repository}
  PlatziRepository({DataPlatziApiClient? dataPlatziApiClient})
      : _dataPlatziApiClient = dataPlatziApiClient ?? DataPlatziApiClient();

  final DataPlatziApiClient _dataPlatziApiClient;
  List<ProductRepository> get products => _products;
  final List<ProductRepository> _products = [];
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
      return products.map((product) => product.description).toList();
    } on HttpException catch (e, stackTrace) {
      throw ProductsHttpException(e, stackTrace: stackTrace);
    } on HttpRequestFailure catch (e, stackTrace) {
      throw ProductsHttpRequestFailure(e, stackTrace: stackTrace);
    } on JsonDecodeException catch (e, stackTrace) {
      throw ProductsJsonDecodeException(e, stackTrace: stackTrace);
    } on JsonDeserializationException catch (e, stackTrace) {
      throw ProductsJsonDeserializationException(e, stackTrace: stackTrace);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  // Return a range of products
  Future<List<ProductRepository>> rangeProducts() async {
    try {
      final products =
          await _dataPlatziApiClient.rangeProducts(_products.length);
      final jsonProducts = products.map((item) => item.toJson()).toList();
      final productsProvider =
          jsonProducts.map(ProductRepository.fromJson).toList();
      _products.addAll(productsProvider);
    } on HttpException catch (e, stackTrace) {
      throw ProductsHttpException(e, stackTrace: stackTrace);
    } on HttpRequestFailure catch (e, stackTrace) {
      throw ProductsHttpRequestFailure(e, stackTrace: stackTrace);
    } on JsonDecodeException catch (e, stackTrace) {
      throw ProductsJsonDecodeException(e, stackTrace: stackTrace);
    } on JsonDeserializationException catch (e, stackTrace) {
      throw ProductsJsonDeserializationException(e, stackTrace: stackTrace);
    } on JsonEmptyException catch (e, stackTrace) {
      throw ProductsJsonEmpty(e, stackTrace: stackTrace);
    } on Exception catch (e) {
      throw Exception(e);
    }
    return _products;
  }
}

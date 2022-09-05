part of 'product_cubit.dart';

enum ProductStatus { loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product> products;
  final String errorMessage;
  final StackTrace? stackTrace;
  const ProductState({
    this.status = ProductStatus.loading,
    this.products = const <Product>[],
    this.errorMessage = "",
    this.stackTrace,
  });
  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? errorMessage,
    StackTrace? stackTrace,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  List<Object?> get props => [status, products];
}

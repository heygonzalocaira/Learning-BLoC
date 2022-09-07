part of 'product_cubit.dart';

enum ProductStatus {
  initial,
  loading,
  success,
  failure,
  sucessEmpty,
  failureLoadingMore,
}

class ProductState extends Equatable {
  final ProductStatus status;
  final List<ProductRepository> products;
  final String errorMessage;
  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <ProductRepository>[],
    this.errorMessage = "",
  });
  ProductState copyWith({
    ProductStatus? status,
    List<ProductRepository>? products,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, products];
}

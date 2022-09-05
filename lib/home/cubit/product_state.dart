part of 'product_cubit.dart';

enum ProductStatus { loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final List<Product> products;
  final String errorMessage;
  ProductState({
    this.status = ProductStatus.loading,
    this.products = const <Product>[],
    this.errorMessage = "",
  });
  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductState(
        status: status ?? this.status,
        products: products ?? this.products,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  //ProductState.loading() : this._();
  //ProductState.success({
  //  required List<Product> products,
  //}) : this._(status: ProductStatus.success, products: products);
  //ProductState.failure() : this._(status: ProductStatus.failure);

  @override
  List<Object?> get props => [status, products];
}

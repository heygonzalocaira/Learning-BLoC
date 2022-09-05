import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_app/home/models/product.dart';
import 'package:meta/meta.dart';
import 'package:platzi_repository/platzi_repository.dart';
import 'package:equatable/equatable.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._platziRepository) : super(ProductState());
  final PlatziRepository _platziRepository;

  Future<void> getProducts() async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final results = await _platziRepository.allProducts();
      final productsDescription = results.map(Product.new).toList();
      //throw AllProductsException();
      emit(state.copyWith(
          status: ProductStatus.success, products: productsDescription));
      //emit(ProductState.success(products: productsDescription));
    } on AllProductsException catch (error) {
      emit(state.copyWith(
          status: ProductStatus.failure, errorMessage: error.toString()));
    }
  }
}

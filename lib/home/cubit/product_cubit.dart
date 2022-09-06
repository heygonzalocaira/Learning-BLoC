// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:bloc_app/home/models/product.dart';
import 'package:platzi_repository/platzi_repository.dart';
import 'package:equatable/equatable.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._platziRepository) : super(const ProductState());
  final PlatziRepository _platziRepository;

  Future<void> getProducts() async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final results = await _platziRepository.allProducts();
      final productsDescription = results.map(Product.new).toList();

      emit(state.copyWith(
          status: ProductStatus.success, products: productsDescription));
    } on AllProductsHttpException catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on AllProductsHttpRequestFailure catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on AllProductsJsonDecodeException catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on AllProductsJsonDeserializationException catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on Exception catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> getRangeProducts() async {
    if (state.status != ProductStatus.initial) {
      emit(state.copyWith(status: ProductStatus.loading));
    }
    try {
      final results = await _platziRepository.rangeProducts();
      final productsDescription = results.map((item) => Product(item)).toList();

      emit(state.copyWith(
          status: ProductStatus.success, products: productsDescription));
    } on AllProductsHttpException catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on AllProductsHttpRequestFailure catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on AllProductsJsonDecodeException catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on AllProductsJsonDeserializationException catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on Exception catch (error) {
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:platzi_repository/platzi_repository.dart';
import 'package:equatable/equatable.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._platziRepository) : super(const ProductState());
  final PlatziRepository _platziRepository;

  Future<void> getRangeProducts() async {
    if (state.status != ProductStatus.initial) {
      emit(state.copyWith(status: ProductStatus.loading));
    }
    try {
      final results = await _platziRepository.rangeProducts();
      emit(state.copyWith(status: ProductStatus.success, products: results));
    } on ProductsJsonEmpty catch (error) {
      if (ProductStatus.loading == state.status) {
        emit(state.copyWith(
            status: ProductStatus.failureLoadingMore,
            errorMessage: error.toString()));
        return;
      }
      emit(state.copyWith(
        status: ProductStatus.sucessEmpty,
        errorMessage: error.toString(),
      ));
    } on ProductsHttpException catch (error) {
      if (ProductStatus.loading == state.status) {
        emit(state.copyWith(
            status: ProductStatus.failureLoadingMore,
            errorMessage: error.toString()));
        return;
      }
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on ProductsHttpRequestFailure catch (error) {
      if (ProductStatus.loading == state.status) {
        emit(state.copyWith(
            status: ProductStatus.failureLoadingMore,
            errorMessage: error.toString()));
        return;
      }
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on ProductsJsonDecodeException catch (error) {
      if (ProductStatus.loading == state.status) {
        emit(state.copyWith(
            status: ProductStatus.failureLoadingMore,
            errorMessage: error.toString()));
        return;
      }
      emit(state.copyWith(
        status: ProductStatus.failure,
        errorMessage: error.toString(),
      ));
    } on ProductsJsonDeserializationException catch (error) {
      if (ProductStatus.loading == state.status) {
        emit(state.copyWith(
            status: ProductStatus.failureLoadingMore,
            errorMessage: error.toString()));
        return;
      }
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

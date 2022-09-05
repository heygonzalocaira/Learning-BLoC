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
      throw Exception();
      emit(state.copyWith(
          status: ProductStatus.success, products: productsDescription));
      //throw  PlatziException("", stackTrace: StackTrace);
    } on Exception catch (error, stackTrace) {
      emit(state.copyWith(
          status: ProductStatus.failure,
          errorMessage: error.toString(),
          stackTrace: stackTrace));
    }
  }
}

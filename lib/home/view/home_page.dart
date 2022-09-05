import 'package:bloc_app/home/cubit/product_cubit.dart';
import 'package:bloc_app/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_repository/platzi_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit(context.read<PlatziRepository>())..getProducts(),
      child: HomeView(title: "Example"),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.loading:
              return const _ProductsLoading();
            case ProductStatus.success:
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    title: "Title Fake",
                    description: state.products[index].description,
                  );
                },
              );
            default:
              return _ProductsFailure(error: state.errorMessage);
          }
        },
      ),
    );
  }
}

class _ProductsFailure extends StatelessWidget {
  const _ProductsFailure({
    required this.error,
    Key? key,
  }) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Error $error"),
    );
  }
}

class _ProductsLoading extends StatelessWidget {
  const _ProductsLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

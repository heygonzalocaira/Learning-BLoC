// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_app/home/cubit/product_cubit.dart';
import 'package:bloc_app/home/models/product.dart';
import 'package:bloc_app/home/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_repository/platzi_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductCubit(context.read<PlatziRepository>())..getRangeProducts(),
      //ProductCubit(context.read<PlatziRepository>())..getProducts(),
      child: const HomeView(title: "BloC Concepts"),
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
        buildWhen: ((previous, current) {
          return current.status != ProductStatus.loading;
        }),
        builder: (context, state) {
          switch (state.status) {
            case ProductStatus.initial:
              return const _ProductsLoading();
            case ProductStatus.success:
              return _ProductSuccess(products: state.products);
            default:
              return _ProductsFailure(error: state.errorMessage);
          }
        },
      ),
    );
  }
}

class _ProductSuccess extends StatefulWidget {
  const _ProductSuccess({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<Product> products;

  @override
  State<_ProductSuccess> createState() => _ProductSuccessState();
}

class _ProductSuccessState extends State<_ProductSuccess> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey _refresherKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state.status == ProductStatus.success) {
          _refreshController.loadComplete();
        }
      },
      child: SmartRefresher(
        key: _refresherKey,
        controller: _refreshController,
        enablePullDown: false,
        enablePullUp: true,
        onLoading: () async {
          await Future.delayed(const Duration(seconds: 1));
          await context.read<ProductCubit>().getRangeProducts();
          //if (mounted) {
          //  setState(() {
          //    _refreshController.loadComplete();
          //  });
          //}
        },
        child: ListView.builder(
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              title: "Number $index",
              description: widget.products[index].description,
            );
          },
        ),
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
      child: Text("Error in $error"),
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

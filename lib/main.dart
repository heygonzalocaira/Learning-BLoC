//import '../packages/platzi_api/lib/src/platzi_api_client.dart';
import 'package:bloc_app/home/cubit/product_cubit.dart';
import 'package:bloc_app/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platzi_repository/platzi_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PlatziRepository(),
      child: MaterialApp(
        title: "Platzi app",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

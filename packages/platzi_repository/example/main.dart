import 'dart:io';

import 'package:platzi_repository/platzi_repository.dart';

void main() async {
  final platziRepository = PlatziRepository();

  try {
    final productDescription =
        await platziRepository.simpleProductDescription(index: 2);
    print(productDescription);
  } on Exception catch (e) {
    print(e);
  }
  try {
    final productsDescription = await platziRepository.allProducts();
    for (final description in productsDescription) {
      print(description);
    }
  } on Exception catch (e) {
    print(e);
  }

  exit(0);
}

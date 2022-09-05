// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:platzi_api/platzi_api.dart';

void main() {
  group('PlatziApi', () {
    test('can be instantiated', () {
      expect(DataPlatziApiClient(), isNotNull);
    });
  });
}

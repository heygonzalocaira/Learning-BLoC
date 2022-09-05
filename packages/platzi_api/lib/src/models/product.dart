import 'package:json_annotation/json_annotation.dart';

part "product.g.dart";

@JsonSerializable()
class Product {
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });
  int id;
  String title;
  int price;
  String description;
  Category2 category;
  List<String> images;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Category2 {
  Category2({
    required this.id,
    required this.name,
    required this.image,
  });
  int id;
  String name;
  String image;
  factory Category2.fromJson(Map<String, dynamic> json) =>
      _$Category2FromJson(json);
  Map<String, dynamic> toJson() => _$Category2ToJson(this);
}

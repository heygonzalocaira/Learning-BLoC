import 'package:json_annotation/json_annotation.dart';

part "product_repository.g.dart";

@JsonSerializable()
class ProductRepository {
  ProductRepository({
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
  dynamic category;
  List<String> images;

  factory ProductRepository.fromJson(Map<String, dynamic> json) =>
      _$ProductRepositoryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductRepositoryToJson(this);
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

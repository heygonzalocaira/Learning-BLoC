// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: json['price'] as int,
      description: json['description'] as String,
      category: Category2.fromJson(json['category'] as Map<String, dynamic>),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'images': instance.images,
    };

Category2 _$Category2FromJson(Map<String, dynamic> json) => Category2(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$Category2ToJson(Category2 instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
    };

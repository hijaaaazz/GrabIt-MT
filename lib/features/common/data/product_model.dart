import 'package:grabit/features/common/domain/entities/product_entity.dart';

class ProductModel {
  final String sku;
  final String name;
  final String imageUrl;
  final int rating;
  final String actualPrice;
  final String offerPrice;
  final String discount;

  ProductModel({
    required this.sku,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.actualPrice,
    required this.offerPrice,
    required this.discount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      sku: json['sku'] ?? '',
      name: json['product_name'] ?? '',
      imageUrl: json['product_image'] ?? '',
      rating: json['product_rating'] ?? 0,
      actualPrice: json['actual_price'] ?? '',
      offerPrice: json['offer_price'] ?? '',
      discount: json['discount'] ?? '',
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      sku: sku,
      name: name,
      imageUrl: imageUrl,
      rating: rating,
      actualPrice: actualPrice,
      offerPrice: offerPrice,
      discount: discount,
    );
  }
}

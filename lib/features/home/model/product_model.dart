class ProductModel {
  final String id; // Changed from sku to id
  final String? sku; // Made optional since it’s not the primary key
  final String name;
  final String imageUrl;
  final int rating;
  final String actualPrice;
  final String offerPrice;
  final String discount;

  ProductModel({
    required this.id,
    this.sku, // Nullable since it’s not the primary key
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.actualPrice,
    required this.offerPrice,
    required this.discount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '', // Use id from JSON
      sku: json['sku'], // Optional, null if not provided
      name: json['product_name'] ?? '',
      imageUrl: json['product_image'] ?? '',
      rating: json['product_rating'] ?? 0,
      actualPrice: json['actual_price'] ?? '',
      offerPrice: json['offer_price'] ?? '',
      discount: json['discount'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Map id to the primary key column
      'sku': sku,
      'product_name': name,
      'product_image': imageUrl,
      'product_rating': rating,
      'actual_price': actualPrice,
      'offer_price': offerPrice,
      'discount': discount,
    };
  }

}
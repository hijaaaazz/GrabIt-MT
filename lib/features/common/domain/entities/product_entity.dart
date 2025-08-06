class ProductEntity {
  final String sku;
  final String name;
  final String imageUrl;
  final int rating;
  final String actualPrice;
  final String offerPrice;
  final String discount;

  ProductEntity({
    required this.sku,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.actualPrice,
    required this.offerPrice,
    required this.discount,
  });
}

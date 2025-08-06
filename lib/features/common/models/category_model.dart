
class CategoryModel {
  final String? id; // Changed to String? to match DB and JSON
  final String name;
  final String imageUrl;

  const CategoryModel({
    this.id, // Optional
    required this.name,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString(), // Handle String or null
      name: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': name, // Matches DB schema
      'image_url': imageUrl,
    };
  }

}
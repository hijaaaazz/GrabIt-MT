class CategoryModel {
  final String? id;
  final String name;
  final String imageUrl;

  const CategoryModel({
    this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString(),
      name: json['title']?.toString() ?? json['name']?.toString() ?? 'Unnamed Category', // Fallback to 'name' or default
      imageUrl: json['image_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
    };
  }
}
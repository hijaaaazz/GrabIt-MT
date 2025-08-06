class AppBannerModel {
  final String? id; // Nullable
  final String imageUrl;

  AppBannerModel({this.id, required this.imageUrl});

  factory AppBannerModel.fromJson(Map<String, dynamic> json) {
    return AppBannerModel(
      id: json['id']?.toString(), // Safe conversion to string
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image_url': imageUrl,
      };
}

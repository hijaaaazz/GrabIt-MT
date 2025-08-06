class AppBannerModel {
  final String? id; // Nullable
  final String imageUrl;
  final String title;

  AppBannerModel({this.id, required this.imageUrl,required this.title});

  factory AppBannerModel.fromJson(Map<String, dynamic> json) {
    return AppBannerModel(
      id: json['id']?.toString(), // Safe conversion to string
      imageUrl: json['image_url'] ?? '',
      title: json['title']
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image_url': imageUrl,
        'title':title
      };
}

class AppBannerModel {
  final String title;
  final String imageUrl;

  AppBannerModel({required this.title, required this.imageUrl});

  factory AppBannerModel.fromJson(Map<String, dynamic> json) {
    return AppBannerModel(
      title: json['title'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }
}

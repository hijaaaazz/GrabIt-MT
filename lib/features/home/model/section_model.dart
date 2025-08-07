class SectionModel {
  final String id;
  final String type;
  final String title;
  final List<dynamic> contents;
  final int order;

  SectionModel({
    required this.id,
    required this.type,
    required this.title,
    required this.contents,
    this.order = 0,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      contents: json['contents'] ?? [],
      order: json['order'] is int ? json['order'] : 0,
    );
  }
}
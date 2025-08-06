class SectionModel {
  final String id;
  final String type;
  final String? title;
  final List<dynamic> contents;

  SectionModel({
    required this.id,
    required this.type,
    this.title,
    required this.contents,
  });
}
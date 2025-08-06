import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grabit/features/common/models/product_model.dart';
import 'package:grabit/features/common/models/category_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';
import 'package:grabit/features/home/model/section_model.dart';

class NetworkService {
  final Dio _dio = Dio();
  final String baseUrl = "https://6893c402c49d24bce86bb4ae.mockapi.io/sections";

  Future<Either<String, List<SectionModel>>> getHomeSections() async {
    try {
      final response = await _dio.get(baseUrl);
      final data = response.data as List;

      final sections = data.asMap().entries.map((entry) {
        final section = entry.value;
        final sectionId = section['id'] ?? 'section_${entry.key}';
        switch (section['type']) {
          case 'banner_slider':
            return SectionModel(
              id: sectionId,
              type: section['type'],
              title: section['title'],
              contents: (section['contents'] as List)
                  .asMap()
                  .entries
                  .map((e) => AppBannerModel.fromJson({
                        ...e.value,
                        'id': '${sectionId}_${e.key}',
                      }))
                  .toList(),
            );
          case 'catagories':
          Future.delayed(Duration(seconds: 10));
            return SectionModel(
              id: sectionId,
              type: section['type'],
              title: section['title'],
              contents: (section['contents'] as List)
                  .asMap()
                  .entries
                  .map((e) => CategoryModel.fromJson({
                        ...e.value,
                        'id': '${sectionId}_${e.key}',
                      }))
                  .toList(),
            );
          case 'banner_single':
            return SectionModel(
              id: sectionId,
              type: section['type'],
              title: section['title'],
              contents: [
                AppBannerModel.fromJson({
                  'id': sectionId,
                  'title': section['title'],
                  'image_url': section['image_url'],
                })
              ],
            );
          case 'products':
            return SectionModel(
              id: sectionId,
              type: section['type'],
              title: section['title'],
              contents: (section['contents'] as List)
                  .asMap()
                  .entries
                  .map((e) => ProductModel.fromJson({
                        ...e.value,
                        'id': '${sectionId}_${e.key}',
                      }))
                  .toList(),
            );
          default:
            return SectionModel(id: sectionId, type: 'unknown', contents: []);
        }
      }).toList();

      return Right(sections);
    } catch (e) {
      return Left("Network Error: $e");
    }
  }
}
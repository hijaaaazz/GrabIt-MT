import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grabit/core/error/error_handler.dart';
import 'package:grabit/features/home/model/product_model.dart';
import 'package:grabit/features/home/model/category_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';
import 'package:grabit/features/home/model/section_model.dart';

class NetworkService {
  final Dio _dio = Dio();
  final String baseUrl = "https://6893c402c49d24bce86bb4ae.mockapi.io/sections";

  Future<Either<String, List<SectionModel>>> getHomeSections() async {
    try {
      final response = await _dio.get(baseUrl);

      if (response.statusCode == 200) {
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
                order: entry.key,
              );
            case 'categories':
              return SectionModel(
                id: sectionId,
                type: 'categories',
                title: section['title'],
                contents: (section['contents'] as List)
                    .asMap()
                    .entries
                    .map((e) => CategoryModel.fromJson({
                          ...e.value,
                          'id': '${sectionId}_${e.key}',
                        }))
                    .toList(),
                order: entry.key,
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
                order: entry.key,
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
                order: entry.key,
              );
            default:
              return SectionModel(
                title: "",
                id: sectionId,
                type: 'unknown',
                contents: [],
                order: entry.key,
              );
          }
        }).toList();

        return Right(sections);
      } else {
        return Left(ApiErrorHandler.getErrorMessage(
            DioException(response: response, requestOptions: RequestOptions(path: baseUrl))));
      }
    } catch (e) {
      return Left(ApiErrorHandler.getErrorMessage(e));
    }
  }
}

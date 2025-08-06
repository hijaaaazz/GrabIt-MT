import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:grabit/features/common/data/category_model.dart';
import 'package:grabit/features/common/data/product_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';

class NetworkService {
  final Dio _dio = Dio();
  final String baseUrl = "https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo";

  Future<Either<String, List<AppBannerModel>>> getBanners() async {
    try {
      final response = await _dio.get(baseUrl);
      final data = response.data as List;

      final section = data.firstWhere((e) => e['type'] == 'banner_slider');
      final banners = (section['contents'] as List)
          .asMap()
          .entries
          .map((entry) => AppBannerModel.fromJson({
                ...entry.value,
                'id': '${section['id']}_${entry.key}', // Generate ID
              }))
          .toList();

      return Right(banners);
    } catch (e) {
      return Left("Network Error: $e");
    }
  }

  Future<Either<String, List<ProductModel>>> getPopularProducts() async {
    try {
      final response = await _dio.get(baseUrl);
      final data = response.data as List;

      final section = data.firstWhere(
        (e) => e['type'] == 'products' && e['title'] == 'Most Popular',
        orElse: () => null,
      );
      if (section == null) {
        return Left("No 'Most Popular' products section found");
      }
      final products = (section['contents'] as List)
          .asMap()
          .entries
          .map((entry) => ProductModel.fromJson({
                ...entry.value,
                'id': '${section['id']}_${entry.key}', // Generate ID
              }))
          .toList();

      return Right(products);
    } catch (e) {
      return Left("Network Error: $e");
    }
  }

  Future<Either<String, List<ProductModel>>> getFeaturedProducts() async {
    try {
      final response = await _dio.get(baseUrl);
      final data = response.data as List;

      final section = data.firstWhere(
        (e) => e['type'] == 'products' && e['title'] == 'Best Sellers',
        orElse: () => null,
      );
      if (section == null) {
        return Left("No 'Best Sellers' products section found");
      }
      final products = (section['contents'] as List)
          .asMap()
          .entries
          .map((entry) => ProductModel.fromJson({
                ...entry.value,
                'id': '${section['id']}_${entry.key}', // Generate ID
              }))
          .toList();

      return Right(products);
    } catch (e) {
      return Left("Network Error: $e");
    }
  }

  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final response = await _dio.get(baseUrl);
      final data = response.data as List;

      final section = data.firstWhere(
        (e) => e['type'] == 'catagories',
        orElse: () => null,
      );
      if (section == null) {
        return Left("No categories section found");
      }
      final categories = (section['contents'] as List)
          .asMap()
          .entries
          .map((entry) => CategoryModel.fromJson({
                ...entry.value,
                'id': '${section['id']}_${entry.key}', // Generate ID
              }))
          .toList();

      return Right(categories);
    } catch (e) {
      return Left("Network Error: $e");
    }
  }

  Future<Either<String, AppBannerModel>> getSingleBanner() async {
    try {
      final response = await _dio.get(baseUrl);
      final data = response.data as List;

      final section = data.firstWhere(
        (e) => e['type'] == 'banner_single',
        orElse: () => null,
      );
      if (section == null) {
        return Left("No single banner section found");
      }
      final banner = AppBannerModel.fromJson({
        'id': section['id'] ?? 'single_banner_${DateTime.now().millisecondsSinceEpoch}',
        'title': section['title'],
        'image_url': section['image_url'],
      });
      return Right(banner);
    } catch (e) {
      return Left("Network Error: $e");
    }
  }
}
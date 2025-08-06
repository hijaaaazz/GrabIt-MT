import 'package:dartz/dartz.dart';
import 'package:grabit/features/common/data/product_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';

class LocalStorage {
  Future<Either<String, List<AppBannerModel>>> getBanners() async {
    try {
      // Read from local DB
      return Right([/* load banners */]);
    } catch (e) {
      return Left("Local Storage Error: $e");
    }
  }

  Future<void> saveBanners(List<AppBannerModel> banners) async {
    // Save to local DB
  }

  Future<Either<String, List<ProductModel>>> getPopularProducts() async {
    try {
      return Right([/* load products */]);
    } catch (e) {
      return Left("Local Storage Error: $e");
    }
  }

  Future<void> savePopularProducts(List<ProductModel> products) async {
    // Save to local DB
  }

  Future<Either<String, List<ProductModel>>> getFeaturedProducts() async {
    try {
      return Right([/* load products */]);
    } catch (e) {
      return Left("Local Storage Error: $e");
    }
  }

  Future<void> saveFeaturedProducts(List<ProductModel> products) async {
    // Save to local DB
  }
}

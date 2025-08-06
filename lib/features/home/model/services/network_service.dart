import 'package:dartz/dartz.dart';
import 'package:grabit/features/common/data/product_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';

class NetworkService {
  Future<Either<String, List<AppBannerModel>>> getBanners() async {
    try {
      // Simulate API call
      return Right([/* sample banner data */]);
    } catch (e) {
      return Left("Network Error: $e");
    }
  }

  Future<Either<String, List<ProductModel>>> getPopularProducts() async {
    try {
      return Right([/* sample product data */]);
    } catch (e) {
      return Left("Network Error: $e");
    }
  }

  Future<Either<String, List<ProductModel>>> getFeaturedProducts() async {
    try {
      return Right([/* sample product data */]);
    } catch (e) {
      return Left("Network Error: $e");
    }
  }
}

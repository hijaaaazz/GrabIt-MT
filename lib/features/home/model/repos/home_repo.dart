import 'package:dartz/dartz.dart';
import 'package:grabit/core/di/sevice_locator.dart';
import 'package:grabit/core/network/network.dart';
import 'package:grabit/features/common/data/product_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';
import 'package:grabit/features/home/model/services/local_service.dart';
import 'package:grabit/features/home/model/services/network_service.dart';

abstract class HomeRepo {
  Future<Either<String,List<AppBannerModel>>>getBanners();
  Future<Either<String,List<ProductModel>>>getPopularProducts();
  Future<Either<String,List<ProductModel>>>getFeaturedProducts();
}


class HomeRepoImp implements HomeRepo {
  final NetworkService remote = getIt<NetworkService>();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();
  final LocalStorage local = getIt<LocalStorage>();

  @override
  Future<Either<String, List<AppBannerModel>>> getBanners() async {
    if (await networkInfo.isConnected) {
      final result = await remote.getBanners();
      return result.fold(
        (error) => Left(error),
        (banners) async {
          await local.saveBanners(banners); // ✅ Save to local
          return Right(banners);
        },
      );
    } else {
      return await local.getBanners();
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getPopularProducts() async {
    if (await networkInfo.isConnected) {
      final result = await remote.getPopularProducts();
      return result.fold(
        (error) => Left(error),
        (products) async {
          await local.savePopularProducts(products); // ✅ Save to local
          return Right(products);
        },
      );
    } else {
      return await local.getPopularProducts();
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getFeaturedProducts() async {
    if (await networkInfo.isConnected) {
      final result = await remote.getFeaturedProducts();
      return result.fold(
        (error) => Left(error),
        (products) async {
          await local.saveFeaturedProducts(products); // ✅ Save to local
          return Right(products);
        },
      );
    } else {
      return await local.getFeaturedProducts();
    }
  }
}

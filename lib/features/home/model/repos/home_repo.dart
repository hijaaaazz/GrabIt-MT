import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:grabit/core/di/sevice_locator.dart';
import 'package:grabit/core/network/network.dart';
import 'package:grabit/features/common/models/product_model.dart';
import 'package:grabit/features/common/models/category_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';
import 'package:grabit/features/home/model/services/local_service.dart';
import 'package:grabit/features/home/model/services/network_service.dart';

abstract class HomeRepo {
  Future<Either<String, List<AppBannerModel>>> getBanners();
  Future<Either<String, List<ProductModel>>> getPopularProducts();
  Future<Either<String, List<ProductModel>>> getFeaturedProducts();
  Future<Either<String, List<CategoryModel>>> getCategories();
  Future<Either<String, AppBannerModel>> getSingleBanner();
}

class HomeRepoImp implements HomeRepo {
  final NetworkService remote = getIt<NetworkService>();
  final NetworkInfo networkInfo = getIt<NetworkInfo>();
  final LocalStorage local = getIt<LocalStorage>();

  @override
Future<Either<String, List<AppBannerModel>>> getBanners() async {
  try {
    
    if (await networkInfo.isConnected) {
      final result = await remote.getBanners();
      return result.fold(
        (error) => Left(error),
        (banners) async {
          await local.saveBanners(banners);
          return Right(banners);
        },
      );
    } else {
      log("local");
      return await local.getBanners();
    }
  } catch (e) {
    return Left("Something went wrong: ${e.toString()}");
  }
}


  @override
  Future<Either<String, List<ProductModel>>> getPopularProducts() async {
    if (await networkInfo.isConnected) {
      final result = await remote.getPopularProducts();
      return result.fold(
        (error) => Left(error),
        (products) async {
          await local.savePopularProducts(products);
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
          await local.saveFeaturedProducts(products);
          return Right(products);
        },
      );
    } else {
      return await local.getFeaturedProducts();
    }
  }

  @override
  Future<Either<String, List<CategoryModel>>> getCategories() async {
    if (await networkInfo.isConnected) {
      final result = await remote.getCategories();
      return result.fold(
        (error) => Left(error),
        (categories) async {
          await local.saveCategories(categories);
          return Right(categories);
        },
      );
    } else {
      return await local.getCategories();
    }
  }

  @override
  Future<Either<String, AppBannerModel>> getSingleBanner() async {
    if (await networkInfo.isConnected) {
      final result = await remote.getSingleBanner();
      return result.fold(
        (error) => Left(error),
        (banner) async {
          await local.saveSingleBanner(banner);
          return Right(banner);
        },
      );
    } else {
      return await local.getSingleBanner();
    }
  }
}
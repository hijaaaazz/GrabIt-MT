import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:grabit/core/helper/db_helper.dart';
import 'package:grabit/features/common/data/product_model.dart';
import 'package:grabit/features/common/data/category_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  Future<Either<String, List<AppBannerModel>>> getBanners() async {
    try {
      final db = await DBHelper.database;
      final result = await db.query('banners');
      final banners = result.map((e) => AppBannerModel.fromJson(e)).toList();
      return Right(banners);
    } catch (e) {
      return Left("Failed to fetch banners from local storage: $e");
    }
  }

  Future<void> saveBanners(List<AppBannerModel> banners) async {
    try {
      final db = await DBHelper.database;
      final batch = db.batch();
      await db.delete('banners');
      for (var banner in banners) {
        batch.insert('banners', banner.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      log('Error saving banners: $e');
      rethrow;
    }
  }

  Future<Either<String, List<ProductModel>>> getPopularProducts() async {
  final db = await DBHelper.database;
  final result = await db.query('popular_products');
  final products = result.map((e) => ProductModel.fromJson(e)).toList();
  if (products.isEmpty) {
    return Left('No popular products found in local storage');
  }
  return Right(products);
}

Future<Either<String, List<ProductModel>>> getFeaturedProducts() async {
  final db = await DBHelper.database;
  final result = await db.query('featured_products');
  final products = result.map((e) => ProductModel.fromJson(e)).toList();
  if (products.isEmpty) {
    return Left('No featured products found in local storage');
  }
  return Right(products);
}

Future<void> savePopularProducts(List<ProductModel> products) async {
  final db = await DBHelper.database;
  final batch = db.batch();
  await db.delete('popular_products');
  for (var product in products) {
    batch.insert('popular_products', product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  await batch.commit(noResult: true);
}

Future<void> saveFeaturedProducts(List<ProductModel> products) async {
  final db = await DBHelper.database;
  final batch = db.batch();
  await db.delete('featured_products');
  for (var product in products) {
    batch.insert('featured_products', product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
  await batch.commit(noResult: true);
}


  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final db = await DBHelper.database;
      final result = await db.query('categories');
      final categories = result.map((e) => CategoryModel.fromJson(e)).toList();
      if (categories.isEmpty) {
        return Left('No categories found in local storage');
      }
      return Right(categories);
    } catch (e) {
      return Left("Failed to fetch categories from local storage: $e");
    }
  }

  Future<void> saveCategories(List<CategoryModel> categories) async {
    try {
      final db = await DBHelper.database;
      final batch = db.batch();
      await db.delete('categories');
      for (var category in categories) {
        batch.insert('categories', category.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      log('Error saving categories: $e');
      rethrow;
    }
  }

  Future<Either<String, AppBannerModel>> getSingleBanner() async {
    try {
      final db = await DBHelper.database;
      final result = await db.query('single_banner', limit: 1);
      if (result.isEmpty) {
        return Left('No single banner found in local storage');
      }
      final banner = AppBannerModel.fromJson(result.first);
      return Right(banner);
    } catch (e) {
      return Left("Failed to fetch single banner from local storage: $e");
    }
  }

  Future<void> saveSingleBanner(AppBannerModel banner) async {
    try {
      final db = await DBHelper.database;
      await db.delete('single_banner');
      await db.insert('single_banner', banner.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      log('Error saving single banner: $e');
      rethrow;
    }
  }
}
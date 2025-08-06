import 'package:dartz/dartz.dart';
import 'package:grabit/core/helper/db_helper.dart';
import 'package:grabit/features/common/models/product_model.dart';
import 'package:grabit/features/common/models/category_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';
import 'package:grabit/features/home/model/section_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  Future<Either<String, List<SectionModel>>> getHomeSections() async {
    try {
      final db = await DBHelper.database;

      // Fetch banners
      final bannerMaps = await db.query('banners');
      final banners = bannerMaps.map((map) => AppBannerModel.fromJson({
            'id': map['id'],
            'title': map['title'],
            'image_url': map['image_url'],
          })).toList();
      final bannerSection = SectionModel(
        id: 'banner_slider_1',
        type: 'banner_slider',
        title: 'Banners',
        contents: banners,
      );

      // Fetch categories
      final categoryMaps = await db.query('categories');
      final categories = categoryMaps.map((map) => CategoryModel.fromJson({
            'id': map['id'],
            'name': map['title'],
            'image_url': map['image_url'],
          })).toList();
      final categorySection = SectionModel(
        id: 'catagories_1',
        type: 'catagories',
        title: 'Categories',
        contents: categories,
      );

      // Fetch single banner
      final singleBannerMaps = await db.query('single_banner', limit: 1);
      final singleBanners = singleBannerMaps.map((map) => AppBannerModel.fromJson({
            'id': map['id'],
            'title': map['title'],
            'image_url': map['image_url'],
          })).toList();
      final singleBannerSection = SectionModel(
        id: 'banner_single_1',
        type: 'banner_single',
        title: 'Single Banner',
        contents: singleBanners,
      );

      // Fetch popular products
final popularProductMaps = await db.query('popular_products');
final popularProducts = popularProductMaps.map((map) => ProductModel.fromJson({
  'id': map['id']?.toString() ?? '',
  'sku': map['sku']?.toString(),
  'product_name': map['product_name']?.toString() ?? '',
  'product_image': map['product_image']?.toString() ?? '',
  'product_rating': map['product_rating'] ?? 0,
  'actual_price': map['actual_price']?.toString() ?? '', // Keep as String
  'offer_price': map['offer_price']?.toString(), // Keep as String, nullable
  'discount': map['discount']?.toString(), // Keep as String, nullable
})).toList();
final popularProductSection = SectionModel(
  id: 'products_popular_1',
  type: 'products',
  title: 'Most Popular',
  contents: popularProducts,
);

// Fetch featured products
final featuredProductMaps = await db.query('featured_products');
final featuredProducts = featuredProductMaps.map((map) => ProductModel.fromJson({
  'id': map['id']?.toString() ?? '',
  'sku': map['sku']?.toString(),
  'product_name': map['product_name']?.toString() ?? '',
  'product_image': map['product_image']?.toString() ?? '',
  'product_rating': map['product_rating'] ?? 0,
  'actual_price': map['actual_price']?.toString() ?? '', // Keep as String
  'offer_price': map['offer_price']?.toString(), // Keep as String, nullable
  'discount': map['discount']?.toString(), // Keep as String, nullable
})).toList();
final featuredProductSection = SectionModel(
  id: 'products_featured_1',
  type: 'products',
  title: 'Best Sellers',
  contents: featuredProducts,
);

      return Right([
        bannerSection,
        categorySection,
        singleBannerSection,
        popularProductSection,
        featuredProductSection,
      ].where((section) => section.contents.isNotEmpty).toList());
    } catch (e) {
      return Left("Local Storage Error: $e");
    }
  }

  Future<void> saveHomeSections(List<SectionModel> sections) async {
    final db = await DBHelper.database;
    final batch = db.batch();

    for (var section in sections) {
      switch (section.type) {
        case 'banner_slider':
          for (var content in section.contents) {
            final banner = content as AppBannerModel;
            batch.insert(
              'banners',
              {
                'id': banner.id,
                'title': banner.imageUrl,
                'image_url': banner.imageUrl,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
          break;
        case 'catagories':
          for (var content in section.contents) {
            final category = content as CategoryModel;
            batch.insert(
              'categories',
              {
                'id': category.id,
                'title': category.name,
                'image_url': category.imageUrl,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
          break;
        case 'banner_single':
          for (var content in section.contents) {
            final banner = content as AppBannerModel;
            batch.insert(
              'single_banner',
              {
                'id': banner.id,
                'title': banner.imageUrl,
                'image_url': banner.imageUrl,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
          break;
        case 'products':
          final table = section.title == 'Most Popular' ? 'popular_products' : 'featured_products';
          for (var content in section.contents) {
            final product = content as ProductModel;
            batch.insert(
              table,
              {
                'id': product.id,
                'sku': product.id, // Assuming SKU is same as ID for simplicity
                'product_name': product.name,
                'product_image': product.imageUrl,
                'product_rating': product.rating,
                'actual_price': product.actualPrice,
                'offer_price': product.offerPrice,
                'discount': product.discount,
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
          break;
      }
    }
    await batch.commit(noResult: true);
  }
}
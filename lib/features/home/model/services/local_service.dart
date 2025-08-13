import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:grabit/core/helper/db_helper.dart';
import 'package:grabit/features/home/model/product_model.dart';
import 'package:grabit/features/home/model/category_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';
import 'package:grabit/features/home/model/section_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  Future<Either<String, List<SectionModel>>> getHomeSections() async {
    try {
      final db = await DBHelper.database;

      final bannerMaps = await db.query('banners', orderBy: 'section_order ASC');
      final banners = bannerMaps.map((map) => AppBannerModel.fromJson({
            'id': map['id']?.toString() ?? '',
            'title': map['title']?.toString() ?? '',
            'image_url': map['image_url']?.toString() ?? '',
          })).toList();
      final bannerSection = SectionModel(
        id: '1',
        type: 'banner_slider',
        title: 'Featured Banners',
        contents: banners,
        order: bannerMaps.isNotEmpty ? (bannerMaps.first['section_order'] as int?) ?? 0 : 0,
      );

      final categoryMaps = await db.query('categories', orderBy: 'section_order ASC');
      final categorySections = <String, SectionModel>{};
      for (var map in categoryMaps) {
        final sectionId = map['section_id']?.toString() ?? '4';
        final sectionTitle = map['section_title']?.toString() ?? 'Top Categories';
        final sectionOrder = (map['section_order'] as int?) ?? 0;
        log('Retrieved category: id=${map['id']}, name=${map['name']}, image_url=${map['image_url']}, section_id=$sectionId, section_title=$sectionTitle');
        final category = CategoryModel.fromJson({
          'id': map['id']?.toString() ?? '',
          'name': map['name']?.toString() ?? 'Unnamed Category',
          'image_url': map['image_url']?.toString() ?? '',
        });

        if (!categorySections.containsKey(sectionId)) {
          categorySections[sectionId] = SectionModel(
            id: sectionId,
            type: 'categories',
            title: sectionTitle,
            contents: [],
            order: sectionOrder,
          );
        }
        categorySections[sectionId]!.contents.add(category);
      }

      // Fetch single banner
      final singleBannerMaps = await db.query('single_banner', orderBy: 'section_order ASC');
      final singleBanners = singleBannerMaps.map((map) => AppBannerModel.fromJson({
            'id': map['id']?.toString() ?? '',
            'title': map['title']?.toString() ?? '',
            'image_url': map['image_url']?.toString() ?? '',
          })).toList();
      final singleBannerSection = SectionModel(
        id: '3',
        type: 'banner_single',
        title: 'Special Offer',
        contents: singleBanners,
        order: singleBannerMaps.isNotEmpty ? (singleBannerMaps.first['section_order'] as int?) ?? 0 : 0,
      );

      // Fetch products and group by section
      final productMaps = await db.query('products', orderBy: 'section_order ASC');
      final productSections = <String, SectionModel>{};
      for (var map in productMaps) {
        final sectionId = map['section_id']?.toString() ?? '';
        final sectionTitle = map['section_title']?.toString() ?? '';
        final sectionOrder = (map['section_order'] as int?) ?? 0;
        if (sectionId.isEmpty) {
          log('Warning: Product with id ${map['id']} has empty section_id');
          continue;
        }
        final product = ProductModel.fromJson({
          'id': map['id']?.toString() ?? '',
          'sku': map['sku']?.toString(),
          'product_name': map['product_name']?.toString() ?? '',
          'product_image': map['product_image']?.toString() ?? '',
          'product_rating': map['product_rating'] ?? 0,
          'actual_price': map['actual_price']?.toString() ?? '',
          'offer_price': map['offer_price']?.toString(),
          'discount': map['discount']?.toString(),
        });

        if (!productSections.containsKey(sectionId)) {
          productSections[sectionId] = SectionModel(
            id: sectionId,
            type: 'products',
            title: sectionTitle,
            contents: [],
            order: sectionOrder,
          );
        }
        productSections[sectionId]!.contents.add(product);
      }

      final sections = [
        bannerSection,
        ...categorySections.values,
     
        singleBannerSection,
        ...productSections.values,
      ].where((section) => section.contents.isNotEmpty).toList()
        ..sort((a, b) => a.order.compareTo(b.order));

      if (sections.isEmpty) {
        log('No data found in local storage');
        return Left('Please turn network on');
      }

      log('Retrieved ${sections.length} sections from local storage: ${sections.map((s) => "${s.type} (id: ${s.id}, title: ${s.title}, order: ${s.order})").toList()}');
      return Right(sections);
    } catch (e, stackTrace) {
      log('Error in getHomeSections: $e', stackTrace: stackTrace);
      return Left("Local Storage Error: $e");
    }
  }

  Future<void> saveHomeSections(List<SectionModel> sections) async {
    try {
      final db = await DBHelper.database;
      final batch = db.batch();

      batch.delete('banners');
      batch.delete('categories');
      batch.delete('single_banner');
      batch.delete('products');
      log('Cleared existing data in all tables');

      for (var i = 0; i < sections.length; i++) {
        final section = sections[i];
        if (section.id.isEmpty) {
          log('Warning: Skipping section with null or empty ID: ${section.type}');
          continue;
        }
        switch (section.type) {
          case 'banner_slider':
            for (var content in section.contents) {
              final banner = content as AppBannerModel;
              if (banner.id == null || banner.id!.isEmpty) {
                log('Warning: Skipping banner with null or empty ID');
                continue;
              }
              batch.insert(
                'banners',
                {
                  'id': banner.id,
                  'title': banner.title,
                  'image_url': banner.imageUrl,
                  'section_id': section.id,
                  'section_order': i,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            }
            log('Prepared ${section.contents.length} banners for section ${section.id}');
            break;
          case 'categories':
            for (var content in section.contents) {
              final category = content as CategoryModel;
              if (category.id == null || category.id!.isEmpty) {
                log('Warning: Skipping category with null or empty ID');
                continue;
              }
              log('Saving category: id=${category.id}, name=${category.name}, image_url=${category.imageUrl}, section_id=${section.id}, section_title=${section.title}');
              batch.insert(
                'categories',
                {
                  'id': category.id,
                  'name': category.name,
                  'image_url': category.imageUrl,
                  'section_id': section.id,
                  'section_title': section.title,
                  'section_order': i,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            }
            log('Prepared ${section.contents.length} categories for section ${section.id}');
            break;
          case 'banner_single':
            for (var content in section.contents) {
              final banner = content as AppBannerModel;
              if (banner.id == null || banner.id!.isEmpty) {
                log('Warning: Skipping single banner with null or empty ID');
                continue;
              }
              batch.insert(
                'single_banner',
                {
                  'id': banner.id,
                  'title': banner.title,
                  'image_url': banner.imageUrl,
                  'section_id': section.id,
                  'section_order': i,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            }
            log('Prepared ${section.contents.length} single banners for section ${section.id}');
            break;
          case 'products':
            for (var content in section.contents) {
              final product = content as ProductModel;
              if (product.id.isEmpty) {
                log('Warning: Skipping product with empty ID');
                continue;
              }
              batch.insert(
                'products',
                {
                  'id': product.id,
                  'sku': product.sku ?? product.id,
                  'product_name': product.name,
                  'product_image': product.imageUrl,
                  'product_rating': product.rating,
                  'actual_price': product.actualPrice,
                  'offer_price': product.offerPrice,
                  'discount': product.discount,
                  'section_id': section.id,
                  'section_title': section.title,
                  'section_order': i,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            }
            log('Prepared ${section.contents.length} products for section ${section.id}');
            break;
          default:
            log('Warning: Unknown section type: ${section.type}');
        }
      }

      await batch.commit(noResult: true);
      log('Successfully committed batch to database');
    } catch (e, stackTrace) {
      log('Error in saveHomeSections: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
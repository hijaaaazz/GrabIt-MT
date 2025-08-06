import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grabit/features/home/model/repos/home_repo.dart';
import 'package:grabit/features/common/data/product_model.dart';
import 'package:grabit/features/common/data/category_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';

class HomeViewModel extends ChangeNotifier {
  final _repo = GetIt.instance<HomeRepo>();

  List<AppBannerModel> _banners = [];
  List<ProductModel> _popularProducts = [];
  List<ProductModel> _featuredProducts = [];
  List<CategoryModel> _categories = [];
  AppBannerModel? _singleBanner;

  String? errorMessage;

  List<AppBannerModel> get banners => _banners;
  List<ProductModel> get popularProducts => _popularProducts;
  List<ProductModel> get featuredProducts => _featuredProducts;
  List<CategoryModel> get categories => _categories;
  AppBannerModel? get singleBanner => _singleBanner;

  Future<void> loadHomeData() async {
    errorMessage = null;
    log('Starting to load home data');

    // Load banners
    _repo.getBanners().then((bannerResult) {
      bannerResult.fold(
        (l) {
          log('Banner error: $l');
          errorMessage ??= l;
        },
        (r) {
          _banners = r;
          log('Banners loaded: ${_banners.length} items');
        },
      );
      notifyListeners();
    });

    // Load popular products
    _repo.getPopularProducts().then((popularResult) {
      popularResult.fold(
        (l) {
          log('Popular products error: $l');
          errorMessage ??= l;
        },
        (r) {
          _popularProducts = r;
          log('Popular products loaded: ${_popularProducts.length} items');
        },
      );
      notifyListeners();
    });

    // Load featured products
    _repo.getFeaturedProducts().then((featuredResult) {
      featuredResult.fold(
        (l) {
          log('Featured products error: $l');
          errorMessage ??= l;
        },
        (r) {
          _featuredProducts = r;
          log('Featured products loaded: ${_featuredProducts.length} items');
        },
      );
      notifyListeners();
    });

    // Load categories
    _repo.getCategories().then((categoryResult) {
      categoryResult.fold(
        (l) {
          log('Categories error: $l');
          errorMessage ??= l;
        },
        (r) {
          _categories = r;
          log('Categories loaded: ${_categories.length} items');
        },
      );
      notifyListeners();
    });

    // Load single banner
    _repo.getSingleBanner().then((singleBannerResult) {
      singleBannerResult.fold(
        (l) {
          log('Single banner error: $l');
          errorMessage ??= l;
        },
        (r) {
          _singleBanner = r;
          log('Single banner loaded: $_singleBanner');
        },
      );
      notifyListeners();
    });
  }
}
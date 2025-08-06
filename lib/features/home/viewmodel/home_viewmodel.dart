import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grabit/features/home/model/repos/home_repo.dart';
import 'package:grabit/features/common/models/product_model.dart';
import 'package:grabit/features/common/models/category_model.dart';
import 'package:grabit/features/home/model/banner_model.dart';

class HomeViewModel extends ChangeNotifier {
  final _repo = GetIt.instance<HomeRepo>();
  
  List<AppBannerModel> _banners = [];
  List<ProductModel> _popularProducts = [];
  List<ProductModel> _featuredProducts = [];
  List<CategoryModel> _categories = [];
  AppBannerModel? _singleBanner;
  String? errorMessage;
  
  // Loading states
  bool _isBannersLoading = true;
  bool _isPopularProductsLoading = true;
  bool _isFeaturedProductsLoading = true;
  bool _isCategoriesLoading = true;
  bool _isSingleBannerLoading = true;

  // Getters
  List<AppBannerModel> get banners => _banners;
  List<ProductModel> get popularProducts => _popularProducts;
  List<ProductModel> get featuredProducts => _featuredProducts;
  List<CategoryModel> get categories => _categories;
  AppBannerModel? get singleBanner => _singleBanner;
  
  bool get isBannersLoading => _isBannersLoading;
  bool get isPopularProductsLoading => _isPopularProductsLoading;
  bool get isFeaturedProductsLoading => _isFeaturedProductsLoading;
  bool get isCategoriesLoading => _isCategoriesLoading;
  bool get isSingleBannerLoading => _isSingleBannerLoading;

  Future<void> loadHomeData() async {
    errorMessage = null;
    log('Starting to load home data');

    // Load banners
    _loadBanners();
    
    // Load popular products
    _loadPopularProducts();
    
    // Load featured products
    _loadFeaturedProducts();
    
    // Load categories
    _loadCategories();
    
    // Load single banner
    _loadSingleBanner();
  }

  Future<void> _loadBanners() async {
    _isBannersLoading = true;
    notifyListeners();
    
    final bannerResult = await _repo.getBanners();
    bannerResult.fold(
      (l) {
        log('Banner error: $l');
        errorMessage ??= l;
        _isBannersLoading = false;
      },
      (r) {
        _banners = r;
        _isBannersLoading = false;
        log('Banners loaded: ${_banners.length} items');
      },
    );
    notifyListeners();
  }

  Future<void> _loadPopularProducts() async {
    _isPopularProductsLoading = true;
    notifyListeners();
    
    final popularResult = await _repo.getPopularProducts();
    popularResult.fold(
      (l) {
        log('Popular products error: $l');
        errorMessage ??= l;
        _isPopularProductsLoading = false;
      },
      (r) {
        _popularProducts = r;
        _isPopularProductsLoading = false;
        log('Popular products loaded: ${_popularProducts.length} items');
      },
    );
    notifyListeners();
  }

  Future<void> _loadFeaturedProducts() async {
    _isFeaturedProductsLoading = true;
    notifyListeners();
    
    final featuredResult = await _repo.getFeaturedProducts();
    featuredResult.fold(
      (l) {
        log('Featured products error: $l');
        errorMessage ??= l;
        _isFeaturedProductsLoading = false;
      },
      (r) {
        _featuredProducts = r;
        _isFeaturedProductsLoading = false;
        log('Featured products loaded: ${_featuredProducts.length} items');
      },
    );
    notifyListeners();
  }

  Future<void> _loadCategories() async {
    _isCategoriesLoading = true;
    notifyListeners();
    
    final categoryResult = await _repo.getCategories();
    categoryResult.fold(
      (l) {
        log('Categories error: $l');
        errorMessage ??= l;
        _isCategoriesLoading = false;
      },
      (r) {
        _categories = r;
        _isCategoriesLoading = false;
        log('Categories loaded: ${_categories.length} items');
      },
    );
    notifyListeners();
  }

  Future<void> _loadSingleBanner() async {
    _isSingleBannerLoading = true;
    notifyListeners();
    
    final singleBannerResult = await _repo.getSingleBanner();
    singleBannerResult.fold(
      (l) {
        log('Single banner error: $l');
        errorMessage ??= l;
        _isSingleBannerLoading = false;
      },
      (r) {
        _singleBanner = r;
        _isSingleBannerLoading = false;
        log('Single banner loaded: $_singleBanner');
      },
    );
    notifyListeners();
  }
}

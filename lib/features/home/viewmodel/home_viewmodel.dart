// home_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:grabit/features/home/model/repos/home_repo.dart';

import '../model/banner_model.dart';
import '../../common/data/product_model.dart';

class HomeViewModel extends ChangeNotifier {
  final _repo = GetIt.instance<HomeRepo>();

  List<AppBannerModel> _banners = [];
  List<ProductModel> _popularProducts = [];
  List<ProductModel> _featuredProducts = [];

  String? errorMessage;

  List<AppBannerModel> get banners => _banners;
  List<ProductModel> get popularProducts => _popularProducts;
  List<ProductModel> get featuredProducts => _featuredProducts;

  Future<void> loadHomeData() async {
  // Reset error message before loading
  errorMessage = null;

  // Load banners
  _repo.getBanners().then((bannerResult) {
    bannerResult.fold(
      (l) => errorMessage ??= l,
      (r) => _banners = r,
    );
    notifyListeners(); // Notify after banner is loaded
  });

  // Load popular products
  _repo.getPopularProducts().then((popularResult) {
    popularResult.fold(
      (l) => errorMessage ??= l,
      (r) => _popularProducts = r,
    );
    notifyListeners(); // Notify after popular products are loaded
  });

  // Load featured products
  _repo.getFeaturedProducts().then((featuredResult) {
    featuredResult.fold(
      (l) => errorMessage ??= l,
      (r) => _featuredProducts = r,
    );
    notifyListeners(); // Notify after featured products are loaded
  });
}

}

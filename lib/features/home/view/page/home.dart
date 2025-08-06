import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/widgets/skelton/category_section.dart';
import 'package:grabit/features/home/view/widgets/skelton/product_list.dart';
import 'package:grabit/features/home/view/widgets/skelton/promo_banner.dart';
import 'package:grabit/features/home/view/widgets/skelton/slider_banner.dart';
import 'package:provider/provider.dart';
import 'package:grabit/features/home/viewmodel/home_viewmodel.dart';
import 'package:grabit/features/home/view/widgets/banner.dart';
import 'package:grabit/features/home/view/widgets/category_section.dart';
import 'package:grabit/features/home/view/widgets/header.dart';
import 'package:grabit/features/home/view/widgets/product_list.dart';
import 'package:grabit/features/home/view/widgets/promo_banner.dart';
import 'package:grabit/features/home/view/widgets/section_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.errorMessage != null && !viewModel.isBannersLoading) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HomeHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Hero Banner Section
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: viewModel.isBannersLoading
                            ? const HeroBannerShimmer()
                            : HeroBanner(banners: viewModel.banners),
                      ),

                      // Most Popular Section
                      const SectionHeader(
                        title: "Most Popular",
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: viewModel.isPopularProductsLoading
                            ? const ProductListShimmer()
                            : ProductListSection(
                                products: viewModel.popularProducts.toList(),
                              ),
                      ),

                      // Promo Banner
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: viewModel.isSingleBannerLoading
                            ? const PromoBannerShimmer()
                            : PromoBanner(
                                imageUrl: viewModel.singleBanner?.imageUrl ?? "",
                              ),
                      ),

                      // Categories Section
                      const SectionHeader(
                        title: "Categories",
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: viewModel.isCategoriesLoading
                            ? const CategorySectionShimmer()
                            : CategorySection(
                                categories: viewModel.categories.toList(),
                              ),
                      ),

                      // Featured Section
                      const SectionHeader(
                        title: "Featured Products",
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: viewModel.isFeaturedProductsLoading
                            ? const ProductListShimmer()
                            : ProductListSection(
                                products: viewModel.featuredProducts.toList(),
                              ),
                      ),

                      SizedBox(height: screenHeight * 0.05),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

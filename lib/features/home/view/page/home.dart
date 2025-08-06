import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grabit/features/home/viewmodel/home_viewmodel.dart';
import 'package:grabit/features/home/view/widgets/skelton/category_section.dart';
import 'package:grabit/features/home/view/widgets/skelton/product_list.dart';
import 'package:grabit/features/home/view/widgets/skelton/promo_banner.dart';
import 'package:grabit/features/home/view/widgets/skelton/slider_banner.dart';
import 'package:grabit/features/home/view/widgets/banner.dart';
import 'package:grabit/features/home/view/widgets/category_section.dart';
import 'package:grabit/features/home/view/widgets/header.dart';
import 'package:grabit/features/home/view/widgets/product_list.dart';
import 'package:grabit/features/home/view/widgets/promo_banner.dart';
import 'package:grabit/features/home/view/widgets/section_header.dart';
import 'package:grabit/features/home/model/banner_model.dart';
import 'package:grabit/features/common/models/category_model.dart';
import 'package:grabit/features/common/models/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    final screenHeight = MediaQuery.of(context).size.height;

    // Trigger data loading only once when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewModel.isLoading && viewModel.sections.isEmpty) {
        viewModel.loadHomeData();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.errorMessage != null && !viewModel.isLoading && viewModel.sections.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(viewModel.errorMessage!),
                  ElevatedButton(
                    onPressed: viewModel.loadHomeData,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
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
                      ...viewModel.sections.map((section) {
                        final isSectionEmpty = section.contents.isEmpty;
                        switch (section.type) {
                          case 'banner_slider':
                            List<AppBannerModel> banners = isSectionEmpty
                                ? []
                                : section.contents.whereType<AppBannerModel>().toList();
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: viewModel.isLoading || isSectionEmpty
                                  ? const HeroBannerShimmer()
                                  : HeroBanner(banners: banners),
                            );
                          case 'catagories':
                            List<CategoryModel> categories = isSectionEmpty
                                ? []
                                : section.contents.whereType<CategoryModel>().toList();
                            return Column(
                              children: [
                                const SectionHeader(title: "Categories"),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: viewModel.isLoading || isSectionEmpty
                                      ? const CategorySectionShimmer()
                                      : CategorySection(categories: categories),
                                ),
                              ],
                            );
                          case 'banner_single':
                            final banner = isSectionEmpty
                                ? null
                                : section.contents.whereType<AppBannerModel>().firstOrNull;
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: viewModel.isLoading || isSectionEmpty || banner == null
                                  ? const PromoBannerShimmer()
                                  : PromoBanner(imageUrl: banner.imageUrl),
                            );
                          case 'products':
                            List<ProductModel> products = isSectionEmpty
                                ? []
                                : section.contents.whereType<ProductModel>().toList();
                            return Column(
                              children: [
                                SectionHeader(title: section.title ?? "Products"),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: viewModel.isLoading || isSectionEmpty
                                      ? const ProductListShimmer()
                                      : ProductListSection(products: products),
                                ),
                              ],
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      }).toList(),
                      if (viewModel.sections.isEmpty && viewModel.isLoading)
                        const Column(
                          children: [
                            HeroBannerShimmer(),
                            SectionHeader(title: "Products"),
                            ProductListShimmer(),
                            PromoBannerShimmer(),
                            SectionHeader(title: "Categories"),
                            CategorySectionShimmer(),
                            
                            SectionHeader(title: "Products"),
                            ProductListShimmer(),
                          ],
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

extension IterableExtension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
import 'package:flutter/material.dart';
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
          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HomeHeader(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HeroBanner(banners: viewModel.banners),

                    // Most Popular Section
                    SectionHeader(
                      title: "Most Popular",
                      onViewAllTap: () {},
                    ),
                    ProductListSection(
                      products: viewModel.popularProducts.toList(),
                    ),

                    // Promo Banner
                    PromoBanner(imageUrl: viewModel.singleBanner?.imageUrl ?? "",),

                    // Categories Section
                    SectionHeader(
                      title: "Categories",
                      onViewAllTap: () {},
                    ),
                    CategorySection(
                      categories: viewModel.categories.toList(),
                    ),


                    // Featured Section
                    SectionHeader(
                      title: "Featured Products",
                      onViewAllTap: () {},
                    ),
                    ProductListSection(
                      products: viewModel.featuredProducts.toList(),
                    ),

                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:grabit/features/common/domain/entities/category_entity.dart';
import 'package:grabit/features/common/domain/entities/product_entity.dart';
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
    log(MediaQuery.of(context).size.toString());
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section
          const HomeHeader(),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Hero Banner
                const HeroBanner(),

                // Most Popular Section
                SectionHeader(
                  title: "Most Popular",
                  onViewAllTap: () {
                    // Handle view all tap
                  },
                ),
                
                // Product Cards Row
                ProductListSection(
                  products: _getMostPopularProducts(),
                ),
                
                // Banner Section
                const PromoBanner(),

                // Categories Section
                SectionHeader(
                  title: "Categories",
                  onViewAllTap: () {
                    // Handle view all tap
                  },
                ),
                
                // Category Cards
                CategorySection(
                  categories: _getCategories(),
                ),

                // Featured Products Section
                SectionHeader(
                  title: "Featured Products",
                  onViewAllTap: () {
                    // Handle view all tap
                  },
                ),
                
                // Featured Product Cards Row
                ProductListSection(
                  products: _getFeaturedProducts(),
                ),
                
                // Bottom padding for nav bar
                SizedBox(height: screenHeight * (40 / 786.7)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<ProductEntity> _getMostPopularProducts() {
    return [
      ProductEntity(
        name: 'Lenovoyg6tgt6oor Wireless Speaker',
        offerPrice: '₹100',
        actualPrice: '₹300',
        discount: '65% Off',
        rating: 4,
        sku: "",
        imageUrl: ""
        
      ),
      ProductEntity(
        name: 'Lenovo K3 Mini Outdoor Wireless Speaker',
        offerPrice: '₹100',
        actualPrice: '₹300',
        discount: '65% Off',
        rating: 4,
        sku: "",
        imageUrl: ""
        
      ),ProductEntity(
        name: 'Lenovo K3 Mini Outdoor Wireless Speaker',
        offerPrice: '₹100',
        actualPrice: '₹300',
        discount: '65% Off',
        rating: 4,
        sku: "",
        imageUrl: ""
        
      ),ProductEntity(
        name: 'Lenovo K3 Mini Outdoor Wireless Speaker',
        offerPrice: '₹100',
        actualPrice: '₹300',
        discount: '65% Off',
        rating: 4,
        sku: "",
        imageUrl: ""
        
      ),
    ];
  }

  List<CategoryEntity> _getCategories() {
    return [
      CategoryEntity(
        id: 1,
        name: 'Grocery & Foods',
        imageUrl:"",
        
      ), CategoryEntity(
        id: 1,
        name: 'Grocery & Foods',
        imageUrl:"",
        
      ), CategoryEntity(
        id: 1,
        name: 'Grocery & Foods',
        imageUrl:"",
        
      ), CategoryEntity(
        id: 1,
        name: 'Grocery & Foods',
        imageUrl:"",
        
      ), CategoryEntity(
        id: 1,
        name: 'Grocery Foods',
        imageUrl:"",
        
      ),
    ];
  }

  List<ProductEntity> _getFeaturedProducts() {
    return _getMostPopularProducts(); // Same products for demo
  }
}
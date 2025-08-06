// views/main_page.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/page/home.dart';
import 'package:grabit/features/main/view/widgets/bottom_navigation.dart';
import 'package:grabit/features/main/viewmodel/main_viewmodel.dart';
import 'package:provider/provider.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    log('MainPage.build called');
    
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) {
        log('Consumer builder called with currentIndex: ${viewModel.currentIndex}');
        
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned.fill(
                child: IndexedStack(
                  index: viewModel.currentIndex,
                  children: const [
                    HomePage(),
                    CategoryPage(), // Changed from CartPage to match nav
                    CartPage(),
                    OffersPage(), // Changed from ExplorePage to match nav
                    ProfilePage(), // This matches the Account nav item
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ImprovedBottomNavBar(
                  items: [
                     NavItem(icon: Icons.home, label: 'Home'),
                    NavItem(icon: Icons.grid_view, label: 'Category'),
                    NavItem(icon: Icons.shopping_cart, label: 'Cart'),
                    NavItem(icon: Icons.local_offer, label: 'Offers'),
                    NavItem(icon: Icons.person, label: 'Account'),
                  ],
                  currentIndex: viewModel.currentIndex,
                  onTap: (index) {
                    log('onTap called with index: $index');
                    viewModel.setTab(index);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}




class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

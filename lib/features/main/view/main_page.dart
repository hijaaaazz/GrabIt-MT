// views/main_page.dart
import 'package:flutter/material.dart';
import 'package:grabit/core/routes/constants/app_colors.dart';
import 'package:grabit/features/home/view/page/home.dart';
import 'package:grabit/features/main/view/widgets/bottom_navigation.dart';
import 'package:grabit/features/main/viewmodel/main_viewmodel.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    return Scaffold(
      body: IndexedStack(
        index: viewModel.currentIndex,
        children: const [
          HomePage(),
          CartPage(),
          ExplorePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar:
      EnhancedBottomNavBar(
        currentIndex: viewModel.currentIndex,
        onTap:(index){
          viewModel.setTab(index);
        },
        items: [
          NavBarItem(icon: Icons.abc, label: "buyhwebu"),
          NavBarItem(icon: Icons.abc, label: "buyhwebu"),
          NavBarItem(icon: Icons.abc, label: "buyhwebu"),
          NavBarItem(icon: Icons.abc, label: "buyhwebu"),
          NavBarItem(icon: Icons.abc, label: "buyhwebu")
        ],
      )
      //  MotionTabBar(
      //   labels: const ["Home", "Cart", "Explore", "Profile"],
      //   initialSelectedTab: "Home",
      
      //   tabSize: 20,
        
      //   icons: const [
      //     Icons.home,
      //     Icons.shopping_cart,
      //     Icons.search,
      //     Icons.person,
      //   ],
        
      //   tabIconColor: Colors.grey,
      //   tabSelectedColor: AppColors.primary,
      //   textStyle: const TextStyle(color: Colors.black),
      //   onTabItemSelected: (int index) {
      //     viewModel.setTab(index);
      //   },
      // ),
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


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

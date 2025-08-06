import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/widgets/skelton/product_card.dart';

class ProductListShimmer extends StatelessWidget {
  final double height;
  
  const ProductListShimmer({
    super.key,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * (height / 786.7),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * (16 / 360.0)),
        children: List.generate(4, (index) => const ProductCardShimmer()),
      ),
    );
  }
}

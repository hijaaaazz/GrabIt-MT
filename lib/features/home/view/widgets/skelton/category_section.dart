import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/widgets/skelton/category_card.dart';

class CategorySectionShimmer extends StatelessWidget {
  const CategorySectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * (60 / 786.7),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * (16 / 360.0)),
      child: Row(
        children: List.generate(4, (index) {
          return [
            const Expanded(child: CategoryCardShimmer()),
            if (index < 3) SizedBox(width: screenWidth * (8 / 360.0)),
          ];
        }).expand((element) => element).toList(),
      ),
    );
  }
}

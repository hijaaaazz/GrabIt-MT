import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/widgets/skelton/base_skelton.dart';

class CategoryCardShimmer extends StatelessWidget {
  const CategoryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BaseShimmer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * (8 / 360.0)),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShimmerBox(
              width: screenHeight * 0.05,
              height: screenHeight * 0.05,
              borderRadius: BorderRadius.circular(4),
            ),
            SizedBox(height: screenHeight * (4 / 786.7)),
            ShimmerBox(
              width: screenWidth * 0.15,
              height: screenHeight * (12 / 786.7),
            ),
          ],
        ),
      ),
    );
  }
}

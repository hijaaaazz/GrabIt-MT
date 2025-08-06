import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/widgets/skelton/base_skelton.dart';

class PromoBannerShimmer extends StatelessWidget {
  const PromoBannerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BaseShimmer(
      child: Container(
        height: screenHeight * (90 / 786.7),
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * (16 / 360.0),
          vertical: screenHeight * (8 / 786.7),
        ),
        child: ShimmerBox(
          width: double.infinity,
          height: double.infinity,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

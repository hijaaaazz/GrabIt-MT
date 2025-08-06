import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/widgets/skelton/base_skelton.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BaseShimmer(
      child: Container(
        width: screenWidth * (90 / 360.0),
        margin: EdgeInsets.only(right: screenWidth * (8 / 360.0)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * (8 / 360.0)),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image shimmer
            ShimmerBox(
              height: screenHeight * (70 / 786.7),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(screenWidth * (8 / 360.0)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * (6 / 360.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sale badge shimmer
                    ShimmerBox(
                      width: screenWidth * 0.15,
                      height: screenHeight * (12 / 786.7),
                      borderRadius: BorderRadius.circular(screenWidth * (2 / 360.0)),
                    ),
                    SizedBox(height: screenHeight * (2 / 786.7)),
                    // Title shimmer
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerBox(
                            width: double.infinity,
                            height: screenHeight * (12 / 786.7),
                          ),
                          SizedBox(height: screenHeight * (2 / 786.7)),
                          ShimmerBox(
                            width: screenWidth * 0.15,
                            height: screenHeight * (12 / 786.7),
                          ),
                        ],
                      ),
                    ),
                    // Rating shimmer
                    Row(
                      children: List.generate(5, (index) {
                        return ShimmerBox(
                          width: screenWidth * (8 / 360.0),
                          height: screenWidth * (8 / 360.0),
                        );
                      }),
                    ),
                    SizedBox(height: screenHeight * (2 / 786.7)),
                    // Price shimmer
                    Row(
  children: [
    ShimmerBox(
      width: screenWidth * 0.12,
      height: screenHeight * (12 / 786.7),
    ),
    SizedBox(width: screenWidth * (4 / 360.0)),
    Expanded(
      child: ShimmerBox(
        height: screenHeight * (12 / 786.7),
      ),
    ),
  ],
)

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

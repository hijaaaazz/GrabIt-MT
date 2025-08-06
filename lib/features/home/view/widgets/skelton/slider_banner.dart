import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/widgets/skelton/base_skelton.dart';

class HeroBannerShimmer extends StatelessWidget {
  const HeroBannerShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BaseShimmer(
      child: SizedBox(
        width: screenWidth,
        height: screenHeight * 0.12,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: screenWidth,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(screenWidth * (8 / 360)),
              ),
            ),
            // Dot indicators
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      width: index == 0 ? 10.0 : 6.0,
                      height: 6.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

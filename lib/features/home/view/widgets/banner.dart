// lib/features/home/widgets/hero_banner.dart
import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * (110 / 786.7),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFE53935)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background people image area
          Positioned(
            left: screenWidth * (16 / 360.0),
            top: screenHeight * (16 / 786.7),
            child: Container(
              width: screenWidth * (120 / 360.0),
              height: screenHeight * (68 / 786.7),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(screenWidth * (4 / 360.0)),
              ),
            ),
          ),
          // 70% OFF Badge
          Positioned(
            right: screenWidth * (80 / 360.0),
            top: screenHeight * (16 / 786.7),
            child: Container(
              width: screenWidth * (40 / 360.0),
              height: screenWidth * (40 / 360.0),
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '70%\nOFF',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * (10 / 360.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // MOONSOON DEALS Badge
          Positioned(
            right: screenWidth * (16 / 360.0),
            bottom: screenHeight * (16 / 786.7),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * (8 / 360.0),
                vertical: screenHeight * (4 / 786.7),
              ),
              decoration: BoxDecoration(
                color: Colors.red[700],
                borderRadius: BorderRadius.circular(screenWidth * (4 / 360.0)),
              ),
              child: Text(
                'MOONSOON\nDEALS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * (10 / 360.0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
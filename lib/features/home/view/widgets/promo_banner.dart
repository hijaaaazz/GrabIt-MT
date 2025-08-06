
// lib/features/home/widgets/promo_banner.dart
import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * (80 / 786.7),
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * (16 / 360.0),
        vertical: screenHeight * (8 / 786.7),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF92C848),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  'বাংলার সংস্কৃতি\nসাহিত্য পড়ুন\nনতুন বইয়ের সাথে',
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
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.menu_book,
                  size: screenWidth * (32 / 360.0),
                  color: Colors.brown[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


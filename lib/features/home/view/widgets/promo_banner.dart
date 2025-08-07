import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/widgets/cached_viewer.dart';

class PromoBanner extends StatelessWidget {
  final String imageUrl;

  const PromoBanner({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * (90 / 786.7),
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * (16 / 360.0),
        vertical: screenHeight * (8 / 786.7),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedImageViewer(
  imageUrl: imageUrl,
  width: double.infinity,
  height: screenHeight * (70 / 786.7),
  fit: BoxFit.cover,
),


      ),
    );
  }
}

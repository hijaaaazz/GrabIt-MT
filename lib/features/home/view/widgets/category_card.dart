import 'package:flutter/material.dart';
import 'package:grabit/features/home/view/widgets/cached_viewer.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback? onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * (8 / 360.0)),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
CachedImageViewer(
  imageUrl: icon,
  height: screenHeight * 0.05,
  fit: BoxFit.contain,
  isIconStyle: true,
),


            SizedBox(height: screenHeight * (4 / 786.7)),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * (8 / 360.0),
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

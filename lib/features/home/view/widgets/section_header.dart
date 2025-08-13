import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllTap;
  
  const SectionHeader({
    Key? key,
    required this.title,
    this.onViewAllTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * (32 / 786.7),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * (16 / 360.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * (16 / 360.0),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            onTap: onViewAllTap,
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: screenWidth * (12 / 360.0),
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
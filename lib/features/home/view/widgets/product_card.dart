
// lib/features/home/widgets/product_card.dart
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String originalPrice;
  final String discount;
  final int rating;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return GestureDetector(
      onTap: onTap,
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
            // Product Image
            Container(
              height: screenHeight * (70 / 786.7),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(screenWidth * (8 / 360.0)),
                ),
              ),
              child: Center(
                child: Container(
                  width: screenWidth * (40 / 360.0),
                  height: screenHeight * (40 / 786.7),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(screenWidth * (4 / 360.0)),
                  ),
                ),
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * (6 / 360.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sale Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * (4 / 360.0),
                        vertical: screenHeight * (1 / 786.7),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(screenWidth * (2 / 360.0)),
                      ),
                      child: Text(
                        'Sale $discount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * (8 / 360.0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: screenHeight * (2 / 786.7)),
                    
                    // Product Title
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * (10 / 360.0),
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    // Rating
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.orange,
                            size: screenWidth * (8 / 360.0),
                          );
                        }),
                      ],
                    ),
                    
                    SizedBox(height: screenHeight * (2 / 786.7)),
                    
                    // Price
                    Row(
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: screenWidth * (12 / 360.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: screenWidth * (4 / 360.0)),
                        Text(
                          originalPrice,
                          style: TextStyle(
                            fontSize: screenWidth * (10 / 360.0),
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
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

// lib/features/home/widgets/product_card.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grabit/features/common/models/product_model.dart';
import 'package:grabit/features/common/view/cached_viewer.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.product,
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
              child: ClipRRect(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(screenWidth * (8 / 360.0)),
  ),
  child:
  CachedImageViewer(
  imageUrl: product.imageUrl,
  width: double.infinity,
  height: screenHeight * (70 / 786.7),
  fit: BoxFit.cover,
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
                        'Sale ${product.discount}',
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
                        product.name,
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
                            index < product.rating ? Icons.star : Icons.star_border,
                            color: Colors.orange,
                            size: screenWidth * (8 / 360.0),
                          );
                        }),
                      ],
                    ),
                    
                    SizedBox(height: screenHeight * (2 / 786.7)),
                    
                    // Price
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            product.offerPrice,
                            style: TextStyle(
                              fontSize: screenWidth * (8 / 360.0),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: screenWidth * (4 / 360.0)),
                          Text(
                            product.actualPrice,
                            style: TextStyle(
                              fontSize: screenWidth * (10 / 360.0),
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
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
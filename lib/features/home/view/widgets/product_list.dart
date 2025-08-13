import 'package:flutter/material.dart';
import 'package:grabit/features/home/model/product_model.dart';
import 'product_card.dart';

class ProductListSection extends StatelessWidget {
  final List<ProductModel> products;
  final double height;

  const ProductListSection({
    super.key,
    required this.products,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return SizedBox(
      height: screenHeight * (height / 786.7),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: screenWidth * (16 / 360.0)),
        children: products.map((product) => ProductCard(
          product: product,
          onTap: (){
            
          },
        )).toList(),
      ),
    );
  }
}
// lib/features/home/widgets/product_list_section.dart
import 'package:flutter/material.dart';
import 'package:grabit/features/common/data/product_model.dart';
import 'package:grabit/features/common/domain/entities/product_entity.dart';
import 'product_card.dart';

class ProductListSection extends StatelessWidget {
  final List<ProductModel> products;
  final double height;

  const ProductListSection({
    Key? key,
    required this.products,
    this.height = 150,
  }) : super(key: key);

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
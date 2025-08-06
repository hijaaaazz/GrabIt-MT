
// lib/features/home/widgets/category_section.dart
import 'package:flutter/material.dart';
import 'package:grabit/features/common/domain/entities/category_entity.dart';
import 'category_card.dart';

class CategorySection extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategorySection({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * (60 / 786.7),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * (16 / 360.0)),
      child: Row(
        children: categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          
          return [
            Expanded(
              child: CategoryCard(
                title: category.name,
                icon: category.imageUrl,
                onTap: (){

                },
              ),
            ),
            if (index < categories.length - 1)
              SizedBox(width: screenWidth * (8 / 360.0)),
          ];
        }).expand((element) => element).toList(),
      ),
    );
  }
}
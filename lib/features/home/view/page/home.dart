import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Section
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF8BC34A),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    // Shopping Cart Icon
                    const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    // Search Bar
                    Expanded(
                      child: Container(
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '',
                                ),
                              ),
                            ),
                            Icon(Icons.search, color: Colors.grey,size: 16,),
                            SizedBox(width: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Notification Bell
                    Stack(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Banner
                  Container(
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(

                        image: NetworkImage('/placeholder.svg?height=200&width=400'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                  ),
                  
                  // Most Popular Section
                  _sectionHeader("Most Popular"),
                  
                  // Product Cards Row
                  SizedBox(
                    height: 170,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildProductCard(
                          'Lenovo K3 Mini Outdoor Wireless Speaker',
                          '\$100',
                          '\$300',
                          '65% Off',
                          4.0,
                        ),
                        _buildProductCard(
                          'Mi Multicolor Mini Backpack Travel Backpack',
                          '\$100',
                          '\$300',
                          '65% Off',
                          4.0,
                        ),
                        _buildProductCard(
                          'Motul 5100 10W40 4-Stroke Motor cycle Engine Oil 1 Litre',
                          '\$100',
                          '\$300',
                          '65% Off',
                          4.0,
                        ),
                        _buildProductCard(
                          'Motul 5100 10W40 4-Stroke Motor cycle Engine Oil 1 Litre',
                          '\$100',
                          '\$300',
                          '65% Off',
                          4.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  
                  // Banner Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color(0xFF8BC34A),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'বাংলার সংস্কৃতি\nসাহিত্য পড়ুন\nনতুন বইয়ের সাথে\nবইয়ের সাথে',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('/placeholder.svg?height=120&width=200'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Categories Section
                  _sectionHeader("Categories"),
                  
                  // Category Cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(child: _buildCategoryCard('Grocery & Foods', Icons.shopping_basket)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCategoryCard('Mobile & Devices', Icons.phone_android)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCategoryCard('Consumer Electronics', Icons.tv)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildCategoryCard('Kids & Mom', Icons.child_care)),
                      ],
                    ),
                  ),
                  
                  // Featured Products Section
                  _sectionHeader("Featured Products"),
                  
                  // Featured Product Cards Row
                  SizedBox(
                    height: 170,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildProductCard(
                          'Lenovo K3 Mini Outdoor Wireless Speaker',
                          '\$100',
                          '\$300',
                          '65% Off',
                          4.0,
                        ),
                        _buildProductCard(
                          'Mi Multicolor Mini Backpack Travel Backpack',
                          '\$100',
                          '\$300',
                          '65% Off',
                          4.0,
                        ),
                        _buildProductCard(
                          'Motul 5100 10W40 4-Stroke Motor cycle Engine Oil 1 Litre',
                          '\$100',
                          '\$300',
                          '65% Off',
                          4.0,
                        ),
                        _buildProductCard(
                          'Motul 5100 10W40 4-Stroke Motor cycle Engine Oil 1 Litre',
                          '\$100',
                          '\$300',
                          '65% Off',
                          4.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }
  
  Widget _buildProductCard(String title, String price, String originalPrice, String discount, double rating) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sale Badge
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5722),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Sale $discount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Product Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 7,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // Rating
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 8,
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 3),
                // Price
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      originalPrice,
                      style: const TextStyle(
                        fontSize: 4,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:  16.0),
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            style: ButtonStyle(minimumSize: WidgetStateProperty.all(const Size(60, 10))),
            onPressed: () {},
            child: const Text('View all',style: TextStyle(fontSize: 10),),
          ),
        ],
      ),
    );
  }
  
}
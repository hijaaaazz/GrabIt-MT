import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * (80 / 786.7),
      decoration: const BoxDecoration(
        color: Color(0xFF92C848), // Primary green
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * (16 / 360.0),
          ),
          child: Row(
            children: [
              // Shopping Cart Icon
              Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
                size: screenWidth * (20 / 360.0),
              ),
              SizedBox(width: screenWidth * (12 / 360.0)),
              
              // Search Bar
              Expanded(
                child: Container(
                  height: screenHeight * (28 / 786.7),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(91, 0, 0, 0),
                        offset: const Offset(1, 1),
                        blurRadius: 10
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * (10 / 360.0)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: screenWidth * (12 / 360.0)),
                      Expanded(
                        child: TextField(
                          cursorHeight: 10,
                          cursorWidth:1.5 ,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search products...',
                            hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: screenWidth * (12 / 360.0),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.grey[600],
                        size: screenWidth * (16 / 360.0),
                      ),
                      SizedBox(width: screenWidth * (12 / 360.0)),
                    ],
                  ),
                ),
              ),
              
              SizedBox(width: screenWidth * (12 / 360.0)),
              
              // Notification Bell
              Stack(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                    size: screenWidth * (20 / 360.0),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: screenWidth * (6 / 360.0),
                      height: screenWidth * (6 / 360.0),
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
    );
  }
}

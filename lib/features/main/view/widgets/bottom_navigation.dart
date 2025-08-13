import 'package:flutter/material.dart';

class ImprovedBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<NavItem> items;

  const ImprovedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items
  });

  @override
  State<ImprovedBottomNavBar> createState() => _ImprovedBottomNavBarState();
}

class _ImprovedBottomNavBarState extends State<ImprovedBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: -10.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void didUpdateWidget(ImprovedBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
       child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 50,
               decoration: const BoxDecoration(
                color: Color(0xFFDBDBDB),
              ),
            ),
          ),
          // Navigation items
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.items.asMap().entries.map((entry) {
                  int index = entry.key;
                  NavItem item = entry.value;
                  bool isSelected = index == widget.currentIndex;
            
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => widget.onTap(index),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 70,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (isSelected)
                              AnimatedBuilder(
                                animation: _slideAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, _slideAnimation.value),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Background oval for selected item
                                        Container(
                                          width: 50,
                                          height:38,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xFFDBDBDB),
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        // Label for selected item
                                        // Text(
                                        //   item.label,
                                        //   style: const TextStyle(
                                        //     color: Color(0xFF92C848),
                                        //     fontSize: 8,
                                        //     fontFamily: 'Montserrat',
                                        //     fontWeight: FontWeight.w600,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            // Green circle indicator for selected item
                            if (isSelected)
                              AnimatedBuilder(
                                animation: _slideAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(0, _slideAnimation.value - 6),
                                    child: ScaleTransition(
                                      scale: _scaleAnimation,
                                      child: Container(
                                        width: 27,
                                        height: 27,
                                        decoration: const ShapeDecoration(
                                          color: Color(0xFF92C848),
                                          shape: OvalBorder(),
                                        ),
                                        child: Icon(
                                          item.icon,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            
                              Positioned(
                                bottom: 8,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (!isSelected)
                                    Icon(
                                      item.icon,
                                      color: Colors.grey[600],
                                      size: 20,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.label,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 8,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem {
  final IconData icon;
  final String label;

  NavItem({required this.icon, required this.label});
}

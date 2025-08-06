import 'package:flutter/material.dart';
import 'package:grabit/features/main/viewmodel/main_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EnhancedBottomNavBar extends StatefulWidget {
  final List<NavBarItem> items;
  final int currentIndex;
  final Function(int) onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final Color backgroundColor;
  final double height;
  final bool showBadge;
  final List<int>? badgeCounts;

  const EnhancedBottomNavBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.selectedColor = const Color(0xFF4CAF50),
    this.unselectedColor = const Color(0xFF757575),
    this.backgroundColor = Colors.white,
    this.height = 70,
    this.showBadge = false,
    this.badgeCounts,
  }) : super(key: key);

  @override
  State<EnhancedBottomNavBar> createState() => _EnhancedBottomNavBarState();
}

class _EnhancedBottomNavBarState extends State<EnhancedBottomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(widget.currentIndex.toDouble(), 0),
      end: Offset(widget.currentIndex.toDouble(), 0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _scaleController.forward();
  }

  @override
  void didUpdateWidget(EnhancedBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _slideAnimation = Tween<Offset>(
        begin: Offset(oldWidget.currentIndex.toDouble(), 0),
        end: Offset(widget.currentIndex.toDouble(), 0),
      ).animate(CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeInOut,
      ));
      
      _slideController.reset();
      _slideController.forward();
      
      _scaleController.reset();
      _scaleController.forward();
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Sliding indicator background
            AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                return Positioned(
                  left: (MediaQuery.of(context).size.width / widget.items.length) * 
                        widget.currentIndex + 
                        (MediaQuery.of(context).size.width / widget.items.length - 40) / 2,
                  top: 8,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: widget.selectedColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: widget.selectedColor.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // Navigation items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: widget.items.asMap().entries.map((entry) {
                int index = entry.key;
                NavBarItem item = entry.value;
                bool isSelected = index == widget.currentIndex;
                int? badgeCount = widget.badgeCounts != null && 
                                 widget.badgeCounts!.length > index 
                                 ? widget.badgeCounts![index] 
                                 : null;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => widget.onTap(index),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Icon with badge
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width: 40,
                                height: 40,
                                child: Icon(
                                  item.icon,
                                  color: isSelected ? Colors.white : widget.unselectedColor,
                                  size: 20,
                                ),
                              ),
                              // Badge
                              if (widget.showBadge && badgeCount != null && badgeCount > 0)
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 1),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      badgeCount > 99 ? '99+' : badgeCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Label
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected ? widget.selectedColor : widget.unselectedColor,
                            ),
                            child: Text(
                              item.label,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem {
  final IconData icon;
  final String label;

  const NavBarItem({
    required this.icon,
    required this.label,
  });
}
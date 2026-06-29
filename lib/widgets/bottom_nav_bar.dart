import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget{
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Padding(padding: const EdgeInsets.only(
        left: 65, 
        right: 65, 
        bottom: 18
      ),
    child: Container(
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(Icons.home_rounded, 0),
          _buildItem(Icons.explore_outlined, 1),
          _buildItem(Icons.description_outlined, 2),
          _buildItem(Icons.calendar_today_outlined, 3),
          _buildItem(Icons.person_outline_rounded, 4),
        ],
      ),
    ),
    ),
  );
  }

  Widget _buildItem(IconData icon, int index) {
    final isSelected = index == currentIndex;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF1E1E1E) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black38,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
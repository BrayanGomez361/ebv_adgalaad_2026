import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  
  // Parámetros opcionales para personalizar colores y tamaño si lo deseas
  final Color selectedBackgroundColor;
  final Color unselectedBackgroundColor;
  final Color selectedContentColor;
  final Color unselectedContentColor;

  const CategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.selectedBackgroundColor = const Color.fromARGB(255, 3, 32, 66),
    this.unselectedBackgroundColor = CupertinoColors.black,
    this.selectedContentColor = const Color.fromARGB(255, 109, 167, 220),
    this.unselectedContentColor = const Color.fromARGB(255, 195, 194, 183),
  });

  @override
  Widget build(BuildContext context) {
    final currentColor = isSelected ? selectedContentColor : unselectedContentColor;

    return GestureDetector(
      
      onTap: onTap,
      
      child: Row(
        
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: currentColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              //height: 0.5,
              color: currentColor,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
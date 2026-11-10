import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final double size; // Tamaño del cuadro exterior
  final double iconSize; // Tamaño del ícono check interno
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final double borderRadius;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 28.0,
    this.iconSize = 15.0,
    this.activeColor = Colors.blueAccent,
    this.checkColor = Colors.white,
    this.borderColor = Colors.white54,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onChanged != null;

    return GestureDetector(
      onTap: isEnabled ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: value ? activeColor : borderColor,
            width: 2,
          ),
        ),
        child: value
            ? Icon(
                Icons.check,
                size: iconSize,
                color: checkColor,
              )
            : null,
      ),
    );
  }
}
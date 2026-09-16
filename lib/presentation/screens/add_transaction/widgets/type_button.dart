import 'package:finora/core/constants.dart';
import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  const TypeButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? cardPalettesMap['primaryCardBalance']![0]
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected
                  ? Colors.white
                  : cardPalettesMap['primaryCardBalance']![0],
            ),

            const SizedBox(width: 8),

            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : cardPalettesMap['primaryCardBalance']![0],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/models.dart';

class SweetCategoryCard extends StatelessWidget {
  final SweetCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  const SweetCategoryCard({
    super.key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color accentPink = const Color(0xFFAD1457);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100,
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color(0xFFF8BBD0) 
              : (isDark ? const Color(0xFF333333) : Colors.white),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            if (!isSelected) 
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                category.imageUrl,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.cake_outlined,
                  color: isSelected ? Colors.white : accentPink,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.white : (isDark ? Colors.white : accentPink),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

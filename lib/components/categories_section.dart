import 'package:flutter/material.dart';
import '../models/models.dart';
import 'sweet_category_card.dart';

class CategoriesSection extends StatelessWidget {
  final List<SweetCategory> categories;
  final String selectedCategory;
  final Function(SweetCategory) onCategoryTap;

  const CategoriesSection({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFFAD1457),
            ),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category.title;
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: SweetCategoryCard(
                  category: category,
                  isSelected: isSelected,
                  onTap: () => onCategoryTap(category),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

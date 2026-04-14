import 'package:flutter/material.dart';
import '../models/models.dart';
import 'dessert_landscape_card.dart';

class FeaturedDessertsSection extends StatelessWidget {
  final List<DessertItem> desserts;
  final Function(DessertItem) onDessertTap;

  const FeaturedDessertsSection({
    super.key,
    required this.desserts,
    required this.onDessertTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: desserts.length,
        itemBuilder: (context, index) {
          final dessert = desserts[index];
          return DessertLandscapeCard(
            dessert: dessert,
            onTap: () => onDessertTap(dessert),
          );
        },
      ),
    );
  }
}

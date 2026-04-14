import 'package:flutter/material.dart';
import '../models/models.dart';
import '../components/dessert_landscape_card.dart';

class FavoritesScreen extends StatelessWidget {
  final List<DessertItem> favorites;
  final Function(DessertItem) onToggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color accentPink = const Color(0xFFAD1457);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFFF8F9),
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(fontWeight: FontWeight.w300)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: isDark ? Colors.white : accentPink,
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.pink[100]),
                  const SizedBox(height: 20),
                  Text(
                    'No favorites yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final dessert = favorites[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DessertLandscapeCard(
                    dessert: dessert,
                    onTap: () {}, // Detail navigation can be added here
                  ),
                );
              },
            ),
    );
  }
}

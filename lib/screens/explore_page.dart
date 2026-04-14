import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../api/mock_pinkie_pie_service.dart';
import '../components/featured_desserts_section.dart';
import '../components/categories_section.dart';
import '../components/activity_section.dart';
import '../models/models.dart';
import 'order_details_screen.dart';
import '../main.dart';

class ExplorePage extends StatefulWidget {
  final Function(DessertItem) onToggleFavorite;
  final Function(DessertItem) onAddToCart;

  const ExplorePage({
    super.key,
    required this.onToggleFavorite,
    required this.onAddToCart,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final MockPinkiePieService _service = MockPinkiePieService();
  String _selectedCategory = 'All';
  bool isCreamFilterEnabled = false;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appState = PinkiePieApp.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            onPressed: () => appState.toggleTheme(),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isCreamFilterEnabled = !isCreamFilterEnabled;
              });
            },
            icon: AnimatedScale(
              scale: isCreamFilterEnabled ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Icon(
                Icons.opacity,
                color: isCreamFilterEnabled ? const Color(0xFFF8BBD0) : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<ExploreData>(
            future: _service.getExploreData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: colorScheme.primary));
              }
              if (snapshot.hasError) return const Center(child: Text('Error loading data'));
              
              final data = snapshot.data!;
              
              // FILTER LOGIC
              final filteredDesserts = data.featuredDesserts.where((dessert) {
                bool matchesCategory = _selectedCategory == 'All' || dessert.category == _selectedCategory;
                bool matchesCream = !isCreamFilterEnabled || 
                    dessert.name.toLowerCase().contains('cream') || 
                    dessert.tags.any((tag) => tag.toLowerCase().contains('cream'));
                return matchesCategory && matchesCream;
              }).toList();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FOOD NEAR ME (Sweet Selections)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      child: Text(
                        'Desserts near me',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: FeaturedDessertsSection(
                        key: ValueKey('featured_${_selectedCategory}_$isCreamFilterEnabled'),
                        desserts: filteredDesserts,
                        onDessertTap: (dessert) {
                          context.go('/0/restaurant/${dessert.id}');
                        },
                      ),
                    ),
                    const SizedBox(height: 24),

                    // CATEGORIES
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        'Categories',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    CategoriesSection(
                      categories: data.categories,
                      selectedCategory: _selectedCategory,
                      onCategoryTap: (cat) {
                        setState(() {
                          // Toggle selection: if already selected, go back to 'All'
                          _selectedCategory = (_selectedCategory == cat.title) ? 'All' : cat.title;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    // ACTIVITY
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text(
                        "Friend's Activity",
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    ActivitySection(posts: data.activityPosts),
                    const SizedBox(height: 100), // Space for FAB
                  ],
                ),
              );
            },
          ),
          if (appState.cartItems.isNotEmpty)
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderDetailsScreen()),
                  );
                },
                backgroundColor: colorScheme.primary,
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: Text(
                  '${appState.cartItems.length} items in cart',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

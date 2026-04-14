import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'explore_page.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';
import '../main.dart';

class MainNavigation extends StatefulWidget {
  final int tabIndex;

  const MainNavigation({super.key, this.tabIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  void _onItemTapped(int index) {
    context.go('/$index');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appState = PinkiePieApp.of(context);

    final List<Widget> pages = [
      ExplorePage(
        onToggleFavorite: (item) => appState.toggleFavorite(item),
        onAddToCart: (item) => appState.addToCart(item),
      ),
      const OrdersScreen(),
      ProfileScreen(
        favoriteCount: appState.favorites.length,
        cartCount: appState.cartItems.length,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: widget.tabIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 20),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: colorScheme.outline.withOpacity(0.5), width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
            _buildNavItem(1, Icons.receipt_long_outlined, Icons.receipt_long, 'Orders'),
            _buildNavItem(2, Icons.person_outline, Icons.person, 'Account'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = widget.tabIndex == index;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? colorScheme.primary.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? colorScheme.tertiary : Colors.grey[600],
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? colorScheme.tertiary : Colors.grey[600],
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

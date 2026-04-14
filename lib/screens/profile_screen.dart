import 'package:flutter/material.dart';
import '../main.dart';

class ProfileScreen extends StatelessWidget {
  final int favoriteCount;
  final int cartCount;

  const ProfileScreen({
    super.key,
    required this.favoriteCount,
    required this.cartCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final name = PinkiePieApp.of(context).userName;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Centered Profile Image
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage('assets/avatars/user_1.png'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // User Name
            Text(
              name,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle / Points
            Text(
              'Gold Member  •  1,250 Points',
              style: TextStyle(
                color: colorScheme.tertiary.withOpacity(0.6),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 60),
            // Options
            _buildOption(
              context,
              'View Pinkie Pie',
              Icons.storefront_outlined,
              () {},
            ),
            const SizedBox(height: 16),
            _buildOption(
              context,
              'Log out',
              Icons.logout_rounded,
              () => Navigator.pushReplacementNamed(context, '/login'),
              isDestructive: true,
            ),
            const Spacer(),
            // Dark Mode Toggle (Small and at the bottom)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dark Mode',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: Theme.of(context).brightness == Brightness.dark,
                    onChanged: (val) => PinkiePieApp.of(context).toggleTheme(),
                    activeColor: colorScheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDestructive ? Colors.red.withOpacity(0.1) : const Color(0xFFF3D6E0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDestructive ? Colors.red[300] : colorScheme.secondary,
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDestructive ? Colors.red[300] : colorScheme.tertiary,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: isDestructive ? Colors.red[200] : Colors.grey[300],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

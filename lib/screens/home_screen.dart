import 'package:flutter/material.dart';
import '../main.dart';
import 'mood_screen.dart';
import 'routine_screen.dart';
import 'tasks_screen.dart';
import 'notes_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _activities = [
    {"task": "Finish homework", "isChecked": false},
    {"task": "Drink water", "isChecked": true},
    {"task": "Read 10 pages", "isChecked": false},
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color accentPink = const Color(0xFFAD1457);
    Color primaryPink = const Color(0xFFF8BBD0);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFFF8F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // TOP SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Day',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.pink[200] : accentPink,
                    ),
                  ),
                  Row(
                    children: [
                      _buildHeaderIcon(context, isDark ? Icons.light_mode : Icons.dark_mode, () {
                        PinkiePieApp.of(context).toggleTheme();
                      }),
                      const SizedBox(width: 12),
                      _buildHeaderIcon(context, Icons.person_outline, () {}),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // HORIZONTAL CARDS
              SizedBox(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFeatureCard(
                      "Today's Focus",
                      "3 tasks remaining",
                      "assets/images/logo.png", // Replaced missing asset with logo.png
                      primaryPink,
                    ),
                    _buildFeatureCard(
                      "Notes",
                      "5 saved notes",
                      "assets/images/logo.png", // Replaced missing asset with logo.png
                      const Color(0xFFFCE4EC),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // CATEGORIES GRID
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : accentPink,
                ),
              ),
              const SizedBox(height: 15),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.9,
                children: [
                  _buildCategoryItem(context, "Tasks", "Manage tasks", "assets/images/logo.png", () => Navigator.push(context, MaterialPageRoute(builder: (context) => TasksScreen()))),
                  _buildCategoryItem(context, "Notes", "Write ideas", "assets/images/logo.png", () => Navigator.push(context, MaterialPageRoute(builder: (context) => NotesScreen()))),
                  _buildCategoryItem(context, "Mood", "Track emotions", "assets/images/logo.png", () => Navigator.push(context, MaterialPageRoute(builder: (context) => MoodScreen()))),
                  _buildCategoryItem(context, "Routine", "Daily habits", "assets/images/logo.png", () => Navigator.push(context, MaterialPageRoute(builder: (context) => RoutineScreen()))),
                ],
              ),
              const SizedBox(height: 30),

              // ACTIVITY SECTION
              Text(
                "Today's Activity",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : accentPink,
                ),
              ),
              const SizedBox(height: 15),
              ...List.generate(_activities.length, (index) {
                return _buildActivityItem(index, isDark);
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderIcon(BuildContext context, IconData icon, VoidCallback onTap) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF333333) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Icon(icon, color: const Color(0xFFAD1457), size: 24),
      ),
    );
  }

  Widget _buildFeatureCard(String title, String subtitle, String imagePath, Color color) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFAD1457),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFFAD1457).withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(imagePath, height: 90, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 50, color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title, String subtitle, String imagePath, VoidCallback onTap) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF333333) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(child: Image.asset(imagePath, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Icon(Icons.image, size: 50, color: Colors.grey))),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.pink[200] : const Color(0xFFAD1457),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(int index, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF333333) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: _activities[index]["isChecked"],
            onChanged: (val) {
              setState(() {
                _activities[index]["isChecked"] = val;
              });
            },
            activeColor: const Color(0xFFF8BBD0),
            checkColor: const Color(0xFFAD1457),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          Text(
            _activities[index]["task"],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black87,
              decoration: _activities[index]["isChecked"] ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}

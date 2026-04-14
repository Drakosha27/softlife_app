import 'package:flutter/material.dart';

class RoutineScreen extends StatefulWidget {
  @override
  _RoutineScreenState createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  final Map<String, List<Map<String, dynamic>>> _routines = {
    "Morning": [
      {"title": "Wake up at 7:00 AM", "isDone": true},
      {"title": "Glass of water", "isDone": true},
      {"title": "Meditation", "isDone": false},
    ],
    "Afternoon": [
      {"title": "Lunch break", "isDone": true},
      {"title": "Check emails", "isDone": false},
    ],
    "Evening": [
      {"title": "Skincare", "isDone": false},
      {"title": "Read a book", "isDone": false},
    ],
  };

  void _toggleRoutine(String section, int index) {
    setState(() {
      _routines[section]![index]["isDone"] = !_routines[section]![index]["isDone"];
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Routine', style: TextStyle(color: isDark ? Colors.pink[200] : Color(0xFFAD1457))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFAD1457)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          _buildRoutineSection("Morning", Icons.wb_sunny_outlined, Color(0xFFFFF3E0), isDark),
          SizedBox(height: 25),
          _buildRoutineSection("Afternoon", Icons.wb_twilight, Color(0xFFE3F2FD), isDark),
          SizedBox(height: 25),
          _buildRoutineSection("Evening", Icons.dark_mode_outlined, Color(0xFFF3E5F5), isDark),
        ],
      ),
    );
  }

  Widget _buildRoutineSection(String title, IconData icon, Color color, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF333333) : color,
        borderRadius: BorderRadius.circular(30),
        border: isDark ? Border.all(color: Color(0xFF444444)) : null,
      ),
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Color(0xFFAD1457)),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF4A148C)),
              ),
            ],
          ),
          SizedBox(height: 20),
          ...List.generate(_routines[title]!.length, (index) {
            final item = _routines[title]![index];
            return Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: () => _toggleRoutine(title, index),
                child: Row(
                  children: [
                    Icon(
                      item["isDone"] ? Icons.check_circle : Icons.circle_outlined,
                      size: 20,
                      color: item["isDone"] ? Color(0xFFAD1457) : Colors.grey[400],
                    ),
                    SizedBox(width: 15),
                    Text(
                      item["title"],
                      style: TextStyle(
                        fontSize: 16,
                        color: item["isDone"] ? Colors.grey : (isDark ? Colors.white : Color(0xFF4A148C)),
                        decoration: item["isDone"] ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

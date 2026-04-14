import 'package:flutter/material.dart';

class MoodScreen extends StatefulWidget {
  @override
  _MoodScreenState createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  String? _selectedMood;
  final List<Map<String, dynamic>> _moodHistory = [
    {"mood": "Happy", "date": "Oct 24, 10:00 AM"},
    {"mood": "Calm", "date": "Oct 23, 09:00 PM"},
    {"mood": "Productive", "date": "Oct 23, 02:00 PM"},
  ];

  final List<Map<String, dynamic>> _moods = [
    {"label": "Happy", "emoji": "😊", "color": Color(0xFFFFF9C4)},
    {"label": "Calm", "emoji": "😌", "color": Color(0xFFE1F5FE)},
    {"label": "Tired", "emoji": "😴", "color": Color(0xFFF3E5F5)},
    {"label": "Productive", "emoji": "💪", "color": Color(0xFFE8F5E9)},
  ];

  void _selectMood(String mood) {
    setState(() {
      _selectedMood = mood;
      _moodHistory.insert(0, {
        "mood": mood,
        "date": "Just now",
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker', style: TextStyle(color: isDark ? Colors.pink[200] : Color(0xFFAD1457))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFAD1457)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How are you feeling?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: isDark ? Colors.white : Color(0xFF4A148C)),
            ),
            SizedBox(height: 30),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: _moods.length,
              itemBuilder: (context, index) {
                final mood = _moods[index];
                bool isSelected = _selectedMood == mood["label"];
                return GestureDetector(
                  onTap: () => _selectMood(mood["label"]),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isDark ? Color(0xFF333333) : mood["color"],
                      borderRadius: BorderRadius.circular(30),
                      border: isSelected 
                          ? Border.all(color: Color(0xFFAD1457), width: 2)
                          : isDark ? Border.all(color: Color(0xFF444444)) : null,
                      boxShadow: [
                        if (isSelected) BoxShadow(color: Colors.pink.withOpacity(0.1), blurRadius: 15)
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(mood["emoji"], style: TextStyle(fontSize: 40)),
                        SizedBox(height: 10),
                        Text(
                          mood["label"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                            color: isDark ? Colors.white : Color(0xFF4A148C),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 40),
            Text(
              "History",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: isDark ? Colors.white : Color(0xFF4A148C)),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _moodHistory.length,
              itemBuilder: (context, index) {
                final item = _moodHistory[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xFF333333) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item["mood"]!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFFAD1457))),
                      Text(item["date"]!, style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

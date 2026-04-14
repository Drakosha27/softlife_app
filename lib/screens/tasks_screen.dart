import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Map<String, dynamic>> _tasks = [
    {"title": "Morning meditation", "isDone": true},
    {"title": "Finish Flutter project", "isDone": false},
    {"title": "Drink 2L of water", "isDone": true},
    {"title": "Read 10 pages", "isDone": false},
    {"title": "Evening walk", "isDone": false},
  ];

  final _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add({"title": _taskController.text, "isDone": false});
        _taskController.clear();
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]["isDone"] = !_tasks[index]["isDone"];
    });
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _tasks.where((t) => t["isDone"]).length;
    double progress = _tasks.isEmpty ? 0 : completedCount / _tasks.length;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Tasks', style: TextStyle(color: isDark ? Colors.pink[200] : Color(0xFFAD1457))),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daily Progress",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 10),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: isDark ? Color(0xFF333333) : Color(0xFFFCE4EC),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF8BBD0)),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
                SizedBox(height: 5),
                Text(
                  "$completedCount of ${_tasks.length} tasks completed",
                  style: TextStyle(fontSize: 14, color: Color(0xFFAD1457)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task...',
                      filled: true,
                      fillColor: isDark ? Color(0xFF333333) : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: _addTask,
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8BBD0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(25),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isDark ? Color(0xFF333333) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
                  ),
                  child: ListTile(
                    onTap: () => _toggleTask(index),
                    leading: Icon(
                      task["isDone"] ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: task["isDone"] ? Color(0xFFF8BBD0) : Colors.grey[300],
                    ),
                    title: Text(
                      task["title"],
                      style: TextStyle(
                        fontSize: 16,
                        color: task["isDone"] ? Colors.grey : (isDark ? Colors.white : Color(0xFF4A148C)),
                        decoration: task["isDone"] ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

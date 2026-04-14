import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Map<String, String>> _notes = [
    {"title": "Project Idea", "content": "Build a soft aesthetic organizer app.", "category": "Ideas"},
    {"title": "Grocery List", "content": "Strawberries, cream, oats, almond milk.", "category": "Personal"},
    {"title": "Meeting Notes", "content": "Discussed the new UI design with the team.", "category": "Work"},
  ];

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = "Ideas";

  void _addNote() {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      setState(() {
        _notes.add({
          "title": _titleController.text,
          "content": _contentController.text,
          "category": _selectedCategory,
        });
        _titleController.clear();
        _contentController.clear();
      });
      Navigator.pop(context);
    }
  }

  void _showAddNoteSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: EdgeInsets.fromLTRB(25, 25, 25, MediaQuery.of(context).viewInsets.bottom + 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("New Note", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFAD1457))),
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: "Title", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _contentController,
              maxLines: 4,
              decoration: InputDecoration(hintText: "Content", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
              items: ["Ideas", "Personal", "Work", "Study"].map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _addNote,
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF8BBD0), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                child: Text("Save Note"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes', style: TextStyle(color: isDark ? Colors.pink[200] : Color(0xFFAD1457))),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(25),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? Color(0xFF333333) : Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(note["title"]!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Color(0xFF4A148C))),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Color(0xFFFCE4EC), borderRadius: BorderRadius.circular(10)),
                      child: Text(note["category"]!, style: TextStyle(fontSize: 12, color: Color(0xFFAD1457))),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(note["content"]!, style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[700], height: 1.5)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteSheet,
        backgroundColor: Color(0xFFF8BBD0),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

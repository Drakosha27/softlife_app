import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF1F2), Color(0xFFFCE4EC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pinkie Pie',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
                color: Color(0xFFAD1457),
                fontFamily: 'Serif',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your elegant life organizer',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF880E4F),
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFFAD1457),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 2,
              ),
              child: Text('Get Started', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

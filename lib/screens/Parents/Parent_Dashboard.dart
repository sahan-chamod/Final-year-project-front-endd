import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../LoginScreen.dart';
import 'ChildProgressScreen.dart';
import 'ParentHomeScreen.dart';
import 'AttendanceScreen.dart';
import '../Parents/models/attendance_record_model.dart';
import 'parents_meeting_page.dart';

class ParentDashboard extends StatefulWidget {
  @override
  _ParentDashboardState createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  // By default, open ParentHomeScreen
  Widget _currentScreen = ParentHomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _currentScreen = ParentHomeScreen();
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.bar_chart),
              title: Text('Child Progress'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                setState(() {
                  _currentScreen = ChildProgressScreen(
                    studentName: "John Doe", // Pass student name
                    subjects: [
                      {'name': 'Math', 'grade': 'A'},
                      {'name': 'Science', 'grade': 'B+'},
                      {'name': 'English', 'grade': 'A-'},
                    ], // Pass subjects
                  );
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Attendance'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                List<AttendanceRecord> attendanceData = [
                  AttendanceRecord(date: '2024-08-01', status: 'Present'),
                  AttendanceRecord(date: '2024-08-02', status: 'Absent'),
                  AttendanceRecord(date: '2024-08-03', status: 'Present'),
                  AttendanceRecord(date: '2024-08-04', status: 'Present'),
                  AttendanceRecord(date: '2024-08-05', status: 'Present'),
                ];

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceScreen(
                      attendanceRecords: attendanceData,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Parents Meetings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParentsMeetingPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await _logout();
              },
            ),
          ],
        ),
      ),
      body: _currentScreen, // Display the current screen
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print('Logout failed: $e');
      // Optionally display a message to the user
    }
  }
}

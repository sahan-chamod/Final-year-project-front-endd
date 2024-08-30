import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dylexsia/screens/Teacher/HomeScreen.dart';
import 'package:dylexsia/screens/Teacher/StudentsScreen.dart';
import 'package:dylexsia/screens/Teacher/ReportGenerationScreen.dart';
import 'CreateMeeting.dart';
import 'add_assignment_page.dart';
import '../LoginScreen.dart';

class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Index 0
    StudentsScreen(), // Index 1
    ReportGenerationScreen(), // Index 2
    CreateMeetingPage(), // Index 3
    AssignmentUploadPage(), // Index 4
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      // Handle sign out error
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Dashboard'),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
        shadowColor: Colors.black45,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.greenAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Teacher',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'Home', 0),
            _buildDrawerItem(Icons.person, 'Students', 1),
            _buildDrawerItem(Icons.assessment, 'Reports', 2),
            _buildDrawerItem(Icons.meeting_room, 'Create Meeting', 3),
            _buildDrawerItem(Icons.assignment, 'Assignment', 4),
            Divider(),
            _buildDrawerItem(Icons.logout, 'Logout', -1, onTap: _logout),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index,
      {Function? onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blueAccent : Colors.black54,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.blueAccent : Colors.black,
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          _onItemTapped(index);
          Navigator.pop(context); // Close the drawer
        }
      },
    );
  }
}

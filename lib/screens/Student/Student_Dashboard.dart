import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'courses_screen.dart';
import 'progress_screen.dart';
import 'profile_screen.dart';
import 'student_home_screen.dart';
import 'AssignmentUploadPage.dart';
import '../LoginScreen.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;

  // List of screens for the IndexedStack
  final List<Widget> _screens = [
    StudentHomeScreen(),
    CoursesScreen(),
    // ProgressScreen(),
    ProfileScreen(),
    AssignmentUploadPage(),
  ];

  void _onDrawerItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print("Error signing out: $e");
      // Optionally, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
        backgroundColor: Colors.teal,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade200, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade100, Colors.teal.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.teal.shade100,
                      child: Icon(
                        Icons.account_circle,
                        size: 60,
                        color: Colors.teal.shade800,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.teal.shade800,
                ),
              ),
              _buildDrawerItem(
                icon: Icons.home,
                text: 'Home',
                index: 0,
              ),
              _buildDrawerItem(
                icon: Icons.school,
                text: 'My Courses',
                index: 1,
              ),
              _buildDrawerItem(
                icon: Icons.bar_chart,
                text: 'Progress',
                index: 2,
              ),
              _buildDrawerItem(
                icon: Icons.account_circle,
                text: 'Profile',
                index: 3,
              ),
              _buildDrawerItem(
                icon: Icons.upload,
                text:
                    'Upload Assignment', // New drawer item for assignment upload
                index: 4,
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.teal.shade900,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, color: Colors.teal.shade900),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  _logout(); // Call the logout function
                },
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required int index,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.teal.shade900,
      ),
      title: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.teal.shade900),
      ),
      onTap: () {
        _onDrawerItemTapped(index);
      },
    );
  }
}

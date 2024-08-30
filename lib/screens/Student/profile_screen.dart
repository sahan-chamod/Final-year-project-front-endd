import 'package:flutter/material.dart';
import 'ChangeProfileInfoScreen.dart';
import 'SecuritySettingsScreen.dart';
import 'NotificationScreen.dart';
import 'LanguageSettingsScreen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
      body: Column(
        children: [
          _buildProfileHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: [
                _buildProfileOption(
                  icon: Icons.person,
                  text: 'Profile Info',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeProfileInfoScreen(),
                      ),
                    );
                  },
                ),
                _buildProfileOption(
                  icon: Icons.security,
                  text: 'Security Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecuritySettingsScreen(),
                      ),
                    );
                  },
                ),
                _buildProfileOption(
                  icon: Icons.notifications,
                  text: 'Notifications',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
                    );
                  },
                ),
                _buildProfileOption(
                  icon: Icons.language,
                  text: 'Language',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageSettingsScreen(),
                      ),
                    );
                  },
                ),
                _buildProfileOption(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {
                    // Implement logout functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.teal.shade100,
      child: Column(
        children: [
          // Profile Avatar with gradient border and shadow
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.teal.shade500, Colors.teal.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding:
                EdgeInsets.all(4), // Padding for the gradient border effect
            child: CircleAvatar(
              radius: 50,
              backgroundColor:
                  Colors.teal.shade100, // Background color for the icon
              child: Icon(
                Icons.account_circle,
                size: 80, // Icon size
                color: Colors.teal.shade800, // Icon color
              ),
            ),
          ),
          SizedBox(height: 16),
          // Student Name with enhanced style
          Text(
            'john doe',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.teal.shade200,
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          // Student Email with a softer color tone
          Text(
            'student@example.com',
            style: TextStyle(
              fontSize: 18,
              color: Colors.teal.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.teal.shade600,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.teal.shade800,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'assignment_data.dart';
import 'Achievement.dart';
import 'StudentInfo.dart';

class StudentHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Home'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome, Student!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 20),
              Text(
                'Here you can find your daily progress, upcoming assignments, and more.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    _buildCard(
                      context,
                      Icons.calendar_today,
                      'Upcoming Assignments',
                      Colors.orangeAccent,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpcomingAssignmentsPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    _buildCard(
                      context,
                      Icons.star,
                      'Achievements',
                      Colors.yellowAccent,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AchievementPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    _buildCard(
                      context,
                      Icons.info,
                      'Student Info',
                      Colors.blueAccent,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentInfoPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title,
      Color color, VoidCallback onTap) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        onTap: onTap,
      ),
    );
  }
}

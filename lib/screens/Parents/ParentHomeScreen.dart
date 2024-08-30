import 'package:flutter/material.dart';

class ParentHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Home'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Welcome Section
              Text(
                'Welcome, Parent!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Here’s an overview of your child’s progress and recent updates:',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),

              // Progress Overview Section
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Child’s Progress',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Icon(Icons.bar_chart, color: Colors.green, size: 40),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Overall Performance: A-',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'Average Score: 92%',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Recent Notifications Section
              Text(
                'Recent Notifications',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.blue),
                    title: Text('Assignment due in 2 days'),
                    subtitle: Text('Math - Geometry Homework'),
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications, color: Colors.blue),
                    title: Text('Parent-Teacher Conference'),
                    subtitle: Text('Scheduled for next Friday'),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Quick Actions Section
              Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  QuickActionCard(
                    icon: Icons.person,
                    label: 'Profile',
                    onTap: () {
                      // Navigate to Profile screen
                    },
                  ),
                  QuickActionCard(
                    icon: Icons.bar_chart,
                    label: 'Progress',
                    onTap: () {
                      // Navigate to Progress screen
                    },
                  ),
                  QuickActionCard(
                    icon: Icons.calendar_today,
                    label: 'Attendance',
                    onTap: () {
                      // Navigate to Attendance screen
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Quick Action Card Widget
class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  QuickActionCard(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 30, color: Colors.blueAccent),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

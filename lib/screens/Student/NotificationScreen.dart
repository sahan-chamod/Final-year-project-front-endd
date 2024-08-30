import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  // Sample list of notifications
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "New Message from John",
      "description": "Hey, are you available for a meeting tomorrow?",
      "time": "2 mins ago",
      "icon": Icons.message,
    },
    {
      "title": "App Update Available",
      "description":
          "A new update is available for the app. Please update to the latest version.",
      "time": "1 hour ago",
      "icon": Icons.system_update,
    },
    {
      "title": "Password Change Successful",
      "description": "Your password was changed successfully.",
      "time": "2 days ago",
      "icon": Icons.security,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.teal,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade400, Colors.teal.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(notification['icon'],
                          size: 30, color: Colors.teal.shade400),
                    ),
                    title: Text(
                      notification['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(notification['description']),
                        SizedBox(height: 6),
                        Text(
                          notification['time'],
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 18, color: Colors.grey.shade600),
                    onTap: () {
                      // Handle tap action if needed
                    },
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "No notifications available.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
    );
  }
}

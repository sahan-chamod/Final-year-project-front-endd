import 'package:flutter/material.dart';

class UpcomingAssignmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Assignments'),
        backgroundColor: Colors.teal.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildAssignmentCard(
              context,
              subject: 'Math',
              title: 'Algebra Homework',
              dueDate: '2024-08-20',
              description: 'Complete exercises 1 through 10 on page 45.',
            ),
            _buildAssignmentCard(
              context,
              subject: 'Science',
              title: 'Lab Report',
              dueDate: '2024-08-22',
              description: 'Submit the lab report on the recent experiment.',
            ),
            _buildAssignmentCard(
              context,
              subject: 'History',
              title: 'Essay on Ancient Civilizations',
              dueDate: '2024-08-25',
              description: 'Write a 2-page essay on ancient civilizations.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentCard(
    BuildContext context, {
    required String subject,
    required String title,
    required String dueDate,
    required String description,
  }) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.teal.shade100,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.teal.shade300,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subject: $subject',
              style: TextStyle(color: Colors.teal.shade300),
            ),
            Text(
              'Due Date: $dueDate',
              style: TextStyle(color: Colors.redAccent),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          // Handle tap event if needed
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class StudentInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Info'),
        backgroundColor: Colors.teal.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPersonalInfoSection(),
            SizedBox(height: 20),
            _buildEnrolledCoursesSection(),
            SizedBox(height: 20),
            _buildBestMarksSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.teal.shade300,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.teal.shade300,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Student ID: 123456',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.teal.shade700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Email: john.doe@example.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.teal.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnrolledCoursesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enrolled Courses',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.teal.shade300,
            ),
          ),
          SizedBox(height: 10),
          _buildCourseItem(
            courseName: 'Mathematics',
            grade: 'A',
          ),
          _buildCourseItem(
            courseName: 'Physics',
            grade: 'B+',
          ),
          _buildCourseItem(
            courseName: 'Computer Science',
            grade: 'A-',
          ),
        ],
      ),
    );
  }

  Widget _buildCourseItem({
    required String courseName,
    required String grade,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.teal.shade50,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          courseName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        trailing: Text(
          grade,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildBestMarksSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade100,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Best Marks',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.teal.shade300,
            ),
          ),
          SizedBox(height: 10),
          _buildMarkItem(
            subject: 'Mathematics',
            score: '95',
          ),
          _buildMarkItem(
            subject: 'Physics',
            score: '92',
          ),
          _buildMarkItem(
            subject: 'Computer Science',
            score: '98',
          ),
        ],
      ),
    );
  }

  Widget _buildMarkItem({
    required String subject,
    required String score,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.teal.shade50,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          subject,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        trailing: Text(
          score,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade300,
          ),
        ),
      ),
    );
  }
}

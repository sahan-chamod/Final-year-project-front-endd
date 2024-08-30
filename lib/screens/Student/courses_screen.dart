import 'package:flutter/material.dart';

class CoursesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch the list of enrolled courses
    final List<Course> courses = getEnrolledCourses();

    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return Card(
              elevation: 5.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.teal.shade100,
                  child: Icon(
                    Icons.book,
                    size: 36,
                    color: Colors.teal.shade700,
                  ),
                ),
                title: Text(
                  course.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  course.description,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                trailing: Chip(
                  label: Text(
                    course.enrollmentStatus,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: course.enrollmentStatus == 'Enrolled'
                      ? Colors.green
                      : Colors.orange,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Define the Course class
class Course {
  final String title;
  final String description;
  final String enrollmentStatus;

  Course({
    required this.title,
    required this.description,
    required this.enrollmentStatus,
  });
}

// Sample function to get courses with statuses
List<Course> getEnrolledCourses() {
  return [
    Course(
      title: 'Mathematics',
      description: 'Basic Math concepts and principles.',
      enrollmentStatus: 'Enrolled',
    ),
    Course(
      title: 'Science',
      description: 'Physics and Chemistry fundamentals.',
      enrollmentStatus: 'Pending',
    ),
    Course(
      title: 'History',
      description: 'Ancient and Modern History.',
      enrollmentStatus: 'Enrolled',
    ),
    Course(
      title: 'Literature',
      description: 'Classic and Modern Literature.',
      enrollmentStatus: 'Pending',
    ),
    Course(
      title: 'Computer Science',
      description: 'Introduction to Programming and Data Structures.',
      enrollmentStatus: 'Enrolled',
    ),
    Course(
      title: 'Biology',
      description: 'Cell Biology and Genetics.',
      enrollmentStatus: 'Pending',
    ),
    Course(
      title: 'Chemistry',
      description: 'Organic and Inorganic Chemistry.',
      enrollmentStatus: 'Enrolled',
    ),
    Course(
      title: 'Art',
      description: 'History of Art and Techniques.',
      enrollmentStatus: 'Pending',
    ),
    Course(
      title: 'Physical Education',
      description: 'Fitness and Sports Activities.',
      enrollmentStatus: 'Enrolled',
    ),
    Course(
      title: 'Economics',
      description: 'Principles of Micro and Macro Economics.',
      enrollmentStatus: 'Pending',
    ),
  ];
}

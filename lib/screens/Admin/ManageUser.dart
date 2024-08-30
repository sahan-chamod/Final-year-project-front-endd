import 'package:flutter/material.dart';
import './model/student_model.dart';
import './model/user_model.dart';

class ManageUsersPage extends StatefulWidget {
  @override
  _ManageUsersPageState createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  List<Student> students = [
    Student(name: 'John Doe', email: 'john.doe@example.com'),
    Student(name: 'Jane Smith', email: 'jane.smith@example.com'),
  ];

  void _addStudent(Student student) {
    setState(() {
      students.add(student);
    });
  }

  void _editStudent(int index, Student student) {
    setState(() {
      students[index] = student;
    });
  }

  void _deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Students'),
        backgroundColor: Colors.teal.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: UserList(
          students: students,
          onEdit: _editStudent,
          onDelete: _deleteStudent,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showStudentDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal.shade300,
        tooltip: 'Add Student',
      ),
    );
  }

  void _showStudentDialog({Student? student, int? index}) {
    final nameController = TextEditingController(text: student?.name);
    final emailController = TextEditingController(text: student?.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(student == null ? 'Add Student' : 'Edit Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final name = nameController.text;
                final email = emailController.text;
                if (name.isNotEmpty && email.isNotEmpty) {
                  final newStudent = Student(name: name, email: email);
                  if (student == null) {
                    _addStudent(newStudent);
                  } else {
                    _editStudent(index!, newStudent);
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import './student_model.dart';

class UserList extends StatelessWidget {
  final List<Student> students;
  final Function(int, Student) onEdit;
  final Function(int) onDelete;

  UserList({
    required this.students,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4,
          child: ListTile(
            contentPadding: EdgeInsets.all(16.0),
            leading: CircleAvatar(
              child: Icon(Icons.person),
              backgroundColor: Colors.teal.shade300,
              foregroundColor: Colors.white,
            ),
            title: Text(
              student.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              student.email,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            onTap: () {
              _showEditDialog(context, student, index);
            },
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                onDelete(index);
              },
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, Student student, int index) {
    final nameController = TextEditingController(text: student.name);
    final emailController = TextEditingController(text: student.email);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Student'),
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
                  final updatedStudent = Student(name: name, email: email);
                  onEdit(index, updatedStudent);
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

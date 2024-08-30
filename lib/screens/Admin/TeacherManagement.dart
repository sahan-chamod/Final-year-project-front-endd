// import 'package:flutter/material.dart';
// import './model/teacher_model.dart';
// //import '../Admin/model/teacher_model.dart'; // Ensure the path matches where you place teacher_list.dart

// class TeacherManagementPage extends StatefulWidget {
//   @override
//   _TeacherManagementPageState createState() => _TeacherManagementPageState();
// }

// class _TeacherManagementPageState extends State<TeacherManagementPage> {
//   List<Teacher> teachers = [
//     Teacher(name: 'Mr. John Doe', email: 'john.doe@school.com'),
//     Teacher(name: 'Ms. Jane Smith', email: 'jane.smith@school.com'),
//   ];

//   void _addTeacher(Teacher teacher) {
//     setState(() {
//       teachers.add(teacher);
//     });
//   }

//   void _editTeacher(int index, Teacher teacher) {
//     setState(() {
//       teachers[index] = teacher;
//     });
//   }

//   void _deleteTeacher(int index) {
//     setState(() {
//       teachers.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Manage Teachers'),
//         backgroundColor: Colors.teal.shade300,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TeacherList(
//           teachers: teachers,
//           onEdit: _editTeacher,
//           onDelete: _deleteTeacher,
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showTeacherDialog();
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.teal.shade300,
//         tooltip: 'Add Teacher',
//       ),
//     );
//   }

//   void _showTeacherDialog({Teacher? teacher, int? index}) {
//     final nameController = TextEditingController(text: teacher?.name);
//     final emailController = TextEditingController(text: teacher?.email);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(teacher == null ? 'Add Teacher' : 'Edit Teacher'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 8),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 final name = nameController.text;
//                 final email = emailController.text;
//                 if (name.isNotEmpty && email.isNotEmpty) {
//                   final newTeacher = Teacher(name: name, email: email);
//                   if (teacher == null) {
//                     _addTeacher(newTeacher);
//                   } else {
//                     _editTeacher(index!, newTeacher);
//                   }
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: Text('Save'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './model/teacher_model.dart';

class TeacherManagementPage extends StatefulWidget {
  @override
  _TeacherManagementPageState createState() => _TeacherManagementPageState();
}

class _TeacherManagementPageState extends State<TeacherManagementPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference teachersCollection;

  @override
  void initState() {
    super.initState();
    teachersCollection = _firestore.collection('Teachers');
  }

  // Add a new teacher to Firestore
  Future<void> _addTeacher(Teacher teacher, String tempPassword) async {
    await teachersCollection.add({
      'username': teacher.username,
      'email': teacher.email,
      'password': tempPassword,
    });
  }

  // Edit an existing teacher in Firestore
  Future<void> _editTeacher(
      String docId, Teacher teacher, String tempPassword) async {
    await teachersCollection.doc(docId).update({
      'username': teacher.username,
      'email': teacher.email,
      'password': tempPassword,
    });
  }

  // Delete a teacher from Firestore
  Future<void> _deleteTeacher(String docId) async {
    await teachersCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Teachers'),
        backgroundColor: Colors.teal.shade300,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: teachersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available'));
          }

          final List<DocumentSnapshot> docs = snapshot.data!.docs;
          final List<Teacher> teachers = docs.map((doc) {
            return Teacher.fromFirestore(doc);
          }).toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TeacherList(
              teachers: teachers,
              onEdit: (index, teacher) =>
                  _showTeacherDialog(teacher: teacher, docId: teacher.id!),
              onDelete: (index) => _deleteTeacher(teachers[index].id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTeacherDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal.shade300,
        tooltip: 'Add Teacher',
      ),
    );
  }

  void _showTeacherDialog({Teacher? teacher, String? docId}) {
    final usernameController = TextEditingController(text: teacher?.username);
    final emailController = TextEditingController(text: teacher?.email);
    final tempPasswordController =
        TextEditingController(); // For the temporary password

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(teacher == null ? 'Add Teacher' : 'Edit Teacher'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
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
              SizedBox(height: 8),
              TextField(
                controller: tempPasswordController,
                decoration: InputDecoration(
                  labelText: 'Temporary Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final username = usernameController.text;
                final email = emailController.text;
                final tempPassword = tempPasswordController.text;
                if (username.isNotEmpty &&
                    email.isNotEmpty &&
                    tempPassword.isNotEmpty) {
                  final newTeacher = Teacher(username: username, email: email);
                  if (teacher == null) {
                    _addTeacher(newTeacher, tempPassword);
                  } else {
                    _editTeacher(docId!, newTeacher, tempPassword);
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

// This is your TeacherList widget
class TeacherList extends StatelessWidget {
  final List<Teacher> teachers;
  final Function(int, Teacher) onEdit;
  final Function(int) onDelete;

  TeacherList({
    required this.teachers,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        final teacher = teachers[index];
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
              teacher.username, // Changed from 'name' to 'username'
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              teacher.email,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            onTap: () {
              // Trigger the edit dialog
              onEdit(index, teacher);
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
}

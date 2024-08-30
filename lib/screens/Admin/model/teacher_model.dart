// import 'package:flutter/material.dart';

// class Teacher {
//   final String name;
//   final String email;

//   Teacher({required this.name, required this.email});
// }

// class TeacherList extends StatelessWidget {
//   final List<Teacher> teachers;
//   final Function(int, Teacher) onEdit;
//   final Function(int) onDelete;

//   TeacherList({
//     required this.teachers,
//     required this.onEdit,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: teachers.length,
//       itemBuilder: (context, index) {
//         final teacher = teachers[index];
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 8.0),
//           elevation: 4,
//           child: ListTile(
//             contentPadding: EdgeInsets.all(16.0),
//             leading: CircleAvatar(
//               child: Icon(Icons.person),
//               backgroundColor: Colors.teal.shade300,
//               foregroundColor: Colors.white,
//             ),
//             title: Text(
//               teacher.name,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             subtitle: Text(
//               teacher.email,
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//               ),
//             ),
//             onTap: () {
//               _showEditDialog(context, teacher, index);
//             },
//             trailing: IconButton(
//               icon: Icon(Icons.delete),
//               color: Colors.red,
//               onPressed: () {
//                 onDelete(index);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _showEditDialog(BuildContext context, Teacher teacher, int index) {
//     final nameController = TextEditingController(text: teacher.name);
//     final emailController = TextEditingController(text: teacher.email);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit Teacher'),
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
//                   final updatedTeacher = Teacher(name: name, email: email);
//                   onEdit(index, updatedTeacher);
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

class Teacher {
  String? id; // Firestore document ID
  String username; // Changed from 'name' to 'username'
  String email;

  Teacher({this.id, required this.username, required this.email});

  // From Firestore to Teacher model
  factory Teacher.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Teacher(
      id: doc.id,
      username: data['username'] ?? '', // Changed from 'name' to 'username'
      email: data['email'] ?? '',
    );
  }

  // To map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'username': username, // Changed from 'name' to 'username'
      'email': email,
    };
  }
}

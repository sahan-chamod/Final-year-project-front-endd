// import 'package:flutter/material.dart';

// class SettingsDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('Profile Settings',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             SizedBox(height: 20),
//             ListTile(
//               leading: Icon(Icons.account_circle),
//               title: Text('Edit Profile'),
//               onTap: () {
//                 // Navigate to Edit Profile screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => EditProfileScreen(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.notifications),
//               title: Text('Notification Settings'),
//               onTap: () {
//                 // Navigate to Notification Settings screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => NotificationSettingsScreen(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.lock),
//               title: Text('Change Password'),
//               onTap: () {
//                 // Navigate to Change Password screen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ChangePasswordScreen(),
//                   ),
//                 );
//               },
//             ),
//             // Add more settings options as needed
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Example of EditProfileScreen widget
// class EditProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//       ),
//       body: Center(
//         child: Text('Edit Profile Screen Content'),
//       ),
//     );
//   }
// }

// // Example of NotificationSettingsScreen widget
// class NotificationSettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Notification Settings'),
//       ),
//       body: Center(
//         child: Text('Notification Settings Screen Content'),
//       ),
//     );
//   }
// }

// // Example of ChangePasswordScreen widget
// class ChangePasswordScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Change Password'),
//       ),
//       body: Center(
//         child: Text('Change Password Screen Content'),
//       ),
//     );
//   }
// }

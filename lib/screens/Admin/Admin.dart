// import 'package:flutter/material.dart';
// import 'AdminHome.dart';
// import 'ManageUser.dart';
// import 'TeacherManagement.dart';

// class AdminDashboard extends StatefulWidget {
//   @override
//   _AdminDashboardState createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends State<AdminDashboard> {
//   int _selectedIndex = 0;

//   final List<Widget> _widgetOptions = <Widget>[
//     AdminHomePage(), // Index 0
//     ManageUsersPage(), // Index 1
//     TeacherManagementPage(), // Index 2
//     // PaymentPage(), // Index 3
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blueAccent, Colors.greenAccent],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: AppBar(
//             title: Text('Admin Dashboard'),
//             elevation: 5,
//             shadowColor: Colors.black45,
//             backgroundColor:
//                 Colors.transparent, // Set to transparent to show gradient
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.blueAccent, Colors.greenAccent],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     Icons.account_circle,
//                     size: 60,
//                     color: Colors.white,
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     'Admin Name',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     'Administrator',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             _buildDrawerItem(Icons.home, 'Home', 0),
//             _buildDrawerItem(Icons.group, 'Manage Users', 1),
//             _buildDrawerItem(Icons.person_add, 'Manage Teachers', 2),
//             _buildDrawerItem(Icons.payment, 'Payments', 3),
//             Divider(),
//             _buildDrawerItem(Icons.logout, 'Logout', -1, onTap: () {
//               Navigator.pop(context); // Close the drawer
//             }),
//           ],
//         ),
//       ),
//       body: AnimatedSwitcher(
//         duration: Duration(milliseconds: 300),
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//     );
//   }

//   Widget _buildDrawerItem(IconData icon, String title, int index,
//       {Function? onTap}) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: _selectedIndex == index ? Colors.blueAccent : Colors.black54,
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: _selectedIndex == index ? Colors.blueAccent : Colors.black,
//         ),
//       ),
//       onTap: () {
//         if (onTap != null) {
//           onTap();
//         } else {
//           _onItemTapped(index);
//           Navigator.pop(context); // Close the drawer
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../LoginScreen.dart';
import 'AdminHome.dart';
import 'ManageUser.dart';
import 'TeacherManagement.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    AdminHomePage(), // Index 0
    ManageUsersPage(), // Index 1
    TeacherManagementPage(), // Index 2
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text('Admin Dashboard'),
            elevation: 5,
            shadowColor: Colors.black45,
            backgroundColor:
                Colors.transparent, // Set to transparent to show gradient
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.greenAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Admin Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Administrator',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'Home', 0),
            _buildDrawerItem(Icons.group, 'Manage Users', 1),
            _buildDrawerItem(Icons.person_add, 'Manage Teachers', 2),
            _buildDrawerItem(Icons.payment, 'Payments', 3),
            Divider(),
            _buildDrawerItem(Icons.logout, 'Logout', -1, onTap: () async {
              await _logout();
            }),
          ],
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index,
      {Function? onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: _selectedIndex == index ? Colors.blueAccent : Colors.black54,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: _selectedIndex == index ? Colors.blueAccent : Colors.black,
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          _onItemTapped(index);
          Navigator.pop(context); // Close the drawer
        }
      },
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print('Logout failed: $e');
      // Optionally, show a message to the user.
    }
  }
}

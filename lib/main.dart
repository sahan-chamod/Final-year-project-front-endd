// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// // scReens
// import 'package:dylexsia/screens/splash_screen.dart';
// //import 'package:dylexsia/screens/LoginScreen.dart'; // Ensure this path is correct

// //import 'package:dylexsia/screens/Teacher/Teacher_Dashboard.dart';
// //import 'package:dylexsia/screens/Student/Student_Dashboard.dart';
// //import 'package:dylexsia/screens/Parents/Parent_Dashboard.dart';
// // import 'package:dylexsia/screens/Admin/Admin.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   try {
//     await Firebase.initializeApp(
//       options: const FirebaseOptions(
//         apiKey: 'AIzaSyDcCAQh2ROscEJyqnGDn5WoDt85Y19HH60',
//         appId: '1:571907192480:android:cfc965f765249f418c7bc5',
//         messagingSenderId: '571907192480',
//         projectId: 'dylexsia-840e0',
//       ),
//     );
//     print("Firebase Initialized Successfully");
//   } catch (e) {
//     print("Firebase Initialization Error: $e");
//   }

//   runApp(MyApp());
// }

// // void main() {
// //   runApp(const MyApp());
// // }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         //home: const LoginScreen(), // Start with LoginScreen
//         //home: TeacherDashboard(),
//         //home: StudentDashboard(),
//         //home: ParentDashboard(),
//         //home: StudentaScreen(),
//         // home: AdminDashboard());
//         home: SplashScreen());
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// Screens
import 'package:dylexsia/screens/splash_screen.dart';
// Uncomment the correct import based on the initial screen you want to use
// import 'package:dylexsia/screens/LoginScreen.dart';
// import 'package:dylexsia/screens/Teacher/Teacher_Dashboard.dart';
// import 'package:dylexsia/screens/Student/Student_Dashboard.dart';
// import 'package:dylexsia/screens/Parents/Parent_Dashboard.dart';
// import 'package:dylexsia/screens/Admin/Admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDcCAQh2ROscEJyqnGDn5WoDt85Y19HH60',
        appId: '1:571907192480:android:cfc965f765249f418c7bc5',
        messagingSenderId: '571907192480',
        projectId: 'dylexsia-840e0',
      ),
    );
    print("Firebase Initialized Successfully");
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Uncomment and use the appropriate initial screen
      // home: const LoginScreen(),
      // home: TeacherDashboard(),
      // home: StudentDashboard(),
      // home: ParentDashboard(),
      // home: AdminDashboard(),
      home: SplashScreen(),
    );
  }
}

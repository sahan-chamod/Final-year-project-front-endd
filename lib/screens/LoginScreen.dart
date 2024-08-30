import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dylexsia/screens/Sign_upScreen.dart';
import 'package:dylexsia/screens/Teacher/Teacher_Dashboard.dart';
import 'package:dylexsia/screens/Student/Student_Dashboard.dart';
import 'package:dylexsia/screens/Parents/Parent_Dashboard.dart';
import 'package:dylexsia/screens/Admin/Admin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to handle login
  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }

    try {
      // Sign in using Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      // Fetch user ID
      String userId = userCredential.user!.uid;

      // Check if the user is in the Admin collection
      DocumentSnapshot adminDoc =
          await _firestore.collection('Admin').doc(userId).get();
      if (adminDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
        return;
      }

      // Check if the user is in the Student collection
      DocumentSnapshot studentDoc =
          await _firestore.collection('Student').doc(userId).get();
      if (studentDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentDashboard()),
        );
        return;
      }

      // Check if the user is in the Teacher collection
      DocumentSnapshot teacherDoc =
          await _firestore.collection('Teachers').doc(userId).get();
      if (teacherDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TeacherDashboard()),
        );
        return;
      }

      // Check if the user is in the Parent collection
      DocumentSnapshot parentDoc =
          await _firestore.collection('Parent').doc(userId).get();
      if (parentDoc.exists) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ParentDashboard()),
        );
        return;
      }

      // If the user is not found in any collection, show an error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User type not found')),
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        // Display error messages from Firebase
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: ${e.message}')),
        );
      } else {
        // Generic error handling
        print('Error logging in: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unknown error occurred')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image at the top
            Image.asset(
              'images/login.jpg',
              height: 150, // Adjust height as needed
              width: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(
                height: 24), // Space between the image and input fields
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person, color: Color(0xFF063175)),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                        borderSide: BorderSide(color: Color(0xFF063175)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                        borderSide: BorderSide(color: Color(0xFF063175)),
                      ),
                      labelStyle: TextStyle(color: Color(0xFF063175)),
                    ),
                    style: TextStyle(color: Color(0xFF063175)),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Color(0xFF063175)),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                        borderSide: BorderSide(color: Color(0xFF063175)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12.0), // Rounded corners
                        borderSide: BorderSide(color: Color(0xFF063175)),
                      ),
                      labelStyle: TextStyle(color: Color(0xFF063175)),
                    ),
                    style: TextStyle(color: Color(0xFF063175)),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color(0xFF063175), // Button background color
                      foregroundColor: Colors.white, // Button text color
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: const Text("Don't have an account? Sign Up"),
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF063175), // Text color
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

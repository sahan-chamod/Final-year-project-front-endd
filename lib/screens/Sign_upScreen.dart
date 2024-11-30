// import 'package:flutter/material.dart';
// import 'package:dylexsia/screens/LoginScreen.dart'; // Adjust the path according to your project structure

// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   // Function to handle sign-up
//   void _signUp() {
//     if (_formKey.currentState?.validate() ?? false) {
//       final username = _usernameController.text;
//       final email = _emailController.text;
//       final password = _passwordController.text;

//       // Implement your sign-up logic here
//       print('Username: $username');
//       print('Email: $email');
//       print('Password: $password');

//       // Optionally navigate to another screen after sign-up
//       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('Sign Up'),
//       //   backgroundColor: Color(0xFF063175),
//       // ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     TextFormField(
//                       controller: _usernameController,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         labelText: 'Username',
//                         prefixIcon:
//                             Icon(Icons.person, color: Color(0xFF063175)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: Color(0xFF063175)),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: Color(0xFF063175)),
//                         ),
//                         labelStyle: TextStyle(color: Color(0xFF063175)),
//                       ),
//                       style: TextStyle(color: Color(0xFF063175)),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your username';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         labelText: 'Email',
//                         prefixIcon: Icon(Icons.email, color: Color(0xFF063175)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: Color(0xFF063175)),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: Color(0xFF063175)),
//                         ),
//                         labelStyle: TextStyle(color: Color(0xFF063175)),
//                       ),
//                       style: TextStyle(color: Color(0xFF063175)),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
//                             .hasMatch(value)) {
//                           return 'Please enter a valid email address';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         labelText: 'Password',
//                         prefixIcon: Icon(Icons.lock, color: Color(0xFF063175)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: Color(0xFF063175)),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: Color(0xFF063175)),
//                         ),
//                         labelStyle: TextStyle(color: Color(0xFF063175)),
//                       ),
//                       style: TextStyle(color: Color(0xFF063175)),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         } else if (value.length < 6) {
//                           return 'Password must be at least 6 characters long';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _confirmPasswordController,
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         labelText: 'Confirm Password',
//                         prefixIcon: Icon(Icons.lock, color: Color(0xFF063175)),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: Color(0xFF063175)),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide(color: Color(0xFF063175)),
//                         ),
//                         labelStyle: TextStyle(color: Color(0xFF063175)),
//                       ),
//                       style: TextStyle(color: Color(0xFF063175)),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please confirm your password';
//                         } else if (value != _passwordController.text) {
//                           return 'Passwords do not match';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       onPressed: _signUp,
//                       child: const Text('Sign Up'),
//                       style: ElevatedButton.styleFrom(
//                         primary: Color(0xFF063175),
//                         onPrimary: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => LoginScreen()),
//                         );
//                       },
//                       child: const Text("Already have an account? Login"),
//                       style: TextButton.styleFrom(
//                         primary: Color(0xFF063175),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dylexsia/screens/LoginScreen.dart'; 

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to handle sign-up
  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      final username = _usernameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        // Create the user using Firebase Auth
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Add user data to Firestore in 'Student' collection
        await _firestore
            .collection('Student')
            .doc(userCredential.user?.uid)
            .set({
          'username': username,
          'email': email,
          'password': password,
          'created_at': Timestamp.now(),
        });
      } catch (e) {
        print('Error signing up: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up: $e')),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Username',
                        prefixIcon:
                            Icon(Icons.person, color: Color(0xFF063175)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFF063175)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFF063175)),
                        ),
                        labelStyle: TextStyle(color: Color(0xFF063175)),
                      ),
                      style: TextStyle(color: Color(0xFF063175)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email, color: Color(0xFF063175)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFF063175)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFF063175)),
                        ),
                        labelStyle: TextStyle(color: Color(0xFF063175)),
                      ),
                      style: TextStyle(color: Color(0xFF063175)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF063175)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFF063175)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFF063175)),
                        ),
                        labelStyle: TextStyle(color: Color(0xFF063175)),
                      ),
                      style: TextStyle(color: Color(0xFF063175)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock, color: Color(0xFF063175)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFF063175)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Color(0xFF063175)),
                        ),
                        labelStyle: TextStyle(color: Color(0xFF063175)),
                      ),
                      style: TextStyle(color: Color(0xFF063175)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _signUp,
                      child: const Text('Sign Up'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF063175),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text("Already have an account? Login"),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF063175),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import './model/teacher_model.dart';
// //import './model/payment_model.dart';

// class PaymentPage extends StatefulWidget {
//   @override
//   _PaymentPageState createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   List<Teacher> teachers = [
//     Teacher(name: 'Mr. John Doe', email: 'john.doe@school.com'),
//     Teacher(name: 'Ms. Jane Smith', email: 'jane.smith@school.com'),
//   ];

//   void _processPayment(Teacher teacher) {
//     // Implement payment processing logic here
//     // For demonstration purposes, we will just show a dialog

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Process Payment'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Teacher: ${teacher.name}'),
//               SizedBox(height: 8),
//               TextField(
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Amount',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 // Simulate payment processing
//                 Navigator.of(context).pop();
//                 _showPaymentConfirmation(teacher);
//               },
//               child: Text('Pay'),
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

//   void _showPaymentConfirmation(Teacher teacher) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Payment Successful'),
//           content: Text('Payment has been processed for ${teacher.name}.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Payment to Teachers'),
//         backgroundColor: Colors.teal.shade300,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: teachers.length,
//           itemBuilder: (context, index) {
//             final teacher = teachers[index];
//             return Card(
//               margin: EdgeInsets.symmetric(vertical: 8.0),
//               elevation: 4,
//               child: ListTile(
//                 contentPadding: EdgeInsets.all(16.0),
//                 leading: CircleAvatar(
//                   child: Icon(Icons.person),
//                   backgroundColor: Colors.teal.shade300,
//                   foregroundColor: Colors.white,
//                 ),
//                 title: Text(
//                   teacher.name,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 subtitle: Text(
//                   teacher.email,
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 trailing: IconButton(
//                   icon: Icon(Icons.payment),
//                   color: Colors.green,
//                   onPressed: () {
//                     _processPayment(teacher);
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_stripe/flutter_stripe.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // class PaymentPage extends StatefulWidget {
// //   @override
// //   _PaymentPageState createState() => _PaymentPageState();
// // }

// // class _PaymentPageState extends State<PaymentPage> {
// //   Map<String, dynamic>? paymentIntentData;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Stripe Payment'),
// //         backgroundColor: Colors.teal.shade300,
// //       ),
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () async {
// //             await makePayment();
// //           },
// //           child: Text("Make Payment"),
// //           style: ElevatedButton.styleFrom(primary: Colors.teal.shade300),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> makePayment() async {
// //     try {
// //       paymentIntentData =
// //           await createPaymentIntent('5000', 'USD'); // Amount in cents

// //       if (paymentIntentData != null) {
// //         await Stripe.instance.initPaymentSheet(
// //           paymentSheetParameters: SetupPaymentSheetParameters(
// //             paymentIntentClientSecret: paymentIntentData!['client_secret'],
// //             style: ThemeMode.light,
// //             merchantDisplayName: 'Your Company Name',
// //           ),
// //         );
// //         await displayPaymentSheet();
// //       }
// //     } catch (e) {
// //       print('Error during payment initialization: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Error initializing payment: $e")),
// //       );
// //     }
// //   }

// //   Future<void> displayPaymentSheet() async {
// //     try {
// //       await Stripe.instance.presentPaymentSheet();
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Payment Successful")),
// //       );
// //       paymentIntentData = null; // Reset after payment
// //     } on StripeException catch (e) {
// //       print('Error during payment: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Payment Cancelled")),
// //       );
// //     } catch (e) {
// //       print('Error: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("An error occurred")),
// //       );
// //     }
// //   }

// //   Future<Map<String, dynamic>> createPaymentIntent(
// //       String amount, String currency) async {
// //     try {
// //       final body = {
// //         'amount': amount,
// //         'currency': currency,
// //         'payment_method_types[]': 'card',
// //       };

// //       final response = await http.post(
// //         Uri.parse('https://api.stripe.com/v1/payment_intents'),
// //         body: body,
// //         headers: {
// //           'Authorization':
// //               'Bearer sk_test_51Mk28oHPAAM16mwA6QxVnHrdkprJuqc8ngXIEu1yKcSaJx8kMXz3axokwOUY4Clb5n9bTdUZFY5JHy4rzPoYA7va00d268BZYw', // Replace with your actual secret key
// //           'Content-Type': 'application/x-www-form-urlencoded',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         return jsonDecode(response.body);
// //       } else {
// //         throw Exception('Failed to create payment intent: ${response.body}');
// //       }
// //     } catch (e) {
// //       throw Exception('Error creating payment intent: $e');
// //     }
// //   }
// // }

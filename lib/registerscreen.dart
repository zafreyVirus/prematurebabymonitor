// import 'package:flutter/material.dart';
//
// class RegisterScreen extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Confirm Password',
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your password';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 32.0),
//               Center(
//                 child: ElevatedButton(
//                 //   onPressed: () {
//                 //     if (_formKey.currentState?.validate() ?? false) {
//                 //       // If the form is valid, display a snackbar. In a real app, you'd often want
//                 //       // to call a server or save the information in a database.
//
//                 //       ScaffoldMessenger.of(context).showSnackBar(
//                 //         SnackBar(content: Text('Registering...')),
//                 //       );
//                 //     }
//                 //   },
//                 onTap: () async {
//   String message = '';
//   if (_form.currentState!.validate()) {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword( // instantiated earlier on: final _firebaseAuth = FirebaseAuth.instance;
//         email: email.trim(),
//         password: password.trim(),
//       );
//       Future.delayed(const Duration(seconds: 3), () {
//         Navigator.of(context, rootNavigator: true).push(
//           MaterialPageRoute(
//             builder: (_) => const Feed(),
//           ),
//         );
//       });
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         message = 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         message = 'An account already exists with that email.';
//       }
//       Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.SNACKBAR,
//         backgroundColor: Colors.black54,
//         textColor: Colors.white,
//         fontSize: 14.0,
//       );
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.SNACKBAR,
//         backgroundColor: Colors.black54,
//         textColor: Colors.white,
//         fontSize: 14.0,
//       );
//     }
//   }
// },
//                   child: Text('Register'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

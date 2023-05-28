// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';

// class FingerprintAuthScreen extends StatefulWidget {
//   @override
//   _FingerprintAuthScreenState createState() => _FingerprintAuthScreenState();
// }

// class _FingerprintAuthScreenState extends State<FingerprintAuthScreen> {
//   final LocalAuthentication _localAuthentication = LocalAuthentication();
//   bool _isAuthenticated = false;

//   Future<void> _authenticate() async {
//     bool isAuthenticated = false;

//     try {
//       isAuthenticated = await _localAuthentication.authenticate(
//           localizedReason: 'Please scan your fingerprint to authenticate',
//           biometricOnly: true,
//           stickyAuth: true);
//     } on PlatformException catch (e) {
//       print(e);
//     }

//     if (!mounted) return;

//     setState(() {
//       _isAuthenticated = isAuthenticated;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Fingerprint Authentication',
//               style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 32.0),
//             RaisedButton(
//               onPressed: _authenticate,
//               child: Text('Authenticate'),
//             ),
//             SizedBox(height: 16.0),
//             _isAuthenticated
//                 ? Text(
//                     'Authenticated',
//                     style: TextStyle(fontSize: 18.0, color: Colors.green),
//                   )
//                 : Text(
//                     'Not Authenticated',
//                     style: TextStyle(fontSize: 18.0, color: Colors.red),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:project1/Screens/FolderScreen/imagepage.dart';
// import 'package:project1/Screens/FolderScreen/imageuploadsubcol.dart';
// import 'package:project1/Screens/FolderScreen/second_screen_foldershow.dart';

// class HomePage extends StatelessWidget {
//         final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   final TextEditingController _controller = TextEditingController();
//   final ImagePicker _picker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 labelText: 'Sub-collection name',
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 final subCollectionName = _controller.text.trim();
//                 if (subCollectionName.isNotEmpty) {
//                   await createSubCollection(subCollectionName);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => SubCollectionPage(subCollectionName),
//               ));
//             }
//           },
//           child: Text('Create sub-collection'),
//         ),
        
//       ],
//     ),
//   ),
// );
// }
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Future<void> createSubCollection(String subCollectionName) async {
//   final user = _firebaseAuth.currentUser!;
//   final subCollection = _firestore.collection('users').doc(user.uid).collection(subCollectionName);
//   await subCollection.add({'name': subCollectionName});
// }

// }
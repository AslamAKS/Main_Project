// import 'dart:io';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:project1/Screens/FolderScreen/imagepage.dart';
// import 'package:project1/Screens/FolderScreen/imageuploadsubcol.dart';

// class SubCollectionPage extends StatelessWidget {
//   final String subCollectionName;
//     final ImagePicker _picker = ImagePicker();

//       final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   SubCollectionPage(this.subCollectionName);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(subCollectionName),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('users').doc(_firebaseAuth.currentUser!.uid).collection(subCollectionName).snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }
//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }
//           final docs = snapshot.data!.docs;
//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               final data = docs[index].data();
//               final name = data!['name'];
//               return ListTile(
//                 title: Text(name),
//               );
//             },
//           );
//         },
//         SizedBox(height: 16),
//         ElevatedButton(
//           onPressed: () async {
//             final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//             if (pickedFile != null) {
//               final imageFile = File(pickedFile.path);
//               final imageUrl = await uploadImage(subCollectionName, imageFile);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ImagePage(imageUrl),
//                 ),
//               );
//             }
//           },
//           child: Text('Upload image'),
//         ),
//       ),
//     );
//   }
// }

  



// // import 'dart:io';
// // import 'dart:js';

// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:provider/provider.dart';

// // import '../../Authentications/provider/authentication_provider.dart';

// // final FirebaseStorage _storage = FirebaseStorage.instance;
// //       final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



// // Future<String> uploadImage(String subCollectionName, File imageFile) async {
// //   final user = _firebaseAuth.currentUser!;
// //   final imagePath = '${user.uid}/$subCollectionName/${DateTime.now().millisecondsSinceEpoch}.jpg';
// //   final ref = _storage.ref().child(imagePath);
// //   final metadata = SettableMetadata(contentType: 'image/jpeg');
// //   final uploadTask = ref.putFile(imageFile, metadata);
// //   final snapshot = await uploadTask;
// //   final downloadUrl = await snapshot.ref.getDownloadURL();
// //   return downloadUrl;
// // }






////





// class CollectionPage extends StatefulWidget {
//   final String collectionName;

//   const CollectionPage({super.key, required this.collectionName});

//   @override
//   CollectionPageState createState() => CollectionPageState();
// }

// class CollectionPageState extends State<CollectionPage> {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//   final picker = ImagePicker();
  

//   List<String> _imagesList = [];

//   @override
//   void initState() {
//     super.initState();
//     _getFilesList(context, collectionName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             title: Text(widget.collectionName),
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.blue,
//                     Colors.green,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//             floating: true,
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.all(16.0),
//             sliver: SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10.0,
//                 mainAxisSpacing: 10.0,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final imageUrl = _imagesList[index];
//                   return GestureDetector(
//                     onTap: () {
//                       // Handle image tap event here
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         image: DecorationImage(
//                           image: NetworkImage(imageUrl),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: _imagesList.length,
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => uploadFiles(collectionName),
//         backgroundColor: Colors.white,
//         child: const Icon(Icons.folder, color: Colors.green),
//       ),
//     );
//   }




// //upload files
//   Future<void> uploadFiles(String collectionName) async {
//   final String uid = _auth.currentUser!.uid;
//   final String collectionPath =
//       'users/$uid/customCollections/$collectionName/files';

//   final FilePickerResult? result = await FilePicker.platform.pickFiles(
//     allowMultiple: true,
//   );

//   if (result != null) {
//     for (final file in result.files) {
//       final String fileName = file.name;
//       final firebase_storage.Reference storageRef =
//           firebase_storage.FirebaseStorage.instance.ref('$collectionPath/$fileName');

//       final firebase_storage.UploadTask uploadTask =
//           storageRef.putFile(File(file.path!));
//       final firebase_storage.TaskSnapshot taskSnapshot =
//           await uploadTask.whenComplete(() => null);

//       final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

//       // Save the file information to the collection in Firebase Firestore
//       await _firestore.collection(collectionPath).add({
//         'fileName': fileName,
//         'fileUrl': downloadUrl,
//         // Add any other relevant file information here
//       });
//     }
//   }
// }


// Widget _getFilesList(BuildContext context, String collectionName) {
//   final String uid = _auth.currentUser!.uid;
//   final String collectionPath =
//       'users/$uid/customCollections/$collectionName/files';

//   return StreamBuilder<QuerySnapshot>(
//     stream: _firestore.collection(collectionPath).snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       }

//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CircularProgressIndicator();
//       }

//       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//         return Text('No files found.');
//       }

//       return GridView.builder(
//         shrinkWrap: true,
//         gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Adjust the number of columns as needed
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0,
//         ),
//         itemCount: snapshot.data!.docs.length,
//         itemBuilder: (BuildContext context, int index) {
//           final doc = snapshot.data!.docs[index];
//           final String fileName = doc.get('fileName');
//           final String fileUrl = doc.get('fileUrl');

//           // Customize the widget to display the file information
//           return GestureDetector(
//             onTap: () {
//               // Perform any action when a file is tapped
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.insert_drive_file),
//                   SizedBox(height: 10.0),
//                   Text(
//                     fileName,
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     },
//   );
// }


//   // Future<void> _getImagesList() async {
//   //   try {
//   //     final imagesSnapshot = await _firestore
//   //         .collection('users')
//   //         .doc(_auth.currentUser!.uid)
//   //         .collection('customCollections')
//   //         .doc(widget.collectionName)
//   //         .collection('Files')
//   //         .get();
//   //     final List<String> list = [];
//   //     for (var doc in imagesSnapshot.docs) {
//   //       list.add(doc.data()['url']);
//   //     }
//   //     setState(() {
//   //       _imagesList = list;
//   //     });
//   //   } catch (e) {
//   //     showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return AlertDialog(
//   //           title: const Text('Error'),
//   //           content: const Text('Failed to fetch Files. Please try again.'),
//   //           actions: [
//   //             ElevatedButton(
//   //               onPressed: () {
//   //                 Navigator.of(context).pop();
//   //               },
//   //               child: const Text('OK'),
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     );
//   //   }
//   // }
// }
// ignore_for_file: prefer_const_constructors

import 'package:clouds/Screens/CommonScreens/custom_button.dart';
import 'package:clouds/Screens/FolderScreen/downloadzip.dart';
import 'package:clouds/Screens/FolderScreen/imageshowpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final picker = ImagePicker();

  List<String> _collectionsList = [];

  @override
  void initState() {
    super.initState();
    _getCollectionsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          width: double.infinity, // Set the desired width
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color.fromARGB(255, 135, 0, 121),
                Color.fromARGB(255, 0, 0, 0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Collections',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: _collectionsList.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: _collectionsList.length,
                itemBuilder: (context, index) {
                  final collectionName = _collectionsList[index];
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.black,
                            title: Center(
                              child: Text(
                                '$collectionName',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: SizedBox(
                                      height: 50,
                                      width: 200,
                                      child: CustomButtondl(
                                        text: 'Delete',
                                        onPressed: () {
                                          Navigator.pop(
                                              context); // Close the dialog
                                          _deleteCollection(collectionName);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: CustomButton(
                                      text: 'Share',
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // Close the dialog
                                        downloadCollection(collectionName);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CollectionPage(
                            userId: _auth.currentUser!.uid,
                            collectionId: collectionName,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      child: Center(
                          child: Icon(
                        Icons.folder,
                        size: 100,
                        color: Colors.white,
                      )),
                    ),
                  );
                },
              )
            : const Center(
                child: Text('No Collections Found'),
              ),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        height: 50,
        child: CustomButton(
          text: '+ Create Folder',
          onPressed: () => _createCustomCollection(),
        ),
      ),
    );
  }

  Future<void> _createCustomCollection() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String collectionName = '';

        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Enter Collection Name',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            onChanged: (value) {
              collectionName = value;
            },
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
          actions: [
            Center(
              child: SizedBox(
                width: 200,
                height: 50,
                child: CustomButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (collectionName.isNotEmpty) {
                      _addCustomCollection(collectionName);
                    }
                  },
                  text: 'Create',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addCustomCollection(String collectionName) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('customCollections')
          .doc(collectionName)
          .set({});
      setState(() {
        _collectionsList.add(collectionName);
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to create collection. Please try again.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _getCollectionsList() async {
    try {
      final collectionsSnapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('customCollections')
          .get();
      final List<String> list = [];
      for (var doc in collectionsSnapshot.docs) {
        list.add(doc.id);
      }
      setState(() {
        _collectionsList = list;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to fetch collections. Please try again.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _deleteCollection(String collectionName) async {
    try {
      // Delete the collection from Firestore
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('customCollections')
          .doc(collectionName)
          .delete();

      // Delete the files under the collection from Storage
      final Reference storageRef = _storage
          .ref()
          .child(_auth.currentUser!.uid)
          .child('customCollections')
          .child(collectionName);

      final ListResult listResult = await storageRef.listAll();
      final List<Future<void>> deletionFutures = [];
      for (final item in listResult.items) {
        deletionFutures.add(item.delete());
      }

      await Future.wait(deletionFutures);

      // Refresh the collections list after deletion
      setState(() {
        _collectionsList.remove(collectionName);
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to delete collection. Please try again.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _shareCollection(String collectionName) {
    // Generate a link to share the collection
    final collectionLink = 'https://example.com/collections/$collectionName';
    Share.share('Check out this collection: $collectionLink');

    // Use the link to share through other platforms like mail, WhatsApp, etc.
    // Implement the sharing functionality according to your requirements.
  }
}

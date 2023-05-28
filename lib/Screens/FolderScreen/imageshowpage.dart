import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class CollectionPage extends StatefulWidget {
  final String collectionId;
  final String userId;

  CollectionPage({required this.collectionId, required this.userId});

  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late Reference _collectionRef;
  List<UploadTask> _uploadTasks = [];
  List<String> _fileUrls = [];

  @override
  void initState() {
    super.initState();
    _collectionRef = _storage.ref().child(widget.collectionId);
    _getFileUrls();
  }

  Future<void> _getFileUrls() async {
    final ListResult result = await _collectionRef.listAll();
    setState(() {
      _fileUrls = result.items.map((ref) => ref.fullPath).toList();
    });
  }

  Future<void> _uploadFile(File file) async {
    final String fileName = Path.basename(file.path);
    final Reference storageRef = _collectionRef.child(fileName);
    final UploadTask uploadTask = storageRef.putFile(file);

    setState(() {
      _uploadTasks.add(uploadTask);
    });

    final TaskSnapshot snapshot = await uploadTask;
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    setState(() {
      _uploadTasks.remove(uploadTask);
      _fileUrls.add(snapshot.ref.fullPath);
    });

    print('File uploaded: $downloadUrl');
  }

  Widget _buildUploadIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildFilesList() {
    if (_uploadTasks.isNotEmpty) {
      return _buildUploadIndicator();
    }

    if (_fileUrls.isEmpty) {
      return Text('No files uploaded');
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _fileUrls.length,
      itemBuilder: (context, index) {
        final String filePath = _fileUrls[index];
        final String fileName = Path.basename(filePath);
        final String fileExtension = Path.extension(filePath);

        Widget fileIcon;
        if (fileExtension == '.pdf') {
          fileIcon = Icon(Icons.picture_as_pdf, size: 50);
        } else if (fileExtension == '.jpg' ||
            fileExtension == '.jpeg' ||
            fileExtension == '.png') {
          fileIcon = Image.network(filePath);
        } else if (fileExtension == '.mp4') {
          fileIcon = Icon(Icons.videocam, size: 50);
        } else {
          fileIcon = Icon(Icons.insert_drive_file, size: 50);
        }

        return GridTile(
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  fileIcon,
                  SizedBox(height: 10),
                  Text(fileName),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collection Page'),
      ),
      body: _buildFilesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles(
            allowMultiple: true,
          );

          if (result != null) {
            result.files.forEach((file) async {
              await _uploadFile(File(file.path!));
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

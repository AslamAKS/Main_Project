import 'dart:io';
import 'package:archive/archive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

// Function to download and create a zip file of a collection
Future<void> downloadCollection(String collectionName) async {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final String uid = auth.currentUser!.uid;

  // Create a temporary directory to store the collection files
  final Directory tempDir = await getTemporaryDirectory();
  final String tempPath = tempDir.path;

  // Create a subdirectory with the collection name
  final Directory collectionDir = Directory('$tempPath/$collectionName');
  await collectionDir.create(recursive: true);

  // Download each file in the collection and save it in the subdirectory
  final QuerySnapshot fileSnapshot = await firestore
      .collection('users')
      .doc(uid)
      .collection('customCollections')
      .doc(collectionName)
      .collection('files')
      .get();

  final List<String> downloadUrls = [];

  for (final doc in fileSnapshot.docs) {
    final String fileName = doc.get('fileName');
    final String fileUrl = doc.get('fileUrl');
    final String filePath = '${collectionDir.path}/$fileName';

    final http.Response response = await http.get(Uri.parse(fileUrl));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    downloadUrls.add(filePath);
  }

  // Create a zip file of the collection
  final String zipFilePath = '$tempPath/$collectionName.zip';
  final Archive archive = Archive();

  for (final fileUrl in downloadUrls) {
    final File file = File(fileUrl);
    final List<int> fileBytes = await file.readAsBytes();
    final ArchiveFile archiveFile = ArchiveFile(
      fileUrl.replaceAll('${collectionDir.path}/', ''),
      fileBytes.length,
      fileBytes,
    );

    archive.addFile(archiveFile);
  }

  final File zipFile = File(zipFilePath);
  final List<int>? zipData = ZipEncoder().encode(archive);
  await zipFile.writeAsBytes(zipData!);

  // Provide the download link to the user or perform any other action with the zip file

  // Clean up: Delete the temporary directory and its contents
  await collectionDir.delete(recursive: true);
}

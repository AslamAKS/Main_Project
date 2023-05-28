import 'package:flutter/material.dart';

class DocumentsAlbum extends StatelessWidget {
  const DocumentsAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Documents only',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

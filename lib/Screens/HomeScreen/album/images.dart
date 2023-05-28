import 'package:flutter/material.dart';

class ImagesAlbum extends StatelessWidget {
  const ImagesAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Images Only',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

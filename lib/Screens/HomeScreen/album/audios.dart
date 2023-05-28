import 'package:flutter/material.dart';

class AudiosAlbum extends StatelessWidget {
  const AudiosAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Audio files only',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

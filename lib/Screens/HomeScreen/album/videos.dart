import 'package:flutter/material.dart';

class VideosAlbum extends StatelessWidget {
  const VideosAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Videos Only',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

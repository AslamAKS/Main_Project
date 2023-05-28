import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 206, 9, 163),
              Color.fromARGB(255, 0, 0, 0)
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Premium Page',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

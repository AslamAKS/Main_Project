import 'dart:async';

import 'package:clouds/Authentications/provider/authentication_provider.dart';
import 'package:clouds/Screens/CommonScreens/get_start.dart';
import 'package:clouds/Screens/CommonScreens/navigation_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    Timer(
      const Duration(seconds: 3),
      () async {
        if (ap.isSignedIn == true) {
          await ap.getDataFromSP().whenComplete(
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                ),
              );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const GetStart(),
            ),
          );
        }
      },
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "asset/images/CloudS.png",
                  height: 300.0,
                  width: 300.0,
                ),
                const Text(
                  "CloudS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:clouds/Authentications/provider/authentication_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'Screens/CommonScreens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Product Sans',
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
            ),
            // Add more text styles here if needed
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}

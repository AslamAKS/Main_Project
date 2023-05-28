import 'package:clouds/Screens/FolderScreen/collections.dart';
import 'package:clouds/Screens/HomeScreen/album_screen.dart';
import 'package:clouds/Screens/PremiumScreen/third_screen_settings.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  late final String subCollectionName;

  final PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
        children: [
          AlbumScreen(),
          HomePage(),
          PremiumPage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.library_books, size: 30),
          Icon(Icons.diamond, size: 30),
        ],
        color: Colors.white70,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.black,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          });
        },
      ),
    );
  }
}

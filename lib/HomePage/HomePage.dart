import 'package:flutter/material.dart';
import 'package:movieflutter/SectionHomeUi/HomeScreen.dart';

import '../Authentication/auth_ui.dart';
import '../SectionHomeUi/FavoriteList.dart';
import '../SectionHomeUi/ProfileScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> trendingweek = [];
  int uval = 1;
  int selectedTab = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    FavoriteMovies(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 18, 0.5),
      body: Scaffold(
          backgroundColor: Color(0xff19191b),
          body: Stack(children: [
            LayeredRadialBackground(),
            LayeredRadialBackgroundOverlay(),
            _pages[selectedTab]
          ])),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(18, 18, 18, 1),
        selectedItemColor: Color(0xff34e3c4),
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false, // Hides selected item labels
        showUnselectedLabels: false,
        currentIndex: selectedTab,
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

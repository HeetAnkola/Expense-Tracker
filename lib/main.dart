import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'Pages/homepage.dart';
import 'Pages/camera.dart';
import 'Pages/cards.dart';
import 'Pages/portfolio.dart';
import 'Pages/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBar(cameras: cameras),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final List<CameraDescription> cameras;
  const BottomNavBar({Key? key, required this.cameras}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(),
      DebitCardsPage(),
      CameraPage(cameras: widget.cameras), // Placeholder for the camera icon
      PortfolioPage(),
      ProfilePage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Debit Cards',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 40, // Larger size for the camera icon
              width: 40, // Larger size for the camera icon
              decoration: const BoxDecoration(
                color: Colors.orange, // Custom color for the camera icon
                shape: BoxShape.circle, // Circular shape for the camera icon
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white, // Custom color for the camera icon
              ),
            ),
            label: '', // Empty label for the camera icon
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Portfolio',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: buttonColor,
        unselectedItemColor: Colors.white,
        backgroundColor: backgroundColor,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: CustomIcon(),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: "Profile",
          ),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}

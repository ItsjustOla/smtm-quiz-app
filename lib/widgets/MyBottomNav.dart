import 'package:flutter/material.dart';
import 'package:smtm_app/main.dart';
import 'package:smtm_app/quizPage.dart';
import 'package:smtm_app/settingsPage.dart';

class MyBottomNav extends StatefulWidget {
  const MyBottomNav({Key? key, required this.currentIndex}) : super(key: key);

  final int currentIndex;

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  void _handlePageTransition(int index, int currentIndex) {
    if (currentIndex == index){
      return;
    }
    setState(() {
      switch (index) {
        case 0: Navigator.pushNamed(context, '/');
          break;
        case 1: Navigator.pushNamed(context, '/quiz');
          break;
        case 2: Navigator.pushNamed(context, '/settings');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.checklist_rtl_rounded), label: 'Quiz'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      currentIndex: widget.currentIndex,
      onTap: (int index) => _handlePageTransition(index, widget.currentIndex),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:news_app_project/view/homescreen/homescreen.dart';
import 'package:news_app_project/view/searchnews_screen/searchnews_screen.dart';
import 'package:provider/provider.dart';
import '../../controller/bottomnavbar_controller.dart';

class BottomnavbarScreen extends StatelessWidget {
   BottomnavbarScreen({super.key});
  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomnavbarController>(context);
    return Scaffold(
      body: _screens[provider.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.selectedIndex,
        selectedItemColor: Color(0xFF16C47F),
          unselectedItemColor: Colors.white,
          onTap: provider.setSelectedIndex,
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home",),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search")
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:palinha_test/src/modules/home/screens/home_screen.dart';
import 'package:palinha_test/src/modules/task/screens/task_screen.dart';
import 'package:palinha_test/src/modules/main/screens/widgets/bottom_nav_bar.dart';

class MainScaffold extends StatefulWidget {
  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  String title = "Home";

  final List<Widget> _pages = [
    HomeScreen(),
    TaskScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      title = index == 0 ? "Home" : "Tarefas";
    });
    Modular.to.navigate(index == 0 ? '/main/home' : '/main/tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Color(0xFFEEEEEE)),
        ),
        backgroundColor: Color(0xFF201E43),
      ),
      backgroundColor: Color(0xFFF3F7EC),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

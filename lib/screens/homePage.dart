import 'package:flutter/material.dart';
import 'package:pulse_front/screens/activityPage.dart';
import 'package:pulse_front/screens/contentPage.dart';
import 'package:pulse_front/screens/detailsActivityPage.dart';
import 'package:pulse_front/screens/goalsPage.dart';
import 'package:pulse_front/screens/profilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token') ?? 'No Token Found';
    });
  }



  final List<Widget> _pages = [
    ContentPage(),
    GoalsPage(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color.fromARGB(255, 37, 36, 36),
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.grey[400]),
          ),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Color.fromARGB(255, 3, 126, 124),
          unselectedItemColor: Colors.grey[400],
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Objectifs'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistiques'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Amis'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


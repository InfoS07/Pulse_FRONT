import 'package:flutter/material.dart';
import 'package:pulse_front/screens/activityPage.dart';
import 'package:pulse_front/screens/detailsActivityPage.dart';
import 'package:pulse_front/screens/goalsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
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

  List<Widget> _pages = [
    ContentPage(),
    GoalsPage(),
    ActivityScreen(),
    SettingsPage(),
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
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Goal'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        SizedBox(height: 60.0),
        _buildSectionTitle('My Content'),
        SizedBox(height: 20.0),
        GestureDetector(
          onTap: () {
            // Action pour créer et sauvegarder des activités
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.white, size: 30),
                SizedBox(width: 10.0),
                Text(
                  'Create & Save\nYour own activities',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.0),
        _buildSectionTitle('Suggested For You'),
        SizedBox(height: 20.0),
        _buildContentCarousel(context, [
          _buildSuggestedCard(context, 'Power Push-Up', 'BlazePod'),
          _buildSuggestedCard(context, 'Workout', 'BlazePod'),
          _buildSuggestedCard(context, 'Yoga', 'FitBit'),
        ]),
        SizedBox(height: 20.0),
        _buildSectionTitle('Explore'),
        SizedBox(height: 20.0),
        _buildContentCarousel(context, [
          _buildExploreCard(context),
          _buildExploreCard(context),
          _buildExploreCard(context),
        ]),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildContentCarousel(BuildContext context, List<Widget> cards) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: cards[index],
          );
        },
      ),
    );
  }

  Widget _buildSuggestedCard(BuildContext context, String title, String subtitle) {
    return GestureDetector(
      onTap: () {
        // Action when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsActivityScreen()),
        );
      },
      child: Container(
        width: 300.0,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Image.network(
                'https://img-4.linternaute.com/gSVIxlCwi_Iwf_oTkByPqsUmfS4=/1240x/smart/ff9b85658e384aaaaa49769b55db80fe/ccmcms-linternaute/10763197.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExploreCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Action when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsActivityScreen()),
        );
      },
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Image.network(
                'https://img-4.linternaute.com/gSVIxlCwi_Iwf_oTkByPqsUmfS4=/1240x/smart/ff9b85658e384aaaaa49769b55db80fe/ccmcms-linternaute/10763197.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16.0),
                      bottomRight: Radius.circular(16.0),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                    
                  ),
                  child: Text(
                    'Explore',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Stats Page',
        style: TextStyle(fontSize: 24.0, color: Colors.white),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings Page',
        style: TextStyle(fontSize: 24.0, color: Colors.white),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String title;

  DetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Details of $title',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

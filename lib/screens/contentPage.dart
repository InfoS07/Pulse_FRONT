
import 'package:flutter/material.dart';
import 'package:pulse_front/screens/detailsActivityPage.dart';

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        title: const Text(
          'Entrainements',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        automaticallyImplyLeading: false, // Retirer la flèche de retour
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Favoris'),
          SizedBox(height: 20.0),
          _buildContentCarousel(context, [
            _buildSuggestedCard(context, 'Power Push-Up', 'BlazePod'),
            _buildSuggestedCard(context, 'Workout', 'BlazePod'),
            _buildSuggestedCard(context, 'Yoga', 'FitBit'),
          ]),
          _buildViewAllButton(context), // Bouton "Tout Voir"
          SizedBox(height: 20.0),
          _buildSectionTitle('Suggéré pour vous'),
          SizedBox(height: 20.0),
          _buildContentCarousel(context, [
            _buildSuggestedCard(context, 'Power Push-Up', 'BlazePod'),
            _buildSuggestedCard(context, 'Workout', 'BlazePod'),
            _buildSuggestedCard(context, 'Yoga', 'FitBit'),
          ]),
          _buildViewAllButton(context), // Bouton "Tout Voir"
          SizedBox(height: 20.0),
          _buildSectionTitle('Explorer'),
          SizedBox(height: 20.0),
          _buildContentCarousel(context, [
            _buildExploreCard(context),
            _buildExploreCard(context),
            _buildExploreCard(context),
          ]),
          _buildViewAllButton(context), // Bouton "Tout Voir"
        ],
      ),
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
                    'Explorer',
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

Widget _buildViewAllButton(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        // Action when "Tout Voir" is pressed
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85, // 85% of screen height
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 37, 36, 36),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tous les Entraînements',
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 20.0),
                        _buildAllActivitiesList(), // Display all activities here
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Text(
        'Tout Voir',
        style: TextStyle(color: Colors.blueAccent),
      ),
    ),
  );
}



Widget _buildAllActivitiesList() {
  // Vous pouvez remplacer cela par une liste d'objets représentant vos activités
  List<Map<String, dynamic>> activities = [
    {"title": "Activity 1", "subtitle": "Description of activity 1", "imageURL": "https://img-4.linternaute.com/gSVIxlCwi_Iwf_oTkByPqsUmfS4=/1240x/smart/ff9b85658e384aaaaa49769b55db80fe/ccmcms-linternaute/10763197.jpg"},
    {"title": "Activity 2", "subtitle": "Description of activity 2", "imageURL": "https://img-4.linternaute.com/gSVIxlCwi_Iwf_oTkByPqsUmfS4=/1240x/smart/ff9b85658e384aaaaa49769b55db80fe/ccmcms-linternaute/10763197.jpg"},
    {"title": "Activity 3", "subtitle": "Description of activity 3", "imageURL": "https://img-4.linternaute.com/gSVIxlCwi_Iwf_oTkByPqsUmfS4=/1240x/smart/ff9b85658e384aaaaa49769b55db80fe/ccmcms-linternaute/10763197.jpg"},
    // Ajoutez d'autres activités ici selon votre besoin
  ];

  return Column(
    children: activities.map((activity) {
      return ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            activity['imageURL'],
            width: 60.0,
            height: 60.0,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          activity['title'],
          style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          activity['subtitle'],
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          // Action when an activity is tapped
          
        },
      );
    }).toList(),
  );
}

}

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        title: Text('Profile', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white)),
        automaticallyImplyLeading: false, // Retirer la flèche de retour

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/avatar.png'), // Replace with your avatar image
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rafiq',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text('@Rafiq802302 • Joined May 2021', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Courses
            Row(
              children: [
                Image.asset('assets/flag_japan.png', width: 24, height: 24), // Replace with your flag image
                SizedBox(width: 8),
                Image.asset('assets/flag_brazil.png', width: 24, height: 24), // Replace with your flag image
              ],
            ),
            SizedBox(height: 16),
            
            // Follow information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0 Following', style: TextStyle(color: Colors.white)),
                Text('0 Followers', style: TextStyle(color: Colors.white)),
              ],
            ),
            SizedBox(height: 16),
            
            // Add friends button
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {},
              child: Text('ADD FRIENDS'),
            ),
            SizedBox(height: 16),
            
            // Friend suggestions
            Text('Friend suggestions', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            FriendSuggestionCard(name: 'Schabro', description: 'From your league'),
            FriendSuggestionCard(name: 'Stephane', description: 'You may know each other'),
            FriendSuggestionCard(name: 'Nana', description: 'You may know each other'),
            SizedBox(height: 16),
            
            // Overview
            Text('Overview', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            OverviewItem(icon: Icons.local_fire_department, label: '43 Day streak'),
            OverviewItem(icon: Icons.flash_on, label: '4566 Total XP'),
            OverviewItem(icon: Icons.leaderboard, label: 'Sapphire League - Week 3'),
            OverviewItem(icon: Icons.emoji_events, label: '0 Top 3 finishes'),
            SizedBox(height: 16),
            
            // Achievements
            Text('Achievements', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            AchievementItem(icon: Icons.explore, label: '25'),
            AchievementItem(icon: Icons.star, label: '4000'),
            AchievementItem(icon: Icons.fitness_center, label: '20'),
          ],
        ),
      ),
    );
  }
}

class FriendSuggestionCard extends StatelessWidget {
  final String name;
  final String description;

  FriendSuggestionCard({required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 45, 45, 45),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(name[0], style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Text(description, style: TextStyle(color: Colors.white70)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          onPressed: () {},
          child: Text('FOLLOW'),
        ),
      ),
    );
  }
}

class OverviewItem extends StatelessWidget {
  final IconData icon;
  final String label;

  OverviewItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 45, 45),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class AchievementItem extends StatelessWidget {
  final IconData icon;
  final String label;

  AchievementItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 45, 45),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
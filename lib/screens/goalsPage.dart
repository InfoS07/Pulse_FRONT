import 'package:flutter/material.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        title: const Text('Goals', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildGoalHeader(),
          const SizedBox(height: 20.0),
          _buildProgressCard(),
          const SizedBox(height: 20.0),
          const Text(
            'Quetes quotidiennes',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 3, 126, 124),
            ),
          ),
          const SizedBox(height: 10.0),
          _buildDailyQuest('Compléter encore 2 activités', 2, 2, Icons.star, Colors.pink),
          _buildDailyQuest('Passer 10 Minutes a vous entrainer', 10, 10, Icons.timer, Colors.blue),
          _buildDailyQuest('Atteignez plus de 90% de vos aptitudes sur un exercice', 4, 4, Icons.check_circle, Colors.green),
        ],
      ),
    );
  }

  Widget _buildGoalHeader() {
    return Row(
      children: [
        const Icon(Icons.directions_bike, size: 50, color: Color.fromARGB(255, 3, 126, 124)),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Badge du mois de Mai",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 3, 126, 124)),
            ),
            SizedBox(height: 5.0),
            Text(
              "4 JOURS RESTANTS",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 45, 45),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Compléter 30 quêtes',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 16 / 30,
              minHeight: 20.0,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 3, 126, 124)),
            ),
          ),
          const SizedBox(height: 10.0),
          const Text('16/30 quests completed', style: TextStyle(fontSize: 16.0, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildDailyQuest(String title, int completed, int total, IconData icon, Color color) {
    return Card(
      color: const Color.fromARGB(255, 45, 45, 45),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        leading: Icon(icon, size: 40, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: completed / total,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: 5.0),
            Text('$completed/$total', style: const TextStyle(fontSize: 16.0, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

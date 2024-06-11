import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  List<Map<String, dynamic>> objectives = [];

  void _addObjective(String title, int progress) {
    setState(() {
      objectives.add({'title': title, 'progress': progress});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        title: const Text(
          'Goals',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        automaticallyImplyLeading: false, // Retirer la flèche de retour

      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildObjectivesSection(),
          const SizedBox(height: 10.0),
          const Text(
            'Quêtes hebdomadaires',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 10.0),
          _buildWeeklyQuest('Compléter 5 activités cette semaine', 3, 5, Icons.star, Colors.pink),
          _buildWeeklyQuest('Passer 50 Minutes à vous entraîner', 30, 50, Icons.timer, Colors.blue),
          _buildWeeklyQuest('Atteindre plus de 90% de vos aptitudes sur deux exercices', 1, 2, Icons.check_circle, Colors.green),
          const SizedBox(height: 20.0),
          const Text(
            'Défis de saison',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 10.0),
          _buildSeasonalChallenge('Faire un exercice de running', Icons.directions_run, Colors.orange),
          const SizedBox(height: 20.0),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddObjectiveModal(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGoalHeader() {
    return Row(
      children: [
        const Icon(Icons.directions_bike, size: 50, color: Color.fromARGB(255, 255, 255, 255)),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Badge du mois de Mai",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
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
          const Text('16/30 quêtes complétées', style: TextStyle(fontSize: 16.0, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildWeeklyQuest(String title, int completed, int total, IconData icon, Color color) {
    return Card(
      color: const Color.fromARGB(255, 45, 45, 45),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(icon, size: 40, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: completed / total,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: 8.0),
            Text('$completed/$total', style: const TextStyle(fontSize: 16.0, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildSeasonalChallenge(String title, IconData icon, Color color) {
    return Card(
      color: const Color.fromARGB(255, 45, 45, 45),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(icon, size: 40, color: color),
        title: Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildObjectivesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Objectifs',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        const SizedBox(height: 10.0),
        ...objectives.map((objective) => _buildObjectiveCard(objective['title'], objective['progress'])).toList(),
      ],
    );
  }

  Widget _buildObjectiveCard(String title, int progress) {
    return Card(
      color: const Color.fromARGB(255, 45, 45, 45),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            const SizedBox(height: 8.0),
            Text('$progress%', style: const TextStyle(fontSize: 16.0, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  void _showAddObjectiveModal(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController progressController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 45, 45, 45),
          title: const Text('Ajouter un objectif', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              TextField(
                controller: progressController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Progression (%)',
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Annuler', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Ajouter', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                final String title = titleController.text;
                final int progress = int.tryParse(progressController.text) ?? 0;
                if (title.isNotEmpty && progress >= 0 && progress <= 100) {
                  _addObjective(title, progress);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

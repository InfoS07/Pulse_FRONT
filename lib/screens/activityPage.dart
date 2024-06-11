import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String selectedFilter = 'M';
  DateTime selectedDate = DateTime.now();
  List<Activity> activities = [
    Activity(date: DateTime(2024, 5, 27), type: 'Musculation', duration: Duration(minutes: 45)),
    Activity(date: DateTime(2024, 5, 26), type: 'Yoga', duration: Duration(minutes: 30)),
    Activity(date: DateTime(2024, 6, 25), type: 'Cardio', duration: Duration(minutes: 50)),
        Activity(date: DateTime(2024, 5, 27), type: 'Musculation', duration: Duration(minutes: 45)),
    Activity(date: DateTime(2024, 5, 26), type: 'Yoga', duration: Duration(minutes: 30)),
    Activity(date: DateTime(2024, 6, 25), type: 'Cardio', duration: Duration(minutes: 50)),
        Activity(date: DateTime(2024, 5, 27), type: 'Musculation', duration: Duration(minutes: 45)),
    Activity(date: DateTime(2024, 5, 26), type: 'Yoga', duration: Duration(minutes: 30)),
    Activity(date: DateTime(2024, 6, 25), type: 'Cardio', duration: Duration(minutes: 50)),
        Activity(date: DateTime(2024, 5, 27), type: 'Musculation', duration: Duration(minutes: 45)),
    Activity(date: DateTime(2024, 5, 26), type: 'Yoga', duration: Duration(minutes: 30)),
    Activity(date: DateTime(2024, 6, 25), type: 'Cardio', duration: Duration(minutes: 50)),
        Activity(date: DateTime(2024, 5, 27), type: 'Musculation', duration: Duration(minutes: 45)),
    Activity(date: DateTime(2024, 5, 26), type: 'Yoga', duration: Duration(minutes: 30)),
    Activity(date: DateTime(2024, 6, 25), type: 'Cardio', duration: Duration(minutes: 50)),
    // Add more activities here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        title: const Text('Activité', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white)),
        automaticallyImplyLeading: false, // Retirer la flèche de retour

      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFilterBar(),
          const SizedBox(height: 20.0),
          _buildSummary(),
          const SizedBox(height: 20.0),
          _buildActivityList(),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilterButton('J', 'Jour'),
        _buildFilterButton('S', 'Semaine'),
        _buildFilterButton('M', 'Mois'),
        _buildFilterButton('A', 'Année'),
      ],
    );
  }

  Widget _buildFilterButton(String filter, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = filter;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: selectedFilter == filter ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    final filteredActivities = _getFilteredActivities();
    final totalDuration = filteredActivities.fold(Duration(), (sum, item) => sum + item.duration);
    final avgDuration = totalDuration.inMinutes ~/ (filteredActivities.length == 0 ? 1 : filteredActivities.length);
    
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
          Text(
            'Total: ${filteredActivities.length} activités',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          SizedBox(height: 8.0),
          Text(
            'Durée totale: ${totalDuration.inMinutes} minutes',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          SizedBox(height: 8.0),
          Text(
            'Durée moyenne: ${avgDuration} minutes',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList() {
    final filteredActivities = _getFilteredActivities();

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredActivities.length,
      itemBuilder: (context, index) {
        final activity = filteredActivities[index];
        return Card(
          color: const Color.fromARGB(255, 45, 45, 45),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            title: Text(activity.type, style: TextStyle(fontSize: 18.0, color: Colors.white)),
            subtitle: Text('Durée: ${activity.duration.inMinutes} minutes', style: TextStyle(color: Colors.white)),
            trailing: Text('${activity.date.day}/${activity.date.month}/${activity.date.year}', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityDetailScreen(activity: activity),
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<Activity> _getFilteredActivities() {
    DateTime startDate;
    DateTime endDate;

    switch (selectedFilter) {
      case 'J':
        startDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        endDate = startDate.add(Duration(days: 1));
        break;
      case 'S':
        startDate = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        endDate = startDate.add(Duration(days: 7));
        break;
      case 'M':
        startDate = DateTime(selectedDate.year, selectedDate.month, 1);
        endDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
        break;
      case 'A':
        startDate = DateTime(selectedDate.year, 1, 1);
        endDate = DateTime(selectedDate.year + 1, 1, 1);
        break;
      default:
        startDate = DateTime(selectedDate.year, selectedDate.month, 1);
        endDate = DateTime(selectedDate.year, selectedDate.month + 1, 1);
    }

    return activities.where((activity) {
      return activity.date.isAfter(startDate) && activity.date.isBefore(endDate);
    }).toList();
  }
}

class Activity {
  final DateTime date;
  final String type;
  final Duration duration;

  Activity({required this.date, required this.type, required this.duration});
}

class ActivityDetailScreen extends StatelessWidget {
  final Activity activity;

  ActivityDetailScreen({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        title: Text('Détails de l\'activité', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.type,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 16.0),
            Text('Date: ${activity.date.day}/${activity.date.month}/${activity.date.year}', style: TextStyle(color: Colors.white)),
            SizedBox(height: 8.0),
            Text('Durée: ${activity.duration.inMinutes} minutes', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

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
    Activity(date: DateTime(2024, 5, 25), type: 'Cardio', duration: Duration(minutes: 50)),
    // Add more activities here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activité'),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          _buildSummary(),
          Expanded(child: _buildActivityList()),
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
    final avgDuration = totalDuration.inMinutes ~/ filteredActivities.length;
   

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Total: ${filteredActivities.length} activités',
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            'Durée totale: ${totalDuration.inMinutes} minutes',
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            'Durée moyenne: ${avgDuration} minutes',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityList() {
    final filteredActivities = _getFilteredActivities();

    return ListView.builder(
      itemCount: filteredActivities.length,
      itemBuilder: (context, index) {
        final activity = filteredActivities[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityDetailScreen(activity: activity),
              ),
            );
          },
          child: ListTile(
            title: Text(activity.type),
            subtitle: Text('Durée: ${activity.duration.inMinutes} minutes'),
            trailing: Text('${activity.date.day}/${activity.date.month}/${activity.date.year}'),
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
      appBar: AppBar(
        title: Text('Détails de l\'activité'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.type,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Date: ${activity.date.day}/${activity.date.month}/${activity.date.year}'),
            SizedBox(height: 8.0),
            Text('Durée: ${activity.duration.inMinutes} minutes'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
      ),
      body: Column(
        children: [
          const EventStatistics(),
          ProjectStatistics(),
        ],
      ),
    );
  }
}

class EventStatistics extends StatelessWidget {
  const EventStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    // Ajoutez votre logique de calcul des statistiques des événements ici
    int totalEvents = 10;
    int upcomingEvents = 5;
    int completedEvents = 5;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistiques des événements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Total des événements: $totalEvents'),
            Text('Événements à venir: $upcomingEvents'),
            Text('Événements terminés: $completedEvents'),
          ],
        ),
      ),
    );
  }
}

class ProjectStatistics extends StatelessWidget {
  const ProjectStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    // Ajoutez votre logique de calcul des statistiques des projets ici
    int totalProjects = 5;
    int inProgressProjects = 3;
    int completedProjects = 2;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistiques des projets',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Total des projets: $totalProjects'),
            Text('Projets en cours: $inProgressProjects'),
            Text('Projets terminés: $completedProjects'),
          ],
        ),
      ),
    );
  }
}
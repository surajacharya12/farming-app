import 'package:flutter/material.dart';

class Crowdfunding extends StatefulWidget {
  const Crowdfunding({super.key});

  @override
  State<Crowdfunding> createState() => _CrowdfundingState();
}

class _CrowdfundingState extends State<Crowdfunding> {
  // Sample data for crowdfunding projects
  List<Map<String, dynamic>> projects = [
    {
      'title': 'Organic Farm Development',
      'description': 'We need funds to start a fully organic farm.',
      'goal': 10000,
      'raised': 3500,
      'progress': 35,
    },
    {
      'title': 'Greenhouse Construction',
      'description': 'Help us build a greenhouse to grow more vegetables.',
      'goal': 15000,
      'raised': 9000,
      'progress': 60,
    },
  ];

  // Function to display crowdfunding progress as a percentage
  double getProgress(int goal, int raised) {
    return (raised / goal) * 100;
  }

  // Add new crowdfunding project logic
  void _addProject() {
    // Placeholder for adding a new crowdfunding project
    // You can show a form to capture project details here
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Project'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Project Title'),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Funding Goal'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // You can implement adding project logic here
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement saving new project logic here
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Crowd Funding'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addProject),
        ],
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          var project = projects[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    project['description'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Funding Goal: \$${project['goal']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Amount Raised: \$${project['raised']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: project['progress'] / 100,
                    backgroundColor: Colors.grey[200],
                    color: Colors.green,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Progress: ${project['progress']}%',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

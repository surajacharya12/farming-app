import 'package:flutter/material.dart';

class BuildSearchWidget extends StatelessWidget {
  const BuildSearchWidget({super.key});

  static final List<NavigationDestination> _destination = [
    NavigationDestination(
      icon: Icon(Icons.cloud_outlined),
      selectedIcon: Icon(Icons.cloud),
      label: 'weather',
    ),
    NavigationDestination(
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search),
      label: 'search',
    ),
    NavigationDestination(
      icon: Icon(Icons.wb_sunny_outlined),
      selectedIcon: Icon(Icons.sunny),
      label: 'sunny',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Weather'),
        actions: [
          PopupMenuButton<int>(
            onSelected: (int index) {
              // Add your navigation logic here
              // You can use the index to navigate or perform actions
            },
            itemBuilder: (BuildContext context) {
              return List.generate(
                _destination.length,
                (index) => PopupMenuItem<int>(
                  value: index,
                  child: Row(
                    children: [
                      _destination[index].icon,
                      SizedBox(
                        width: 10,
                      ), // Optional space between icon and label
                      Text(
                        _destination[index].label,
                        style: TextStyle(
                          color: Colors.black,
                        ), // Set text color to black
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(child: Text('Content goes here')),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:krishi_sathi/widgets/weather/screens/weather_screen/weather_screen.dart';
import 'package:krishi_sathi/widgets/weather/screens/search_screen.dart';
import 'package:krishi_sathi/widgets/weather/screens/settings_screen.dart';
import 'package:krishi_sathi/widgets/weather/screens/forecast_report_screen.dart';

class BuildSearchWidget extends StatefulWidget {
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
      label: 'weather forecast',
    ),
  ];

  @override
  State<BuildSearchWidget> createState() => _BuildSearchWidgetState();
}

class _BuildSearchWidgetState extends State<BuildSearchWidget> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    WeatherScreen(),
    SearchScreen(),
    ForecastReportScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(BuildSearchWidget._destination[_selectedIndex].label),
        actions: [
          PopupMenuButton<int>(
            onSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemBuilder: (BuildContext context) {
              return List.generate(
                BuildSearchWidget._destination.length,
                (index) => PopupMenuItem<int>(
                  value: index,
                  child: Row(
                    children: [
                      BuildSearchWidget._destination[index].icon,
                      const SizedBox(width: 10),
                      Text(
                        BuildSearchWidget._destination[index].label,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),

      // 👇 Only the body changes, app bar stays
      body: _screens[_selectedIndex],
    );
  }
}

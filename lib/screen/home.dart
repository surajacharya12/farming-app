import 'dart:io';
import 'package:flutter/material.dart';

// Pages and Widgets
import 'package:krishi_sathi/AI_Chat_Voice/voice.dart';
import 'package:krishi_sathi/widgets/contact.dart';
import 'package:krishi_sathi/widgets/crowdFunding.dart';
import 'package:krishi_sathi/widgets/setting/setting.dart';
import 'package:krishi_sathi/widgets/notification.dart' as custom;
import 'package:krishi_sathi/widgets/calender.dart';
import 'package:krishi_sathi/widgets/searchWeather.dart';
import 'package:krishi_sathi/widgets/about.dart';
import 'package:krishi_sathi/widgets/market.dart';
import 'package:krishi_sathi/widgets/resources.dart';
import '../widgets/image_picker_helper.dart';
import '../widgets/language.dart';
import '../widgets/Buildhomepage.dart';
import './diseases.dart';
import './crops.dart';
import './legal.dart';
import './farming.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  File? _profileImage;
  String _userName = 'Guest';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _pickImage() async {
    final File? pickedImage = await pickImage(context);
    if (pickedImage != null) {
      setState(() {
        _profileImage = pickedImage;
      });
    }
  }

  Widget _getSelectedWidget(int index) {
    switch (index) {
      case 0:
        return BuildHomePage();
      case 1:
        return const Crops();
      case 2:
        return const Diseases();
      case 3:
        return const Legal();
      case 4:
        return const Farming();
      default:
        return BuildHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('कृषि Sathi'),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const custom.Notification(),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (String newValue) {
              LanguageHelper.changeLanguage(context, newValue);
            },
            itemBuilder:
                (BuildContext context) => const [
                  PopupMenuItem(value: 'en', child: Text('English')),
                  PopupMenuItem(value: 'ne', child: Text('Nepali')),
                ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              accountName: Text(
                _userName,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              accountEmail: const Text(''),
              currentAccountPicture: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child:
                      _profileImage == null
                          ? const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.green,
                          )
                          : null,
                ),
              ),
            ),
            _drawerItem(Icons.person, 'Profile', const ProfilePage()),
            _drawerItem(Icons.calendar_month, 'Calendar', const Calender()),
            _drawerItem(Icons.cloud, 'Weather', const BuildSearchWidget()),
            _drawerItem(Icons.store, 'Market', const Market()),
            _drawerItem(Icons.local_florist, 'Resources', const Resources()),
            _drawerItem(
              Icons.monetization_on,
              'Crowd Funding',
              const Crowdfunding(),
            ),
            _drawerItem(Icons.settings, 'Settings', const Setting()),
            _drawerItem(Icons.info, 'About', const About()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture),
            label: 'Crops',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report),
            label: 'Diseases',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'Legal'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'Farming'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      body: _getSelectedWidget(_selectedIndex),
      floatingActionButton:
          _selectedIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Voice()),
                  );
                },
                tooltip: 'Voice',
                child: const Icon(Icons.mic),
              )
              : null,
    );
  }

  ListTile _drawerItem(IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Close drawer first
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}

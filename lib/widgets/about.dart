import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About"), backgroundColor: Colors.green),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to कृषि Sathi",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "कृषि Sathi is your all-in-one farming assistant designed to help you manage and improve your agricultural activities. Here's what you can do with our app:",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const FeatureItem(
              icon: Icons.search,
              title: "Search Farming Resources",
              description:
                  "Easily find articles, guides, and information related to various aspects of farming.",
            ),
            const FeatureItem(
              icon: Icons.cloud,
              title: "Weather Forecast",
              description:
                  "Get real-time and accurate weather updates to plan your farming activities.",
            ),
            const FeatureItem(
              icon: Icons.store,
              title: "Buy & Sell Vegetables",
              description:
                  "Trade your produce with others by listing items for sale or browsing for things to buy.",
            ),
            const FeatureItem(
              icon: Icons.mic,
              title: "AI Chat & Voice Bot",
              description:
                  "Ask farming questions or get assistance using our smart AI chat and voice system.",
            ),
            const FeatureItem(
              icon: Icons.camera_alt,
              title: "Detect Plant Diseases",
              description:
                  "Use your camera to analyze plant leaves and detect possible diseases instantly.",
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

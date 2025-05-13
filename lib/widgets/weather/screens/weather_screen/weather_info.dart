import 'package:krishi_sathi/extensions/double.dart';
import 'package:krishi_sathi/models/weather.dart';
import 'package:flutter/material.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WeatherInfoTile(
            title: "Temperature",
            value: "${weather.main.temp}°C",
          ),
          WeatherInfoTile(
            title: "Wind Speed",
            value: "${weather.wind.speed.kmh} km/h",
          ),
          WeatherInfoTile(
            title: "Humidity",
            value: "${weather.main.humidity}%",
          ),
        ],
      ),
    );
  }
}

class WeatherInfoTile extends StatelessWidget {
  const WeatherInfoTile({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white, // ✅ Ensures white text
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // ✅ Ensures white text
          ),
        ),
      ],
    );
  }
}

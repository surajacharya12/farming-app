import 'package:krishi_sathi/API/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";
  Future<ApiResponse> getCurrentWeather(String location) async {
    String url = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return ApiResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather');
    }
  }
}

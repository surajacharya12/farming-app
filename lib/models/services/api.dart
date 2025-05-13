import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../constants/constants.dart';
import '../weekly_weather.dart';
import '../hourly_weather.dart';
import '../weather.dart';
import 'package:krishi_sathi/models/services/geolocator.dart';

@immutable
class ApiHelper {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String weeklyWeatherURL =
      'https://api.openweathermap.org/data/2.5/onecall?lat=27.7172&lon=85.324&exclude=hourly,daily&appid=$apiKey&units=metric';

  static double lat = 0.0;
  static double lon = 0.0;
  static final Dio dio = Dio();

  static Future<void> fetchLocation() async {
    Position position = await getLocation();
    lat = position.latitude;
    lon = position.longitude;
  }

  static Future<Weather> getCurrentWeather() async {
    await fetchLocation();
    final url = _constructWeatherUrl();
    final response = await fetchData(url);
    return Weather.fromJson(response);
  }

  static Future<Weather> getWeatherByCity({required String cityName}) async {
    final url = _constructWeatherByCityUrl(cityName);
    final response = await dio.get(url);
    return Weather.fromJson(response.data);
  }

  static Future<WeeklyWeather> getWeeklyForecast() async {
    await fetchLocation();
    final url = _constructWeeklyWeatherUrl();
    final response = await fetchData(url);
    return WeeklyWeather.fromJson(response);
  }

  static Future<HourlyWeather> getHourlyForecast() async {
    await fetchLocation();
    final url = _constructforecastUrl();
    final response = await fetchData(url);
    return HourlyWeather.fromJson(response);
  }

  static String _constructWeatherUrl() =>
      '$baseUrl/weather?lat=$lat&lon=$lon&appid=${Constants.apiKey}&units=metric';

  static String _constructWeeklyWeatherUrl() =>
      '$baseUrl/onecall?lat=$lat&lon=$lon&exclude=hourly,daily&appid=${Constants.apiKey}&units=metric';

  static String _constructforecastUrl() =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&appid=${Constants.apiKey}&units=metric';

  static String _constructWeatherByCityUrl(String cityName) =>
      '$baseUrl/weather?q=$cityName&appid=${Constants.apiKey}&units=metric';

  static Future<Map<String, dynamic>> fetchData(String url) async {
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      rethrow;
    }
  }
}

import 'package:farmer_app/models/hourly_weather.dart';
import 'package:farmer_app/models/services/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weeklyWeatherProvider = FutureProvider.autoDispose((ref) {
  return ApiHelper.getWeeklyForecast();
});

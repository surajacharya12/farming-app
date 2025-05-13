import 'package:krishi_sathi/models/hourly_weather.dart';
import 'package:krishi_sathi/models/services/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hourlyWeatherProvider = FutureProvider.autoDispose((ref) {
  return ApiHelper.getHourlyForecast();
});

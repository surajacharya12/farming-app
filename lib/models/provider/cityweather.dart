import 'package:krishi_sathi/models/services/api.dart';
import 'package:krishi_sathi/models/weather.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherByCityProvider = FutureProvider.autoDispose
    .family<Weather, String>((ref, cityName) async {
      return ApiHelper.getWeatherByCity(cityName: cityName);
    });

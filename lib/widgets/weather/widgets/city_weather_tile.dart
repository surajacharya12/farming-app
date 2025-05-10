import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '../models/famous_city.dart';
import '../providers/get_city_forecast_provider.dart';
import '/utils/get_weather_icons.dart';

class CityWeatherTile extends ConsumerWidget {
  const CityWeatherTile({super.key, required this.city, required this.index});

  final FamousCity city;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(cityForecastProvider(city.name));

    return currentWeather.when(
      data: (weather) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
          ), // Reduce spacing between tiles
          child: Material(
            color: AppColors.accentBlue,

            elevation: index == 0 ? 8 : 0, // Slightly lower elevation
            borderRadius: BorderRadius.circular(
              18.0,
            ), // Slightly smaller corners
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 16,
              ), // Less vertical padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${weather.main.temp.round()}\u00B0',
                              style: TextStyles.h2.copyWith(
                                fontSize: 20,
                              ), // Smaller font
                            ),
                            const SizedBox(height: 4),
                            Text(
                              weather.weather[0].description,
                              style: TextStyles.subtitleText,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        getWeatherIcon(weatherCode: weather.weather[0].id),
                        width: 40, // Smaller icon
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    weather.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(.85),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

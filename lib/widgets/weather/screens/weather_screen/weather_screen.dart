import 'package:krishi_sathi/extensions/datetime.dart';
import 'package:krishi_sathi/widgets/weather/models/weather.dart';
import 'package:krishi_sathi/widgets/weather/screens/weather_screen/weather_info.dart';
import 'package:krishi_sathi/widgets/weather/views/gradient_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krishi_sathi/widgets/weather/providers/get_current_weather_provider.dart';
import '../../constants/text_styles.dart';
import '../../views/hourly_forecast_view.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(currentWeatherProvider);

    return weatherData.when(
      data: (weather) {
        return GradientContainer(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(weather.name, style: TextStyles.h1),
                const SizedBox(height: 20),
                Text(DateTime.now().dateTime), // Using extension on DateTime
                const SizedBox(height: 30),
                SizedBox(
                  height: 260,
                  child: Image.asset(
                    "assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png",
                  ),
                ),
                const SizedBox(height: 40),
                Text(weather.weather[0].description, style: TextStyles.h2),
              ],
            ),
            const SizedBox(height: 40),
            WeatherInfo(weather: weather),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("Today's Weather", style: TextStyles.h2)],
            ),
            const SizedBox(height: 20),
            const HourlyForecastView(),
          ],
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Color.fromARGB(255, 151, 34, 26)),
          ),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

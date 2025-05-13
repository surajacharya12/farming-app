import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/farmerDiscussion.dart';
import '../widgets/horizontalCalender.dart';
import '../widgets/weather/views/hourly_forecast_view.dart';

class BuildHomePage extends ConsumerWidget {
  const BuildHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String formattedDate =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 90),

            // Today's date row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today', style: Theme.of(context).textTheme.titleLarge),
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Horizontal calendar with horizontal scroll
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Horizontalcalender(),
              ),
            ),

            // Hourly forecast with horizontal scroll
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 260.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: HourlyForecastView(),
              ),
            ),

            const SizedBox(height: 20),

            // Farmer discussion
            const Farmerdiscussion(),
          ],
        ),
      ),
    );
  }
}

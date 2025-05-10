// This is the full working implementation that uses a search bar
// to dynamically show weather for any city input by the user,
// while still displaying the weather of famous cities below.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '../models/famous_city.dart';
import '../providers/get_city_forecast_provider.dart';
import '/utils/get_weather_icons.dart';
import '../views/famous_cities_weather.dart';
import '../widgets/city_weather_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _searchQuery;

  void _submitSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      setState(() {
        _searchQuery = query;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pick Location', style: TextStyles.h1),
              const SizedBox(height: 10),
              const Text(
                'Find the area or city that you want to know the detailed weather info at this time',
                style: TextStyles.subtitleText,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.accentBlue,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _searchController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search, color: AppColors.grey),
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(color: AppColors.grey),
                        ),
                        onSubmitted: (_) => _submitSearch(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _submitSearch,
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        color: AppColors.accentBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (_searchQuery != null && _searchQuery!.isNotEmpty)
                Expanded(
                  child: CityWeatherTile(
                    city: FamousCity(name: _searchQuery!, lat: 0, lon: 0),
                    index: 0,
                  ),
                )
              else
                const Expanded(child: FamousCitiesWeather()),
            ],
          ),
        ),
      ),
    );
  }
}

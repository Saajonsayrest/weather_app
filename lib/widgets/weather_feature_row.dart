import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/widgets/weather_feature.dart';

class WeatherFeaturesRow extends StatelessWidget {
  final Weather weather;

  const WeatherFeaturesRow({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WeatherFeatures(
          image: 'assets/11.png',
          title: ' Sunrise',
          time: DateFormat('').add_jm().format(weather.sunrise!),
        ),
        WeatherFeatures(
          image: 'assets/12.png',
          title: ' Sunset     ',
          time: DateFormat('').add_jm().format(weather.sunset!),
        ),
      ],
    );
  }
}

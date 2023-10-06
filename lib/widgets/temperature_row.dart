import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/widgets/weather_feature.dart';

class TemperatureRow extends StatelessWidget {
  final Weather weather;

  const TemperatureRow({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WeatherFeatures(
          image: 'assets/13.png',
          title: 'Temp Max.',
          temperature: '${weather.tempMax!.celsius!.round()}℃',
        ),
        WeatherFeatures(
          image: 'assets/14.png',
          title: 'Temp Min.',
          temperature: '${weather.tempMin!.celsius!.round()}℃',
        ),
      ],
    );
  }
}

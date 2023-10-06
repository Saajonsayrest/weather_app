import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/widgets/temperature_row.dart';
import 'package:weather_app/widgets/weather_feature_row.dart';

class WeatherInfoWidget extends StatelessWidget {
  final Weather weather;

  const WeatherInfoWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📍 ${weather.areaName}',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 8),
        Text(
          getGreeting(weather.date!.hour),
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Center(
            child: Image.asset(
                getWeatherIcon(weather.weatherConditionCode!, weather.date!,
                    weather.sunrise!, weather.sunset!),
                height: 300)),
        Center(
          child: Text(
            '${weather.temperature!.celsius!.round()}℃',
            style: const TextStyle(
                color: Colors.white, fontSize: 55, fontWeight: FontWeight.w600),
          ),
        ),
        Center(
          child: Text(
            weather.weatherMain!.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        Center(
          child: Text(
            DateFormat('EEEE dd  • ').add_jm().format(weather.date!),
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
          ),
        ),
        const SizedBox(height: 50),
        WeatherFeaturesRow(weather: weather),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Divider(
            color: Colors.grey,
            thickness: 0.4,
            indent: 10,
          ),
        ),
        TemperatureRow(weather: weather),
      ],
    );
  }

  String getWeatherIcon(
      int code, DateTime current, DateTime sunrise, DateTime sunset) {
    switch (code) {
      case > 200 && <= 300:
        return 'assets/1.png';
      case >= 300 && < 400:
        return 'assets/2.png';
      case >= 500 && < 600:
        return 'assets/3.png';
      case >= 600 && < 700:
        return 'assets/4.png';
      case >= 700 && < 800:
        return 'assets/5.png';
      case == 800:
        return current.isAfter(sunrise) && current.isBefore(sunset)
            ? 'assets/6.png'
            : 'assets/12.png';
      case > 800 && <= 804:
        return current.isAfter(sunrise) && current.isBefore(sunset)
            ? 'assets/7.png'
            : 'assets/15.png';

      default:
        return 'assets/7.png';
    }
  }

  String getGreeting(int hour) {
    if (hour >= 0 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}

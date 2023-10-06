import 'package:flutter/material.dart';

class WeatherFeatures extends StatelessWidget {
  final String image;
  final String title;
  final String? time;
  final String? temperature;

  const WeatherFeatures({
    super.key,
    required this.image,
    required this.title,
    this.time,
    this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          image,
          height: 40,
          width: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (time != null)
              Text(
                time!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            if (temperature != null)
              Text(
                temperature!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

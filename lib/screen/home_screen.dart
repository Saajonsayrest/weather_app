import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greeting = '';

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
      return greeting = 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return greeting = 'Good Afternoon';
    } else {
      return greeting = 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(width, 20),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepPurple),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.8),
                child: Container(
                  height: 300,
                  width: 500,
                  decoration: const BoxDecoration(color: Color(0xFFFFAB40)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 120, sigmaY: 120),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              BlocBuilder<WeatherBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SizedBox(
                      width: width,
                      height: height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '📍 ${state.weather.areaName}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            getGreeting(state.weather.date!.hour),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                          Center(
                              child: Image.asset(
                                  getWeatherIcon(
                                      state.weather.weatherConditionCode!,
                                      state.weather.date!,
                                      state.weather.sunrise!,
                                      state.weather.sunset!),
                                  height: 300)),
                          Center(
                            child: Text(
                              '${state.weather.temperature!.celsius!.round()}℃',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Center(
                            child: Text(
                              state.weather.weatherMain!.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Center(
                            child: Text(
                              DateFormat('EEEE dd  • ')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherFeatures(
                                image: 'assets/11.png',
                                title: ' Sunrise',
                                time: DateFormat('')
                                    .add_jm()
                                    .format(state.weather.sunrise!),
                              ),
                              WeatherFeatures(
                                image: 'assets/12.png',
                                title: ' Sunset     ',
                                time: DateFormat('')
                                    .add_jm()
                                    .format(state.weather.sunset!),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(
                              color: Colors.grey,
                              thickness: 0.4,
                              indent: 10,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherFeatures(
                                image: 'assets/13.png',
                                title: 'Temp Max.',
                                temperature:
                                    '${state.weather.tempMax!.celsius!.round().toString()}℃',
                              ),
                              WeatherFeatures(
                                image: 'assets/14.png',
                                title: 'Temp Min.',
                                temperature:
                                    '${state.weather.tempMin!.celsius!.round().toString()}℃',
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherFeatures extends StatelessWidget {
  const WeatherFeatures({
    super.key,
    required this.image,
    required this.title,
    this.time,
    this.temperature,
  });

  final String image;
  final String title;
  final String? time;
  final String? temperature;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Image.asset(image, scale: 8),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 3),
            Text(
              time ?? temperature ?? '',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

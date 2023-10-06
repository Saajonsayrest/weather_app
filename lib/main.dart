import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/screen/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _determinePosition(context),
        builder: (context, snap) {
          if (snap.hasData) {
            return BlocProvider<WeatherBloc>(
              create: (context) =>
                  WeatherBloc()..add(FetchWeather(snap.data as Position)),
              child: const HomeScreen(),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
        },
      ),
    );
  }
}

//Copy the entire determine Position fro Geolocator Documentation
Future<Position> _determinePosition(BuildContext context) async {
  var status = await Permission.location.request();

  if (status.isDenied) {
    // Permissions are denied, you can show a dialog or UI to
    // inform the user and request permissions again.
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Location Permission Required'),
        content: Text('Please grant location permission to use this app.'),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () async {
              Navigator.of(context).pop();
              status = await Permission.location.request();
            },
          ),
        ],
      ),
    );

    if (status.isDenied) {
      // Permissions are still denied, you can handle it accordingly.
      return Future.error('Location permissions are denied');
    }
  } else if (status.isPermanentlyDenied) {
    // Permissions are permanently denied, handle accordingly.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted, and you can continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

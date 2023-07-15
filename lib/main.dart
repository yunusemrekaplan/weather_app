import 'package:flutter/material.dart';
import 'package:weather_app/views/home_screen.dart';
import 'package:weather_app/views/main_screen.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/main': (context) => const MainScreen(),
        '/home': (context) => const HomeScreen(),
      },
      initialRoute: '/main',
    );
  }
}

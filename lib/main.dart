import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:open_weather_provider/providers/providers.dart';
import 'package:open_weather_provider/providers/weather/weather_provider.dart';
import 'package:open_weather_provider/repositories/geolocator_repository.dart';
import 'package:open_weather_provider/repositories/weather_repository.dart';
import 'package:open_weather_provider/services/weather_api_services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'pages/home_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherRepository>(
          create: (context) => WeatherRepository(
            weatherApiServices: WeatherApiServices(
              httpClient: http.Client(),
            ),
          ),
        ),
        Provider<GeolocationRepository>(
          create: (context) => GeolocationRepository(),
        ),
        // ChangeNotifierProvider<WeatherProvider>(
        //   create: (context) => WeatherProvider(
        //     weatherRepository: context.read<WeatherRepository>(),
        //   ),
        // ),
        StateNotifierProvider<WeatherProvider, WeatherState>(
          create: (context) => WeatherProvider(),
        ),
        // ChangeNotifierProvider<TempSettingsProvider>(
        //   create: (context) => TempSettingsProvider(),
        // ),
        StateNotifierProvider<TempSettingsProvider, TempSettingsState>(
          create: (context) => TempSettingsProvider(),
        ),
        // ChangeNotifierProxyProvider<WeatherProvider, ThemeProvider>(
        //   create: (context) => ThemeProvider(),
        //   update: ((context, value, previous) => previous!..update(value)),
        // ),
        // ProxyProvider<WeatherProvider, ThemeProvider>(
        //   update: (context, value, previous) => ThemeProvider(wp: value),
        // )
        StateNotifierProvider<ThemeProvider, ThemeState>(
          create: (context) => ThemeProvider(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: context.watch<ThemeState>().appTheme == AppTheme.light
            ? ThemeData.light()
            : ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}

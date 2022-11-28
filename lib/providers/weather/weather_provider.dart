import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_weather_provider/models/custom_error.dart';
import 'package:open_weather_provider/repositories/geolocator_repository.dart';
import 'package:open_weather_provider/repositories/weather_repository.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../models/weather.dart';

part 'weather_state.dart';

// class WeatherProvider with ChangeNotifier {
//   WeatherState _state = WeatherState.initial();
//   WeatherState get state => _state;

//   final WeatherRepository weatherRepository;
//   WeatherProvider({
//     required this.weatherRepository,
//   });

//   Future<void> fetchWeather(String city) async {
//     _state = _state.copyWith(status: WeatherStatus.loading);
//     notifyListeners();

//     try {
//       final Weather weather = await weatherRepository.fetchWeather(city);

//       _state = _state.copyWith(
//         status: WeatherStatus.loaded,
//         weather: weather,
//       );
//       print('state: $_state');
//       notifyListeners();
//     } on CustomError catch (e) {
//       _state = _state.copyWith(status: WeatherStatus.error, error: e);
//       print('state: $_state');
//       notifyListeners();
//     }
//   }
// }

class WeatherProvider extends StateNotifier<WeatherState> with LocatorMixin {
  WeatherProvider() : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    state = state.copyWith(status: WeatherStatus.loading);

    try {
      final Weather weather =
          await read<WeatherRepository>().fetchWeather(city);

      state = state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      );
      print('state: $state');
    } on CustomError catch (e) {
      state = state.copyWith(status: WeatherStatus.error, error: e);
      print('state: $state');
    }
  }

  Future<void> fetchWeatherByGeolocator() async {
    try {
      final Position position =
          await read<GeolocationRepository>().determinePosition();
      final Weather weather =
          await read<WeatherRepository>().fetchWeatherByGeolocator(position);
      state = state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      );
      print('state: $state');
    } on CustomError catch (e) {
      state = state.copyWith(status: WeatherStatus.error, error: e);
      print('state: $state');
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:open_weather_provider/constants/contants.dart';
import 'package:open_weather_provider/providers/providers.dart';
import 'package:state_notifier/state_notifier.dart';

part 'theme_state.dart';

// class ThemeProvider with ChangeNotifier {
//   ThemeState _state = ThemeState.initial();
//   ThemeState get state => _state;

//   void update(WeatherProvider wp) {
//     if (wp.state.weather.temp > kWarmOrNot) {
//       _state = state.copyWith(appTheme: AppTheme.light);
//     } else {
//       _state = state.copyWith(appTheme: AppTheme.dark);
//     }

//     notifyListeners();
//   }
// }

/**
 * ProxyProvider
 */
// class ThemeProvider {
//   final WeatherProvider wp;
//   ThemeProvider({
//     required this.wp,
//   });

//   ThemeState get state {
//     if (wp.state.weather.temp > kWarmOrNot) {
//       return ThemeState();
//     } else {
//       return ThemeState(appTheme: AppTheme.dark);
//     }
//   }
// }

/**
 * StateNotifier
 */
class ThemeProvider extends StateNotifier<ThemeState> with LocatorMixin {
  ThemeProvider() : super(ThemeState.initial());

  @override
  void update(Locator watch) {
    final wp = watch<WeatherState>().weather;

    if (wp.temp > kWarmOrNot) {
      state = state.copyWith(appTheme: AppTheme.light);
    } else {
      state = state.copyWith(appTheme: AppTheme.dark);
    }
  }
}

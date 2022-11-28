import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:state_notifier/state_notifier.dart';

part 'temp_settings_state.dart';

// class TempSettingsProvider with ChangeNotifier {
//   TempSettingsState _state = TempSettingsState.initial();
//   TempSettingsState get state => _state;

//   void toggleTempUnit() {
//     _state = _state.copyWith(
//       tempUnit: _state.tempUnit == TempUnit.celsius
//           ? TempUnit.fahrenheit
//           : TempUnit.celsius,
//     );
//     print('temp unit: $_state');
//     notifyListeners();
//   }
// }

class TempSettingsProvider extends StateNotifier<TempSettingsState> {
  TempSettingsProvider() : super(TempSettingsState.initial());

  void toggleTempUnit() {
    state = state.copyWith(
      tempUnit: state.tempUnit == TempUnit.celsius
          ? TempUnit.fahrenheit
          : TempUnit.celsius,
    );
    print('temp unit: $state');
  }
}

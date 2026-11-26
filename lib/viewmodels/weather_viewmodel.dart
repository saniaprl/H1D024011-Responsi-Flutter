import 'package:flutter/foundation.dart';

import '../core/view_state.dart';
import '../models/location_model.dart';
import '../models/weather_model.dart';
import '../repositories/weather_repository.dart';

class WeatherViewModel extends ChangeNotifier {
  WeatherViewModel(this.repository);
  final WeatherRepository repository;
  ViewState state = ViewState.idle;
  WeatherModel? weather;
  String? errorMessage;
  bool isRefreshing = false;
  Future<void> load(LocationModel location, {bool refresh = false}) async {
    state = ViewState.loading;
    isRefreshing = refresh;
    errorMessage = null;
    weather = null;
    notifyListeners();
    try {
      weather = await repository.fetch(location);
      state = ViewState.success;
    } catch (_) {
      state = ViewState.error;
      errorMessage =
          'Cuaca tidak dapat dimuat. Periksa koneksi lalu coba lagi.';
    } finally {
      isRefreshing = false;
      notifyListeners();
    }
  }
}

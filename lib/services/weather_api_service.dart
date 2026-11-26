import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/location_model.dart';
import '../models/weather_model.dart';

class WeatherApiService {
  WeatherApiService({http.Client? client}) : _client = client ?? http.Client();
  final http.Client _client;
  Future<WeatherModel> fetch(LocationModel location) async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '${location.latitude}',
      'longitude': '${location.longitude}',
      'current': 'temperature_2m,relative_humidity_2m,apparent_temperature,precipitation,weather_code,wind_speed_10m',
      'daily': 'temperature_2m_max,temperature_2m_min,precipitation_probability_max,weather_code',
      'timezone': 'auto',
      'forecast_days': '7',
      'temperature_unit': 'celsius',
      'wind_speed_unit': 'kmh',
      'precipitation_unit': 'mm',
    });
    final response = await _client
        .get(uri)
        .timeout(const Duration(seconds: 12));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Server cuaca mengembalikan ${response.statusCode}.');
    }
    return WeatherModel.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
      location,
    );
  }

  void dispose() => _client.close();
}

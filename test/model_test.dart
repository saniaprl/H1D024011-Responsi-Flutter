import 'package:flutter_test/flutter_test.dart';
import 'package:meteora/models/location_model.dart';
import 'package:meteora/models/weather_model.dart';

void main() {
  test('mem-parsing cuaca dan prakiraan berdasarkan indeks harian', () {
    final weather = WeatherModel.fromJson(
      {
        'timezone': 'Asia/Jakarta',
        'current': {
          'temperature_2m': 30,
          'relative_humidity_2m': 70,
          'apparent_temperature': 32.5,
          'precipitation': 0.2,
          'weather_code': 1,
          'wind_speed_10m': 12,
        },
        'daily': {
          'time': ['2026-11-25', '2026-11-26'],
          'temperature_2m_max': [32, 33],
          'temperature_2m_min': [24, 25],
          'precipitation_probability_max': [20, null],
          'weather_code': [1, 61],
        },
      },
      const LocationModel(
        id: 1,
        name: 'Jakarta',
        latitude: -6.2,
        longitude: 106.8,
      ),
    );
    expect(weather.current.temperature, 30);
    expect(weather.daily, hasLength(2));
    expect(weather.daily[1].rainProbability, isNull);
    expect(weather.daily[1].weatherCode, 61);
  });

  test('lokasi memakai id sebagai identitas', () {
    const a = LocationModel(id: 1, name: 'A', latitude: 0, longitude: 0);
    const b = LocationModel(
      id: 1,
      name: 'Nama berbeda',
      latitude: 2,
      longitude: 2,
    );
    expect(a, equals(b));
  });
}

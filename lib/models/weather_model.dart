import 'current_weather_model.dart';
import 'daily_forecast_model.dart';
import 'location_model.dart';

class WeatherModel {
  const WeatherModel({
    required this.location,
    required this.current,
    required this.daily,
    this.timezone,
  });
  final LocationModel location;
  final CurrentWeatherModel current;
  final List<DailyForecastModel> daily;
  final String? timezone;

  factory WeatherModel.fromJson(
    Map<String, dynamic> json,
    LocationModel location,
  ) {
    final currentJson =
        (json['current'] as Map?)?.cast<String, dynamic>() ?? {};
    final daily = (json['daily'] as Map?)?.cast<String, dynamic>() ?? {};
    final dates = (daily['time'] as List?) ?? const [];
    final max = (daily['temperature_2m_max'] as List?) ?? const [];
    final min = (daily['temperature_2m_min'] as List?) ?? const [];
    final rain = (daily['precipitation_probability_max'] as List?) ?? const [];
    final codes = (daily['weather_code'] as List?) ?? const [];
    final count = [
      dates.length,
      max.length,
      min.length,
      rain.length,
      codes.length,
    ].reduce((a, b) => a < b ? a : b);
    final forecasts = <DailyForecastModel>[];
    for (var i = 0; i < count; i++) {
      final parsedDate = DateTime.tryParse('${dates[i]}');
      if (parsedDate != null) {
        forecasts.add(
          DailyForecastModel(
            date: parsedDate,
            maxTemperature: (max[i] as num?)?.toDouble(),
            minTemperature: (min[i] as num?)?.toDouble(),
            rainProbability: (rain[i] as num?)?.toInt(),
            weatherCode: (codes[i] as num?)?.toInt(),
          ),
        );
      }
    }
    return WeatherModel(
      location: location,
      current: CurrentWeatherModel.fromJson(currentJson),
      daily: forecasts,
      timezone: json['timezone'] as String?,
    );
  }
}

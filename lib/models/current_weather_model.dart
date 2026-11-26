class CurrentWeatherModel {
  const CurrentWeatherModel({
    this.temperature,
    this.humidity,
    this.apparentTemperature,
    this.precipitation,
    this.weatherCode,
    this.windSpeed,
  });
  final double? temperature;
  final int? humidity;
  final double? apparentTemperature;
  final double? precipitation;
  final int? weatherCode;
  final double? windSpeed;
  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherModel(
        temperature: (json['temperature_2m'] as num?)?.toDouble(),
        humidity: (json['relative_humidity_2m'] as num?)?.toInt(),
        apparentTemperature: (json['apparent_temperature'] as num?)?.toDouble(),
        precipitation: (json['precipitation'] as num?)?.toDouble(),
        weatherCode: (json['weather_code'] as num?)?.toInt(),
        windSpeed: (json['wind_speed_10m'] as num?)?.toDouble(),
      );
}

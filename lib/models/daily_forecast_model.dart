class DailyForecastModel {
  const DailyForecastModel({
    required this.date,
    this.maxTemperature,
    this.minTemperature,
    this.rainProbability,
    this.weatherCode,
  });
  final DateTime date;
  final double? maxTemperature;
  final double? minTemperature;
  final int? rainProbability;
  final int? weatherCode;
}

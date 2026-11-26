import 'package:flutter/material.dart';

import '../core/weather_code_mapper.dart';
import '../models/daily_forecast_model.dart';

class ForecastCard extends StatelessWidget {
  const ForecastCard({super.key, required this.forecast});
  final DailyForecastModel forecast;
  @override
  Widget build(BuildContext context) {
    final info = weatherCodeInfo(forecast.weatherCode);
    return Container(
      width: 132,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _date(forecast.date),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Icon(info.icon, color: info.color, size: 30),
          const SizedBox(height: 8),
          Text(
            '${_value(forecast.maxTemperature)}° / ${_value(forecast.minTemperature)}°',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 5),
          Text(
            'Hujan ${forecast.rainProbability == null ? '—' : '${forecast.rainProbability}%'}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  String _value(double? value) =>
      value == null ? '—' : value.toStringAsFixed(0);
  String _date(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
}

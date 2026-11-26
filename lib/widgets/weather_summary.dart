import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../core/weather_code_mapper.dart';
import '../models/weather_model.dart';

class WeatherSummary extends StatelessWidget {
  const WeatherSummary({
    super.key,
    required this.weather,
    required this.favorite,
    required this.onFavorite,
  });
  final WeatherModel weather;
  final bool favorite;
  final VoidCallback onFavorite;
  @override
  Widget build(BuildContext context) {
    final info = weatherCodeInfo(weather.current.weatherCode);
    final temp = weather.current.temperature;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  weather.location.name,
                  style: const TextStyle(
                    color: AppColors.surface,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              IconButton(
                onPressed: onFavorite,
                color: AppColors.surface,
                icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
              ),
            ],
          ),
          if (weather.location.subtitle.isNotEmpty)
            Text(
              weather.location.subtitle,
              style: const TextStyle(color: AppColors.surfaceVariant),
            ),
          const SizedBox(height: 18),
          Row(
            children: [
              Icon(info.icon, color: AppColors.surface, size: 58),
              const SizedBox(width: 14),
              Text(
                temp == null ? 'Tidak tersedia' : '${temp.toStringAsFixed(0)}°',
                style: const TextStyle(
                  color: AppColors.surface,
                  fontSize: 58,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                info.label,
                style: const TextStyle(
                  color: AppColors.surface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Diperbarui dari Open-Meteo • ${weather.timezone ?? 'waktu lokal'}',
            style: const TextStyle(
              color: AppColors.surfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

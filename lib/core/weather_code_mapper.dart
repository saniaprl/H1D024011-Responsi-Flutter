import 'package:flutter/material.dart';

import 'app_colors.dart';

class WeatherCodeInfo {
  const WeatherCodeInfo(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

WeatherCodeInfo weatherCodeInfo(int? code) {
  if (code == null) {
    return const WeatherCodeInfo(
      'Tidak tersedia',
      Icons.help_outline,
      AppColors.cloudy,
    );
  }
  if (code == 0) {
    return const WeatherCodeInfo(
      'Cerah',
      Icons.wb_sunny_outlined,
      AppColors.sunny,
    );
  }
  if ([1, 2].contains(code)) {
    return const WeatherCodeInfo(
      'Cerah berawan',
      Icons.wb_cloudy_outlined,
      AppColors.sunny,
    );
  }
  if (code == 3) {
    return const WeatherCodeInfo(
      'Berawan',
      Icons.cloud_outlined,
      AppColors.cloudy,
    );
  }
  if ([45, 48].contains(code)) {
    return const WeatherCodeInfo('Berkabut', Icons.foggy, AppColors.cloudy);
  }
  if ([51, 53, 55, 56, 57].contains(code)) {
    return const WeatherCodeInfo('Gerimis', Icons.grain, AppColors.rainy);
  }
  if ([61, 63, 65, 66, 67, 80, 81, 82].contains(code)) {
    return const WeatherCodeInfo(
      'Hujan',
      Icons.water_drop_outlined,
      AppColors.rainy,
    );
  }
  if ([71, 73, 75, 77, 85, 86].contains(code)) {
    return const WeatherCodeInfo('Salju', Icons.ac_unit, AppColors.info);
  }
  if ([95, 96, 99].contains(code)) {
    return const WeatherCodeInfo(
      'Badai petir',
      Icons.thunderstorm_outlined,
      AppColors.primaryDark,
    );
  }
  return const WeatherCodeInfo(
    'Kondisi tidak dikenal',
    Icons.cloud_outlined,
    AppColors.cloudy,
  );
}

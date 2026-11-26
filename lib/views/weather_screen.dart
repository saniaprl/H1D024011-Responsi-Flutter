import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/view_state.dart';
import '../core/theme_view_model.dart';
import '../viewmodels/location_viewmodel.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../widgets/forecast_card.dart';
import '../widgets/state_message.dart';
import '../widgets/weather_detail_card.dart';
import '../widgets/weather_summary.dart';
import 'search_screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool _started = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started) {
      _started = true;
      final location = context.read<LocationViewModel>().lastLocation;
      if (location != null) context.read<WeatherViewModel>().load(location);
    }
  }

  Future<void> _openSearch() async {
    final locationViewModel = context.read<LocationViewModel>();
    final weatherViewModel = context.read<WeatherViewModel>();
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SearchScreen()),
    );
    if (!mounted) return;
    final location = locationViewModel.lastLocation;
    if (location != null) {
      weatherViewModel.load(location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        title: Image.asset(
          'assets/images/meteora_wordmark.png',
          width: 132,
          height: 36,
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
        ),
        actions: [
          Builder(
            builder: (context) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return IconButton(
                onPressed: () => context.read<ThemeViewModel>().toggle(
                  Theme.of(context).brightness,
                ),
                icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                tooltip: isDark ? 'Gunakan mode terang' : 'Gunakan mode gelap',
              );
            },
          ),
          IconButton(
            onPressed: _openSearch,
            icon: const Icon(Icons.search),
            tooltip: 'Cari lokasi',
          ),
        ],
      ),
      body: Consumer2<LocationViewModel, WeatherViewModel>(
        builder: (context, locations, weatherVm, _) {
          final location = locations.lastLocation;
          if (location == null) {
            return StateMessage(
              icon: Icons.location_searching,
              title: 'Pilih lokasi terlebih dahulu',
              message:
                  'Cari kota untuk melihat cuaca real-time dari Open-Meteo.',
              onRetry: _openSearch,
            );
          }
          if (weatherVm.state == ViewState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (weatherVm.state == ViewState.error || weatherVm.weather == null) {
            return StateMessage(
              icon: Icons.cloud_off,
              title: 'Gagal memuat cuaca',
              message: weatherVm.errorMessage ?? 'Terjadi kesalahan.',
              onRetry: () => weatherVm.load(location),
            );
          }
          final data = weatherVm.weather!;
          final current = data.current;
          return RefreshIndicator(
            onRefresh: () => weatherVm.load(location, refresh: true),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
              children: [
                WeatherSummary(
                  weather: data,
                  favorite: locations.isFavorite(location),
                  onFavorite: () => locations.toggleFavorite(location),
                ),
                const SizedBox(height: 16),
                Text(
                  'Detail cuaca',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = (constraints.maxWidth - 12) / 2;
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        SizedBox(
                          width: width,
                          child: WeatherDetailCard(
                            icon: Icons.thermostat,
                            label: 'Terasa seperti',
                            value: _number(current.apparentTemperature, '°C'),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: WeatherDetailCard(
                            icon: Icons.water_drop_outlined,
                            label: 'Kelembapan',
                            value: _number(current.humidity, '%'),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: WeatherDetailCard(
                            icon: Icons.umbrella_outlined,
                            label: 'Curah hujan',
                            value: _number(current.precipitation, ' mm'),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: WeatherDetailCard(
                            icon: Icons.air,
                            label: 'Kecepatan angin',
                            value: _number(current.windSpeed, ' km/jam'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 22),
                Text(
                  'Prakiraan 7 hari',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 155,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.daily.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (_, index) =>
                        ForecastCard(forecast: data.daily[index]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _number(Object? value, String suffix) => value == null
      ? 'Tidak tersedia'
      : '${value is double ? value.toStringAsFixed(1) : value}$suffix';
}

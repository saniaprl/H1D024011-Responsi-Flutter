import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app_theme.dart';
import 'core/theme_view_model.dart';
import 'repositories/location_repository.dart';
import 'repositories/weather_repository.dart';
import 'services/geocoding_api_service.dart';
import 'services/local_storage_service.dart';
import 'services/weather_api_service.dart';
import 'viewmodels/location_viewmodel.dart';
import 'viewmodels/weather_viewmodel.dart';
import 'views/weather_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final storage = LocalStorageService(preferences);
  final locationVm = LocationViewModel(
    LocationRepository(GeocodingApiService()),
    storage,
  );
  await locationVm.initialize();
  final themeVm = ThemeViewModel(preferences);
  runApp(MeteoraApp(locationVm: locationVm, themeVm: themeVm));
}

class MeteoraApp extends StatelessWidget {
  const MeteoraApp({
    super.key,
    required this.locationVm,
    required this.themeVm,
  });
  final LocationViewModel locationVm;
  final ThemeViewModel themeVm;
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: locationVm),
      ChangeNotifierProvider.value(value: themeVm),
      ChangeNotifierProvider(
        create: (_) => WeatherViewModel(WeatherRepository(WeatherApiService())),
      ),
    ],
    child: Consumer<ThemeViewModel>(
      builder: (context, theme, _) => MaterialApp(
        title: 'Meteora',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        darkTheme: AppTheme.darkTheme,
        themeMode: theme.mode,
        home: const WeatherScreen(),
      ),
    ),
  );
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/location_model.dart';

class LocalStorageService {
  LocalStorageService(this._preferences);
  final SharedPreferences _preferences;
  static const _favoritesKey = 'favorite_locations';
  static const _lastKey = 'last_selected_location';

  List<LocationModel> readFavorites() {
    try {
      final raw = _preferences.getString(_favoritesKey);
      if (raw == null) return [];
      final list = jsonDecode(raw) as List;
      return list
          .map(
            (item) =>
                LocationModel.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveFavorites(List<LocationModel> locations) =>
      _preferences.setString(
        _favoritesKey,
        jsonEncode(locations.map((e) => e.toJson()).toList()),
      );
  LocationModel? readLastLocation() {
    try {
      final raw = _preferences.getString(_lastKey);
      return raw == null ? null : LocationModel.fromJson(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLastLocation(LocationModel location) =>
      _preferences.setString(_lastKey, jsonEncode(location.toJson()));
}

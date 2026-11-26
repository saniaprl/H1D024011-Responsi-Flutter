import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/view_state.dart';
import '../models/location_model.dart';
import '../repositories/location_repository.dart';
import '../services/local_storage_service.dart';

class LocationViewModel extends ChangeNotifier {
  LocationViewModel(this.repository, this.storage);
  final LocationRepository repository;
  final LocalStorageService storage;
  ViewState searchState = ViewState.idle;
  String? errorMessage;
  List<LocationModel> results = [];
  List<LocationModel> favorites = [];
  LocationModel? lastLocation;
  int _requestId = 0;

  Future<void> initialize() async {
    favorites = storage.readFavorites();
    lastLocation = storage.readLastLocation();
    notifyListeners();
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      searchState = ViewState.idle;
      results = [];
      errorMessage = null;
      notifyListeners();
      return;
    }
    final request = ++_requestId;
    searchState = ViewState.loading;
    errorMessage = null;
    notifyListeners();
    try {
      final found = await repository.search(trimmed);
      if (request != _requestId) return;
      results = found;
      searchState = found.isEmpty ? ViewState.empty : ViewState.success;
    } catch (error) {
      if (request != _requestId) return;
      errorMessage = 'Pencarian gagal. Periksa koneksi lalu coba lagi.';
      searchState = ViewState.error;
    }
    notifyListeners();
  }

  bool isFavorite(LocationModel location) =>
      favorites.any((item) => item.id == location.id);
  Future<void> toggleFavorite(LocationModel location) async {
    if (isFavorite(location)) {
      favorites.removeWhere((item) => item.id == location.id);
    } else {
      favorites = [...favorites, location];
    }
    await storage.saveFavorites(favorites);
    notifyListeners();
  }

  Future<void> selectLocation(LocationModel location) async {
    lastLocation = location;
    await storage.saveLastLocation(location);
    notifyListeners();
  }
}

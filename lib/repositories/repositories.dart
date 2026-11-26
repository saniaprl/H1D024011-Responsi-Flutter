import '../models/location_model.dart';
import '../models/weather_model.dart';
import '../services/geocoding_api_service.dart';
import '../services/weather_api_service.dart';

class LocationRepository {
  LocationRepository(this.service);
  final GeocodingApiService service;
  Future<List<LocationModel>> search(String query) => service.search(query);
}

class WeatherRepository {
  WeatherRepository(this.service);
  final WeatherApiService service;
  Future<WeatherModel> fetch(LocationModel location) => service.fetch(location);
}

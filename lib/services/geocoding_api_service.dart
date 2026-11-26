import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/location_model.dart';

class GeocodingApiService {
  GeocodingApiService({http.Client? client})
    : _client = client ?? http.Client();
  final http.Client _client;
  Future<List<LocationModel>> search(String name) async {
    final uri = Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
      'name': name,
      'count': '10',
      'language': 'id',
      'format': 'json',
    });
    final response = await _client
        .get(uri)
        .timeout(const Duration(seconds: 12));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Server pencarian mengembalikan ${response.statusCode}.');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final results = json['results'];
    if (results is! List) return [];
    return results
        .map(
          (item) =>
              LocationModel.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }

  void dispose() => _client.close();
}

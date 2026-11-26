class LocationModel {
  const LocationModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.admin1,
    this.country,
  });
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String? admin1;
  final String? country;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    id: (json['id'] as num).toInt(),
    name: json['name'] as String? ?? 'Lokasi tidak dikenal',
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    admin1: json['admin1'] as String?,
    country: json['country'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
    'admin1': admin1,
    'country': country,
  };
  String get subtitle => [
    admin1,
    country,
  ].where((item) => item != null && item.isNotEmpty).join(', ');
  @override
  bool operator ==(Object other) => other is LocationModel && other.id == id;
  @override
  int get hashCode => id.hashCode;
}

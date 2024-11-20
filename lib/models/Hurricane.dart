// Definir la estructura de datos de un huracán

class Hurricane {
  final String id;
  final String name;
  final String category;
  final double latitude;
  final double longitude;
  final double windSpeed;
  final double startDate;
  final double endDate;
  final double coordinates;
  final double pressure;
  final String description;

  Hurricane({
    required this.id,
    required this.name,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.windSpeed,
    required this.startDate,
    required this.endDate,
    required this.coordinates,
    required this.pressure,
    required this.description,
  });

  factory Hurricane.fromJson(Map<String, dynamic> json) {
    return Hurricane(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      windSpeed: json['windSpeed'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      coordinates: json['coordinates'],
      pressure: json['pressure'],
      description: json['description'],
    );
  }
}

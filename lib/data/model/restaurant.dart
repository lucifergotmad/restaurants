
import 'package:floor/floor.dart';

@entity
class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  @primaryKey
  final String id;
  final String name;
  final String description;
  final String city;
  final String pictureId;
  final double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "pictureId": pictureId,
        "rating": rating,
      };
}

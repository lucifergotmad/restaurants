import 'package:restaurants/model/menu.dart';

import 'dart:convert';

List<Restaurant> restaurantFromJson(String? str) {
  if (str == null) {
    return [];
  } else {
    return List<Restaurant>.from(
        json.decode(str).map((x) => Restaurant.fromJson(x)));
  }
}

String restaurantToJson(List<Restaurant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
        menus: Menus.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
      };
}

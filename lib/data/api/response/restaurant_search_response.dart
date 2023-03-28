import 'package:restaurants/data/model/restaurant.dart';

class RestaurantSearchResponse {
  RestaurantSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map(
            (x) => Restaurant.fromJson(x),
          ),
        ),
      );
}

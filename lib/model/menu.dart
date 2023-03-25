import 'package:restaurants/model/food.dart';

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Food> foods;
  final List<Food> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
        drinks: List<Food>.from(json["drinks"].map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}

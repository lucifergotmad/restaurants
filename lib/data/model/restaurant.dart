import 'package:restaurants/data/model/category.dart';
import 'package:restaurants/data/model/customer_review.dart';
import 'package:restaurants/data/model/menu.dart';

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.categories,
    this.menus,
    this.address,
    this.customerReviews,
  });

  final String id;
  final String name;
  final String description;
  final String city;
  final String pictureId;
  final double rating;
  final String? address;
  final List<Category>? categories;
  final Menus? menus;
  final List<CustomerReview>? customerReviews;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"]?.map((x) => Category.fromJson(x)))
            : null,
        menus: json["menus"] != null ? Menus.fromJson(json["menus"]) : null,
        customerReviews: json["customerReviews"] != null
            ? List<CustomerReview>.from(
                json["customerReviews"]?.map((x) => CustomerReview.fromJson(x)))
            : null,
      );
}

import 'package:restaurants/data/api/response/restaurant_detail_response.dart';
import 'package:restaurants/data/api/response/restaurant_search_response.dart';
import 'package:restaurants/data/api/response/restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestaurantResponse> getListRestaurant() async {
    final response = await http.get(Uri.parse("$baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load list restaurant!");
    }
  }

  Future<RestaurantDetailResponse> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load detail restaurant!");
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load searched restaurant!");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/api/response/restaurant_detail_response.dart';
import 'package:restaurants/data/db/database.dart';
import 'package:restaurants/data/db/restaurant_dao.dart';
import 'package:restaurants/data/model/restaurant.dart';
import 'package:restaurants/data/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final AppDatabase database;
  final String id;

  RestaurantDetailProvider({
    required this.apiService,
    required this.id,
    required this.database,
  }) {
    restaurantDAO = database.restaurantDAO;
    _fetchDetailRestaurant(id);
    _checkIsRestaurantFavorite(id);
  }

  late final RestaurantDAO restaurantDAO;
  late RestaurantDetailResponse _restaurantResponse;
  late ResultState _state;
  String _message = '';
  bool _isFavorite = false;

  String get message => _message;

  bool get isFavorite => _isFavorite;

  RestaurantDetailResponse get response => _restaurantResponse;

  ResultState get state => _state;

  void _checkIsRestaurantFavorite(String id) async {
    final restaurant = restaurantDAO.getRestaurantById(id);

    restaurant.listen((event) {
      if (event != null) {
        _isFavorite = true;
      } else {
        _isFavorite = false;
      }
      notifyListeners();
    });
  }

  void toggleFavorite() async {
    final restaurant = Restaurant(
      id: response.restaurant.id,
      city: response.restaurant.city,
      description: response.restaurant.description,
      name: response.restaurant.name,
      pictureId: response.restaurant.pictureId,
      rating: response.restaurant.rating,
    );

    if (_isFavorite) {
      restaurantDAO.deleteRestaurant(restaurant);
    } else {
      restaurantDAO.insertRestaurant(restaurant);
    }
  }

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurants = await apiService.getDetailRestaurant(id);
      if (restaurants.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "No data found";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResponse = restaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: ($e)';
    }
  }
}

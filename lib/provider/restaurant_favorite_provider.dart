import 'package:flutter/material.dart';
import 'package:restaurants/data/db/database.dart';
import 'package:restaurants/data/db/restaurant_dao.dart';
import 'package:restaurants/data/model/restaurant.dart';
import 'package:restaurants/data/result_state.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  final AppDatabase database;

  RestaurantFavoriteProvider({required this.database}) {
    restaurantDAO = database.restaurantDAO;
    _fetchFavoriteRestaurant();
  }

  late final RestaurantDAO restaurantDAO;

  late List<Restaurant> _restaurantResponse;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  List<Restaurant> get response => _restaurantResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchFavoriteRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurants = restaurantDAO.getAllRestaurant();

      restaurants.listen((event) {
        if (event.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          _message = "No data found";
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          _restaurantResponse = event;
        }
      });

      return _message.isEmpty ? _restaurantResponse: _message;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: ($e)';
    }
  }
}

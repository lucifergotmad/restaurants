import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/api/response/restaurant_response.dart';
import 'package:restaurants/data/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantResponse _restaurantResponse;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantResponse get response => _restaurantResponse;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurants = await apiService.getListRestaurant();
      if (restaurants.count < 1) {
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

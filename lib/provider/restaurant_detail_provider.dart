import 'package:flutter/material.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/api/response/restaurant_detail_response.dart';
import 'package:restaurants/data/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant(id);
  }

  late RestaurantDetailResponse _restaurantResponse;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResponse get response => _restaurantResponse;

  ResultState get state => _state;

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

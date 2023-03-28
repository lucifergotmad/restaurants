import 'package:flutter/cupertino.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/api/response/restaurant_search_response.dart';
import 'package:restaurants/data/result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchResponse _restaurantResponse;
  ResultState _state = ResultState.noData;
  String _query = '';
  String _message = '';

  RestaurantSearchResponse get restaurantResponse => _restaurantResponse;

  ResultState get state => _state;

  String get query => _query;

  String get message => _message;

  void updateQuery(String query) {
    _query = query;
  }

  Future<dynamic> searchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurants = await apiService.searchRestaurant(query);
      print("searchRestaurant: $restaurants");
      if (restaurants.founded < 1) {
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

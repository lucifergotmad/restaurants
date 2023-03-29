import 'package:floor/floor.dart';
import 'package:restaurants/data/model/restaurant.dart';

@dao
abstract class RestaurantDAO {
  @Query("SELECT * FROM Restaurant")
  Stream<List<Restaurant>> getAllRestaurant();

  @Query("SELECT * FROM Restaurant WHERE id = :id")
  Stream<Restaurant?> getRestaurantById(String id);

  @insert
  Future<void> insertRestaurant(Restaurant restaurant);

  @delete
  Future<void> deleteRestaurant(Restaurant restaurant);
}

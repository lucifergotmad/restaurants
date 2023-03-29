import 'dart:async';
import 'package:floor/floor.dart';
import 'package:restaurants/data/db/restaurant_dao.dart';
import 'package:restaurants/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Restaurant])
abstract class AppDatabase extends FloorDatabase {
  RestaurantDAO get restaurantDAO;
}

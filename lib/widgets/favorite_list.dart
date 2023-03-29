import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/result_state.dart';
import 'package:restaurants/data/model/restaurant.dart';
import 'package:restaurants/provider/restaurant_favorite_provider.dart';
import 'package:restaurants/widgets/card_item.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantFavoriteProvider>(
        builder: (context, snapshot, _) {
      if (snapshot.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.state == ResultState.hasData) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final Restaurant restaurant = snapshot.response[index];
            return CardItem(restaurant: restaurant);
          },
          itemCount: snapshot.response.length,
        );
      } else if (snapshot.state == ResultState.noData) {
        return Center(
          child: Text(snapshot.message),
        );
      } else if (snapshot.state == ResultState.error) {
        return Center(
          child: Text(snapshot.message),
        );
      } else {
        return const Center(
          child: Text(''),
        );
      }
    });
  }
}

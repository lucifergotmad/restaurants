import 'package:flutter/material.dart';
import 'package:restaurants/generated/assets.dart';
import 'package:restaurants/model/restaurant.dart';
import 'package:restaurants/widgets/card_item.dart';

class CardList extends StatelessWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString(Assets.assetsLocalRestaurant),
        builder: (context, snapshot) {
          final List<Restaurant> listRestaurant =
              restaurantFromJson(snapshot.data);

          return ListView.builder(
            itemBuilder: (context, index) {
              final Restaurant restaurant = listRestaurant[index];
              return CardItem(restaurant: restaurant);
            },
            itemCount: listRestaurant.length,
          );
        });
  }
}

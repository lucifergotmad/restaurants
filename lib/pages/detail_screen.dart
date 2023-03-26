import 'package:flutter/material.dart';
import 'package:restaurants/model/restaurant.dart';
import 'package:restaurants/widgets/food_list.dart';

class DetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const DetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          restaurant.city,
                          style: Theme.of(context).textTheme.labelLarge,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "(${restaurant.rating.toString()})",
                          style: Theme.of(context).textTheme.labelLarge,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  restaurant.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                FoodList(
                  foods: restaurant.menus.foods,
                  labelText: "Foods",
                ),
                const SizedBox(
                  height: 16,
                ),
                FoodList(
                  foods: restaurant.menus.drinks,
                  labelText: "Drinks",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

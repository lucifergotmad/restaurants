import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/result_state.dart';
import 'package:restaurants/generated/assets.dart';
import 'package:restaurants/provider/restaurant_detail_provider.dart';
import 'package:restaurants/widgets/food_list.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detail";

  final String id;
  final bool isOnline;

  const DetailScreen({Key? key, required this.id, required this.isOnline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, snapshot, _) {
        return Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8),
            child: FloatingActionButton(
              onPressed: () {
                snapshot.toggleFavorite();
              },
              child: snapshot.isFavorite
                  ? const Icon(
                      Icons.favorite,
                    )
                  : const Icon(
                      Icons.favorite_border,
                    ),
            ),
          ),
          body: Consumer<RestaurantDetailProvider>(
            builder: (context, snapshot, _) {
              if (snapshot.state == ResultState.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.state == ResultState.hasData) {
                return NestedScrollView(
                  headerSliverBuilder: (context, isScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 200,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Image.network(
                              "${ApiService.baseUrl}/images/medium/${snapshot.response.restaurant.pictureId}",
                              fit: BoxFit.cover, errorBuilder: (
                            BuildContext context,
                            Object exception,
                            StackTrace? stackTrace,
                          ) {
                            return Image.asset(
                              Assets.imagesError,
                              fit: BoxFit.cover,
                            );
                          }),
                        ),
                      )
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.response.restaurant.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.black54,
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.response.restaurant.city,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      Text(
                                        snapshot.response.restaurant.address,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )
                                    ],
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
                                    "(${snapshot.response.restaurant.rating.toString()})",
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.response.restaurant.description,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Menu",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FoodList(
                            foods: snapshot.response.restaurant.menus.foods,
                            labelText: "Foods",
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FoodList(
                            foods: snapshot.response.restaurant.menus.drinks,
                            labelText: "Drinks",
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  child: Text(""),
                );
              }
            },
          ),
        );
      },
    );
  }
}

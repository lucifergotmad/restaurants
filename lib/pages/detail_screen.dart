import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/result_state.dart';
import 'package:restaurants/provider/restaurant_detail_provider.dart';
import 'package:restaurants/widgets/food_list.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/detail";
  final String id;

  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) =>
            RestaurantDetailProvider(apiService: ApiService(), id: id),
        child: Consumer<RestaurantDetailProvider>(
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
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 32),
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
                                  snapshot.response.restaurant.city,
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
                                  "(${snapshot.response.restaurant.rating.toString()})",
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
                          snapshot.response.restaurant.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        FoodList(
                          foods:
                              snapshot.response.restaurant.menus?.foods ?? [],
                          labelText: "Foods",
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        FoodList(
                          foods:
                              snapshot.response.restaurant.menus?.drinks ?? [],
                          labelText: "Drinks",
                        )
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
      ),
    );
  }
}

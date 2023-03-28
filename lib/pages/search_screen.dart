import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/provider/restaurant_search_provider.dart';
import 'package:restaurants/widgets/error_page.dart';
import 'package:restaurants/widgets/search_list.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = "/search";

  final bool isOnline;
  final Function checkConnectivity;

  const SearchScreen(
      {Key? key, required this.isOnline, required this.checkConnectivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
          child: isOnline
              ? ChangeNotifierProvider<RestaurantSearchProvider>(
                  create: (_) => RestaurantSearchProvider(
                    apiService: ApiService(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Search",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Find any restaurant that suits for you",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Consumer<RestaurantSearchProvider>(
                        builder: (context, snapshot, _) {
                          return TextField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            onChanged: (String query) {
                              snapshot.updateQuery(query);
                            },
                            onEditingComplete: () {
                              snapshot.searchRestaurant();
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Start with a restaurant name',
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const Expanded(child: SearchList()),
                    ],
                  ),
                )
              : ErrorPage(
                  checkConnectivity: checkConnectivity,
                ),
        ),
      ),
    );
  }
}

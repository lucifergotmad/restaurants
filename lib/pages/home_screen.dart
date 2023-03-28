import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/pages/search_screen.dart';
import 'package:restaurants/provider/restaurant_provider.dart';
import 'package:restaurants/widgets/card_list.dart';
import 'package:restaurants/widgets/error_page.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";

  final bool isOnline;
  final Function checkConnectivity;

  const HomeScreen(
      {Key? key, required this.isOnline, required this.checkConnectivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
          child: isOnline
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Restaurant",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              SearchScreen.routeName,
                            );
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Recommendation restaurant for you",
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Expanded(
                      child: ChangeNotifierProvider<RestaurantProvider>(
                        create: (_) => RestaurantProvider(
                          apiService: ApiService(),
                        ),
                        child: const CardList(),
                      ),
                    ),
                  ],
                )
              : ErrorPage(
                  checkConnectivity: checkConnectivity,
                ),
        ),
      ),
    );
  }
}

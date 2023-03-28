import 'package:flutter/material.dart';
import 'package:restaurants/widgets/card_list.dart';
import 'package:restaurants/widgets/error_page.dart';

class HomeScreen extends StatelessWidget {
  final bool isOnline;

  const HomeScreen({Key? key, required this.isOnline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
          child: isOnline
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Restaurant",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
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
                    const Expanded(child: CardList()),
                  ],
                )
              : const ErrorPage(),
        ),
      ),
    );
  }
}

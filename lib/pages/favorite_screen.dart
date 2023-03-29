import 'package:flutter/material.dart';
import 'package:restaurants/widgets/favorite_list.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = "/favorite";

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Favorite",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Here are the list of your favorite restaurant",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 32,
              ),
              const Expanded(child: FavoriteList())
            ],
          ),
        ),
      ),
    );
  }
}

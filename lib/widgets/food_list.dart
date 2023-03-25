import 'package:flutter/material.dart';
import 'package:restaurants/model/food.dart';

class FoodList extends StatelessWidget {
  final List<Food> foods;

  const FoodList({Key? key, required this.foods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: const BoxDecoration(color: Colors.orange),
              child: Text(
                foods[index].name,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
        );
      },
      itemCount: foods.length,
    );
  }
}

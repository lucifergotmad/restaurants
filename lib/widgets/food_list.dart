import 'package:flutter/material.dart';
import 'package:restaurants/model/food.dart';

class FoodList extends StatelessWidget {
  final String labelText;
  final List<Food> foods;

  const FoodList({Key? key, required this.foods, required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 80,
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 8,
              );
            },
            itemBuilder: (context, index) {
              final Food food = foods[index];

              return Container(
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      food.name,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: Colors.orangeAccent, fontSize: 12),
                    ),
                  ),
                ),
              );
            },
            itemCount: foods.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}

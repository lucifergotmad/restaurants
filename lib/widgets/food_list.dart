import 'package:flutter/material.dart';
import 'package:restaurants/data/model/food.dart';

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
          "$labelText :",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 40, maxHeight: 50),
          child: ListView.separated(
            shrinkWrap: true,
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
                  color: Theme.of(context).colorScheme.primary,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      food.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 12),
                      textAlign: TextAlign.center,
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

import 'package:flutter/material.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/model/restaurant.dart';

class CardItem extends StatelessWidget {
  final Restaurant restaurant;

  const CardItem({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail", arguments: restaurant);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: SizedBox(
                    height: 120,
                    child: Image.network(
                      "${ApiService.baseUrl}/images/small/${restaurant.pictureId}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.black54, size: 18),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          restaurant.city,
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.orange, size: 16),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "(${restaurant.rating.toString()})",
                          style: Theme.of(context).textTheme.labelSmall,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

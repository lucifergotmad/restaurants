import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/model/restaurant.dart';
import 'package:restaurants/generated/assets.dart';
import 'package:restaurants/pages/detail_screen.dart';
import 'package:restaurants/provider/restaurant_detail_provider.dart';

class CardItem extends StatelessWidget {
  final Restaurant restaurant;

  const CardItem({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<RestaurantDetailProvider>(context, listen: false).initDetail(restaurant.id);
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: restaurant.id);
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
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          Assets.imagesError,
                          fit: BoxFit.cover,
                        );
                      },
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

import 'package:flutter/material.dart';
import 'package:restaurants/generated/assets.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Image.asset(Assets.imagesNoConnection),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "It seems like you lost your network connection",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "Please kindly check your internet connection, and try again",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black38),
        )
      ],
    );
  }
}

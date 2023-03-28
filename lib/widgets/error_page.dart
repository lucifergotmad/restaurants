import 'package:flutter/material.dart';
import 'package:restaurants/generated/assets.dart';

class ErrorPage extends StatelessWidget {
  final Function checkConnectivity;

  const ErrorPage({Key? key, required this.checkConnectivity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          "Please kindly check your internet connection, and restart the app",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.black38),
        ),
        const SizedBox(
          height: 32,
        ),
        ElevatedButton(
          onPressed: () {
            checkConnectivity();
          },
          style: ElevatedButton.styleFrom(elevation: 4),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text("Refresh the App"),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restaurants/pages/detail_screen.dart';
import 'package:restaurants/pages/home_screen.dart';
import 'package:restaurants/model/restaurant.dart';
import 'package:restaurants/shared/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: textTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/detail": (context) => DetailScreen(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            )
      },
    );
  }
}

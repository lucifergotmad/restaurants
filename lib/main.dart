import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurants/pages/detail_screen.dart';
import 'package:restaurants/pages/home_screen.dart';
import 'package:restaurants/pages/search_screen.dart';
import 'package:restaurants/shared/themes.dart';
import 'package:restaurants/utils/network_connectivity.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  Map<ConnectivityResult, bool> _result = {ConnectivityResult.none: true};

  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _checkConnectivity();
  }

  void _checkConnectivity() {
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((event) {
      _result = event;

      switch (_result.values.first) {
        case false:
          setState(() {
            _isOnline = false;
          });
          break;
        case true:
          setState(() {
            _isOnline = true;
          });
          break;
        default:
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _networkConnectivity.disposeStream();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              secondary: secondaryColor,
              onPrimary: onPrimaryColor,
            ),
        textTheme: textTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(
              isOnline: _isOnline,
              checkConnectivity: _checkConnectivity,
            ),
        SearchScreen.routeName: (context) => SearchScreen(
              isOnline: _isOnline,
              checkConnectivity: _checkConnectivity,
            ),
        DetailScreen.routeName: (context) => DetailScreen(
              id: ModalRoute.of(context)?.settings.arguments as String,
              isOnline: _isOnline,
            ),
      },
    );
  }
}

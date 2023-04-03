import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/data/api/api_services.dart';
import 'package:restaurants/data/db/database.dart';
import 'package:restaurants/data/preferences/preferences_helper.dart';
import 'package:restaurants/pages/detail_screen.dart';
import 'package:restaurants/pages/favorite_screen.dart';
import 'package:restaurants/pages/home_screen.dart';
import 'package:restaurants/pages/search_screen.dart';
import 'package:restaurants/pages/setting_screen.dart';
import 'package:restaurants/provider/restaurant_detail_provider.dart';
import 'package:restaurants/provider/restaurant_favorite_provider.dart';
import 'package:restaurants/provider/restaurant_provider.dart';
import 'package:restaurants/provider/restaurant_search_provider.dart';
import 'package:restaurants/provider/scheduling_provider.dart';
import 'package:restaurants/provider/setting_preferences_provider.dart';
import 'package:restaurants/shared/navigation.dart';
import 'package:restaurants/shared/themes.dart';
import 'package:restaurants/utils/background_service.dart';
import 'package:restaurants/utils/network_connectivity.dart';
import 'package:flutter/services.dart';
import 'package:restaurants/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

late final AppDatabase database;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  database = await $FloorAppDatabase.databaseBuilder('restaurant.db').build();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
  final NotificationHelper _notificationHelper = NotificationHelper();

  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _checkConnectivity();
    _notificationHelper
        .configureSelectNotificationSubject(DetailScreen.routeName);
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
    selectNotificationSubject.close();
    _networkConnectivity.disposeStream();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantDetailProvider(
            apiService: ApiService(http.Client()),
            database: database,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantSearchProvider(
            apiService: ApiService(http.Client()),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => SettingPreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantFavoriteProvider(database: database),
        )
      ],
      child: MaterialApp(
        title: 'Stories App',
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
        navigatorKey: navigatorKey,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(
                isOnline: _isOnline,
                checkConnectivity: _checkConnectivity,
              ),
          SearchScreen.routeName: (context) => SearchScreen(
                isOnline: _isOnline,
                checkConnectivity: _checkConnectivity,
              ),
          FavoriteScreen.routeName: (context) => const FavoriteScreen(),
          SettingScreen.routeName: (context) => const SettingScreen(),
          DetailScreen.routeName: (context) => DetailScreen(
                id: ModalRoute.of(context)?.settings.arguments as String,
                isOnline: _isOnline,
              ),
        },
      ),
    );
  }
}

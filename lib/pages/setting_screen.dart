import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurants/provider/scheduling_provider.dart';
import 'package:restaurants/provider/setting_preferences_provider.dart';
import 'package:restaurants/shared/navigation.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = "/settings";

  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Consumer<SettingPreferencesProvider>(
          builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Configure it the way you want",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 16),
                ),
                const SizedBox(
                  height: 32,
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Scheduling News'),
                    trailing: Consumer<SchedulingProvider>(
                      builder: (context, scheduled, _) {
                        return Switch.adaptive(
                          value: provider.isDailyNotificationActive,
                          onChanged: (value) async {
                            if (Platform.isIOS) {
                              showCupertinoDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: const Text('Coming Soon!'),
                                    content: const Text(
                                        'This feature will be coming soon!'),
                                    actions: [
                                      CupertinoDialogAction(
                                        child: const Text('Ok'),
                                        onPressed: () {
                                          Navigation.back();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              scheduled.scheduledNotification(value);
                              provider.enableDailyNews(value);
                            }
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ),
      )),
    );
  }
}

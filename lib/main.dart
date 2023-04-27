import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home/app.dart';
import 'notification/garbage_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await initNotifications();
  runApp(const App());
  setGarbageNotificationAlarm();
}

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
}

Future<void> setGarbageNotificationAlarm() async {
  await AndroidAlarmManager.periodic(
    const Duration(hours: 24),
    0,
    printGarbageNotificationAlarm,
    wakeup: true,
    startAt: DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      20,
    ),
    rescheduleOnReboot: true,
  );
}

@pragma('vm:entry-point')
Future<void> printGarbageNotificationAlarm() async {
  await GarbageNotification().alarmExecutor();
}

import 'dart:collection';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home/bloc/garbage/garbage_repository.dart';
import 'package:home/constants/garbage_constants.dart';

class GarbageNotification {
  final GarbageRepository _repository = GarbageRepository();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void showNotification(List<String> events) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'GarbageChannel',
      'GarbageChannelName',
      channelDescription: 'Garbage channel notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      1,
      garbageNotificationTitle,
      events.join(', '),
      notificationDetails,
    );
  }

  Future<void> alarmExecutor() async {
    final LinkedHashMap<DateTime, List<String>> schedule = await _repository.getSchedule();

    final DateTime now = DateTime.now();
    final DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    if (schedule.containsKey(tomorrow) == false) {
      return;
    }

    GarbageNotification().showNotification(schedule[tomorrow]!);
  }
}

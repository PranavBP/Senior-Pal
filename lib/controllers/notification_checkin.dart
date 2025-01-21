import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize Notifications for iOS and Android
  Future<void> initNotification(
      Function(NotificationResponse) onSelectNotification) async {
    tz_data.initializeTimeZones();

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(iOS: initializationSettingsIOS);

    // Initialize the notifications plugin and pass the callback for tap
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          onSelectNotification, // Handle notification tap
    );
  }

  // Notification Details for iOS
  NotificationDetails notificationDetails() {
    return NotificationDetails(
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  // Schedule Notification to repeat daily
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required TimeOfDay scheduledTime,
    String? payload,
  }) async {
    try {
      // Get the current date and combine it with the selected time
      final now = DateTime.now();
      final scheduledNotificationDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        scheduledTime.hour,
        scheduledTime.minute,
      );

      // Convert to TZDateTime
      final tz.TZDateTime scheduledTimeZone =
          tz.TZDateTime.from(scheduledNotificationDateTime, tz.local);

      // Schedule the notification
      await notificationsPlugin.zonedSchedule(
        0, // Notification ID
        title,
        body,
        scheduledTimeZone,
        notificationDetails(),
        androidAllowWhileIdle: false, // Focus on iOS for now
        payload: payload,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        // Repeat every 24 hours
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }
}

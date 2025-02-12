// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz_data;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initialize Notifications for iOS and Android
//   Future<void> initNotification(
//       Function(NotificationResponse) onSelectNotification) async {
//     tz_data.initializeTimeZones();

//     final DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(iOS: initializationSettingsIOS);

//     // Initialize the notifications plugin and pass the callback for tap
//     await notificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse:
//           onSelectNotification, // Handle notification tap
//     );
//   }

//   // Notification Details for iOS
//   NotificationDetails notificationDetails() {
//     return NotificationDetails(
//       iOS: DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       ),
//     );
//   }

//   // Schedule Notification to repeat daily
//   // Future<void> scheduleNotification({
//   //   required String title,
//   //   required String body,
//   //   required TimeOfDay scheduledTime,
//   //   String? payload,
//   // }) async {
//   //   try {
//   //     // Get the current date and combine it with the selected time
//   //     final now = DateTime.now();
//   //     final scheduledNotificationDateTime = DateTime(
//   //       now.year,
//   //       now.month,
//   //       now.day,
//   //       scheduledTime.hour,
//   //       scheduledTime.minute,
//   //     );

//   //     // Convert to TZDateTime
//   //     final tz.TZDateTime scheduledTimeZone =
//   //         tz.TZDateTime.from(scheduledNotificationDateTime, tz.local);

//   //     // Schedule the notification
//   //     await notificationsPlugin.zonedSchedule(
//   //       0, // Notification ID
//   //       title,
//   //       body,
//   //       scheduledTimeZone,
//   //       notificationDetails(),
//   //       androidAllowWhileIdle: false, // Focus on iOS for now
//   //       payload: payload,
//   //       uiLocalNotificationDateInterpretation:
//   //           UILocalNotificationDateInterpretation.wallClockTime,
//   //       // Repeat every 24 hours
//   //       matchDateTimeComponents: DateTimeComponents.time,
//   //     );
//   //   } catch (e) {
//   //     print('Error scheduling notification: $e');
//   //   }
//   // }
// }

//------New code for ios and android-------//
/*
1) Modified Initialization for Both Platforms
2) initNotification adding oersimsion for android 
*/

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz_data;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initialize Notifications for Android and iOS
//   Future<void> initNotification(
//       Function(NotificationResponse) onSelectNotification) async {
//     tz_data.initializeTimeZones();

//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );

//     await notificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: onSelectNotification,
//     );
//   }

//   // Notification Details for Android and iOS
//   NotificationDetails notificationDetails() {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//         'daily_checkin_channel',
//         'Daily Check-in',
//         channelDescription: 'Reminds users to complete their daily check-in',
//         importance: Importance.high,
//         priority: Priority.high,
//       ),
//       iOS: DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       ),
//     );
//   }

//   // Schedule Notification to repeat daily
//   Future<void> scheduleNotification({
//     required String title,
//     required String body,
//     required TimeOfDay scheduledTime,
//     String? payload,
//   }) async {
//     try {
//       final now = DateTime.now();
//       final scheduledNotificationDateTime = DateTime(
//         now.year,
//         now.month,
//         now.day,
//         scheduledTime.hour,
//         scheduledTime.minute,
//       );

//       final tz.TZDateTime scheduledTimeZone =
//           tz.TZDateTime.from(scheduledNotificationDateTime, tz.local);

//       await notificationsPlugin.zonedSchedule(
//         0, // Notification ID
//         title,
//         body,
//         scheduledTimeZone,
//         notificationDetails(),
//         payload: payload,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.wallClockTime,
//         matchDateTimeComponents: DateTimeComponents.time,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // ✅ FIXED
//       );
//     } catch (e) {
//       print('Error scheduling notification: $e');
//     }
//   }
// }

//--another code--//
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications(
      Function(NotificationResponse) onSelectNotification) async {
    tz_data.initializeTimeZones();

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );
  }

  /// **Request Notification Permission for Android 13+**
  Future<void> requestPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
    }
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_checkin_channel',
        'Daily Check-in Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
    String? payload,
  }) async {
    final now = DateTime.now();
    final scheduledTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final tz.TZDateTime tzTime = tz.TZDateTime.from(scheduledTime, tz.local);

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzTime,
      _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }
}

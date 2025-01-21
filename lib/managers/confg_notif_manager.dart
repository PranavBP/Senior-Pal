// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter/material.dart';
// import 'package:hero_minds/screens/daily-checkin/daily_checkin_screen.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Initialize notifications with a required onSelectNotification parameter
//   Future<void> initNotification(
//       Future<void> Function(String?)? onSelectNotification) async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon'); // Your app's icon

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     // Initialize the plugin
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: onSelectNotification,
//     );
//   }

//   // Function to handle notification taps
//   Future<void> onSelectNotification(String? payload) async {
//     if (payload != null && payload == 'navigate_to_daily_check_in') {
//       // Navigate to the daily check-in screen when notification is tapped
//       Navigator.push(
//         navigatorKey.currentContext!,
//         MaterialPageRoute(builder: (context) => DailyCheckInScreen()),
//       );
//     }
//   }

//   // Schedule a notification
//   Future<void> scheduleNotification({
//     required String title,
//     required String body,
//     required TimeOfDay scheduledTime,
//     required String payload,
//   }) async {
//     final now = DateTime.now();
//     final scheduledDateTime = DateTime(
//         now.year, now.month, now.day, scheduledTime.hour, scheduledTime.minute);

//     // Convert DateTime to TZDateTime
//     final tzDateTime = tz.TZDateTime.local(
//       scheduledDateTime.year,
//       scheduledDateTime.month,
//       scheduledDateTime.day,
//       scheduledDateTime.hour,
//       scheduledDateTime.minute,
//     );

//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'daily_checkin_channel',
//       'Daily Check-in Notifications',
//       channelDescription: 'Daily reminder for user check-in',
//       importance: Importance.high,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       title,
//       body,
//       tzDateTime,
//       platformChannelSpecifics,
//       payload: payload,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
// }

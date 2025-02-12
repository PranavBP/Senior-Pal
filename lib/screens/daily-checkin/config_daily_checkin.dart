//------Old code for only ios-----//
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hero_minds/screens/daily-checkin/daily_checkin_screen.dart'; // Import the DailyCheckInScreen
// import 'package:hero_minds/controllers/notification_checkin.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../provider/theme_provider.dart';

// class ConfigureNotificationScreen extends ConsumerStatefulWidget {
//   const ConfigureNotificationScreen({Key? key}) : super(key: key);

//   @override
//   ConfigureNotificationScreenState createState() =>
//       ConfigureNotificationScreenState();
// }

// class ConfigureNotificationScreenState
//     extends ConsumerState<ConfigureNotificationScreen> {
//   final NotificationService _notificationService = NotificationService();
//   TimeOfDay? _selectedTime;

//   @override
//   void initState() {
//     super.initState();
//     _notificationService.initNotification(_onSelectNotification);
//   }

//   // Function to handle notification taps
//   Future<void> _onSelectNotification(NotificationResponse response) async {
//     String? payload = response.payload;

//     if (payload != null && payload == 'navigate_to_daily_check_in') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => DailyCheckInScreen()),
//       );
//     }
//   }

//   // Function to pick time
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime ?? TimeOfDay.now(),
//     );

//     if (picked != null && picked != _selectedTime)
//       setState(() {
//         _selectedTime = picked;
//       });
//   }

//   // Schedule the notification
//   // void _scheduleNotification() {
//   //   if (_selectedTime != null) {
//   //     _notificationService.scheduleNotification(
//   //       title: 'Daily Check-in Notification',
//   //       body: 'Complete your daily check-in notification.',
//   //       scheduledTime: _selectedTime!,
//   //       payload: 'navigate_to_daily_check_in',
//   //     );

//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Daily Check-in Notification Scheduled!')),
//   //     );
//   //   } else {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Please select a time.')),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final theme = ref.watch(themeNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Configure Daily Notification"),
//         backgroundColor:
//             theme.backgroundGradient[0], // Use theme background color
//       ),
//       body: Center(
//         // Center the body content
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: theme.backgroundGradient, // Use theme gradient
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment:
//                 MainAxisAlignment.center, // Center column content
//             crossAxisAlignment:
//                 CrossAxisAlignment.center, // Align elements centrally
//             children: [
//               Text(
//                 'Select Time for Daily Checkin Notification',
//                 style: TextStyle(
//                   fontSize: 22, // Reduced font size
//                   color: theme.textColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center, // Center the text
//               ),
//               SizedBox(height: 40), // Increased space between title and button
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       theme.textColor, // Use theme's text color for button
//                   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         12), // Increased radius for smoother corners
//                   ),
//                   minimumSize: Size(double.infinity, 60), // Make button wider
//                 ),
//                 onPressed: () => _selectTime(context),
//                 child: Text(
//                   _selectedTime == null
//                       ? 'Select Time'
//                       : 'Selected Time: ${_selectedTime!.format(context)}',
//                   style: TextStyle(
//                     fontSize: 16, // Reduced font size
//                     color: theme
//                         .backgroundColor, // Use theme's background color for text
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30), // Increased space between buttons
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: theme
//                       .backgroundColor, // Use theme's background color for button
//                   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         12), // Increased radius for smoother corners
//                   ),
//                   minimumSize: Size(double.infinity, 60), // Make button wider
//                 ),
//                 onPressed: (){},
//                 child: Text(
//                   'Get Notifications',
//                   style: TextStyle(
//                     fontSize: 16, // Reduced font size
//                     color: theme
//                         .textColor, // Use theme's text color for button text
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }//----do not use the below code----///

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hero_minds/controllers/notification_checkin.dart';
// import 'package:hero_minds/screens/daily-checkin/daily_checkin_screen.dart'; // Import your screen
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import '../../provider/theme_provider.dart';

// class ConfigureNotificationScreen extends ConsumerStatefulWidget {
//   const ConfigureNotificationScreen({Key? key}) : super(key: key);

//   @override
//   ConfigureNotificationScreenState createState() =>
//       ConfigureNotificationScreenState();
// }

// class ConfigureNotificationScreenState
//     extends ConsumerState<ConfigureNotificationScreen> {
//   final NotificationService _notificationService = NotificationService();
//   TimeOfDay? _selectedTime;

//   @override
//   void initState() {
//     super.initState();
//     _notificationService
//         .initNotification(); // This should work now without any arguments
//   }

//   // Function to handle notification taps
//   Future<void> _onSelectNotification(String? payload) async {
//     if (payload != null && payload == 'navigate_to_daily_check_in') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => DailyCheckInScreen()),
//       );
//     }
//   }

//   // Function to pick time
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime ?? TimeOfDay.now(),
//     );

//     if (picked != null && picked != _selectedTime)
//       setState(() {
//         _selectedTime = picked;
//       });
//   }

//   // Schedule the notification
//   void _scheduleNotification() {
//     if (_selectedTime != null) {
//       _notificationService.scheduleNotification(
//         title: 'Daily Check-in Notification',
//         body: 'Complete your daily check-in notification.',
//         scheduledTime: _selectedTime!,
//         payload: 'navigate_to_daily_check_in',
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Daily Check-in Notification Scheduled!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a time.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = ref.watch(themeNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Configure Daily Notification"),
//         backgroundColor:
//             theme.backgroundGradient[0], // Use theme background color
//       ),
//       body: Center(
//         // Center the body content
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: theme.backgroundGradient, // Use theme gradient
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment:
//                 MainAxisAlignment.center, // Center column content
//             crossAxisAlignment:
//                 CrossAxisAlignment.center, // Align elements centrally
//             children: [
//               Text(
//                 'Select Time for Daily Checkin Notification',
//                 style: TextStyle(
//                   fontSize: 22, // Reduced font size
//                   color: theme.textColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center, // Center the text
//               ),
//               SizedBox(height: 40), // Increased space between title and button
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       theme.textColor, // Use theme's text color for button
//                   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         12), // Increased radius for smoother corners
//                   ),
//                   minimumSize: Size(double.infinity, 60), // Make button wider
//                 ),
//                 onPressed: () => _selectTime(context),
//                 child: Text(
//                   _selectedTime == null
//                       ? 'Select Time'
//                       : 'Selected Time: ${_selectedTime!.format(context)}',
//                   style: TextStyle(
//                     fontSize: 16, // Reduced font size
//                     color: theme
//                         .backgroundColor, // Use theme's background color for text
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30), // Increased space between buttons
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: theme
//                       .backgroundColor, // Use theme's background color for button
//                   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                         12), // Increased radius for smoother corners
//                   ),
//                   minimumSize: Size(double.infinity, 60), // Make button wider
//                 ),
//                 onPressed: _scheduleNotification,
//                 child: Text(
//                   'Get Notifications',
//                   style: TextStyle(
//                     fontSize: 16, // Reduced font size
//                     color: theme
//                         .textColor, // Use theme's text color for button text
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//-------- new code for ios and android---------//

// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hero_minds/screens/daily-checkin/daily_checkin_screen.dart'; // Import the DailyCheckInScreen
// import 'package:hero_minds/controllers/notification_checkin.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../provider/theme_provider.dart';

// class ConfigureNotificationScreen extends ConsumerStatefulWidget {
//   const ConfigureNotificationScreen({Key? key}) : super(key: key);

//   @override
//   ConfigureNotificationScreenState createState() =>
//       ConfigureNotificationScreenState();
// }

// class ConfigureNotificationScreenState
//     extends ConsumerState<ConfigureNotificationScreen> {
//   final NotificationService _notificationService = NotificationService();
//   TimeOfDay? _selectedTime;

//   @override
//   void initState() {
//     super.initState();
//     _notificationService.initNotification(_onSelectNotification);
//   }

//   // Function to handle notification taps
//   Future<void> _onSelectNotification(NotificationResponse response) async {
//     String? payload = response.payload;

//     if (payload != null && payload == 'navigate_to_daily_check_in') {
//       if (mounted) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => DailyCheckInScreen()),
//         );
//       }
//     }
//   }

//   // Function to pick time
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime ?? TimeOfDay.now(),
//     );

//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked;
//       });
//     }
//   }

//   // Schedule the notification
//   void _scheduleNotification() {
//     if (_selectedTime != null) {
//       _notificationService.scheduleNotification(
//         title: 'Daily Check-in Notification',
//         body: 'Complete your daily check-in.',
//         scheduledTime: _selectedTime!,
//         payload: 'navigate_to_daily_check_in',
//       );

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Daily Check-in Notification Scheduled!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please select a time.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = ref.watch(themeNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Configure Daily Notification"),
//         backgroundColor: theme.backgroundGradient[0],
//       ),
//       body: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: theme.backgroundGradient,
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Select Time for Daily Check-in Notification',
//                 style: TextStyle(
//                   fontSize: 22,
//                   color: theme.textColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 40),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: theme.textColor,
//                   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   minimumSize: Size(double.infinity, 60),
//                 ),
//                 onPressed: () => _selectTime(context),
//                 child: Text(
//                   _selectedTime == null
//                       ? 'Select Time'
//                       : 'Selected Time: ${_selectedTime!.format(context)}',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: theme.backgroundColor,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: theme.backgroundColor,
//                   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   minimumSize: Size(double.infinity, 60),
//                 ),
//                 onPressed: _scheduleNotification,
//                 child: Text(
//                   'Get Notifications',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: theme.textColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//---another code--//
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/theme_provider.dart';
import 'package:hero_minds/screens/daily-checkin/daily_checkin_screen.dart';
import 'package:hero_minds/controllers/notification_checkin.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ConfigureNotificationScreen extends ConsumerStatefulWidget {
  const ConfigureNotificationScreen({Key? key}) : super(key: key);

  @override
  ConfigureNotificationScreenState createState() =>
      ConfigureNotificationScreenState();
}

class ConfigureNotificationScreenState
    extends ConsumerState<ConfigureNotificationScreen> {
  final NotificationService _notificationService = NotificationService();
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _notificationService.initNotifications(_onSelectNotification);
    _notificationService.requestPermissions();
  }

  Future<void> _onSelectNotification(NotificationResponse response) async {
    if (response.payload == 'navigate_to_daily_check_in') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DailyCheckInScreen()),
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _scheduleNotification() {
    if (_selectedTime != null) {
      _notificationService.scheduleDailyNotification(
        id: 1,
        title: 'Daily Check-in Reminder',
        body: 'It’s time to complete your daily check-in!',
        time: _selectedTime!,
        payload: 'navigate_to_daily_check_in',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Daily Check-in Notification Scheduled!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a time first.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configure Daily Notification"),
        backgroundColor: theme.backgroundGradient[0],
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: theme.backgroundGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Select Time for Daily Check-in Notification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text(
                  _selectedTime == null
                      ? 'Select Time'
                      : 'Selected: ${_selectedTime!.format(context)}',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _scheduleNotification,
                child: const Text('Set Daily Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

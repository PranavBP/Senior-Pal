// import 'package:flutter/material.dart';

// class DailyCheckInPopup extends StatelessWidget {
//   final VoidCallback onNavigateToCheckIn;

//   const DailyCheckInPopup({Key? key, required this.onNavigateToCheckIn})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.check_circle_outline,
//               color: Theme.of(context).primaryColor,
//               size: 64,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "Daily Check-In Required",
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 12),
//             Text(
//               "Reflect on your day by completing the daily check-in.",
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: onNavigateToCheckIn,
//               child: const Text("Go to Check-In"),
//             ),
//             const SizedBox(height: 8),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the popup
//               },
//               child: const Text(
//                 "Not Now",
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class DailyCheckInPopup extends StatelessWidget {
  final VoidCallback onNavigateToCheckIn;

  const DailyCheckInPopup({Key? key, required this.onNavigateToCheckIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Theme.of(context).primaryColor,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              "Daily Check-In Required",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Reflect on your day by completing the daily check-in.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the popup
                onNavigateToCheckIn(); // Navigate to the Check-In screen
              },
              child: const Text("Go to Check-In"),
            ),
          ],
        ),
      ),
    );
  }
}

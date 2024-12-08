import 'package:flutter/material.dart';
import 'package:hero_minds/models/meditation_model.dart';
import 'package:hero_minds/screens/tab%20screens/mindfulness/player_info_screen.dart';

class MindfulnessItem extends StatelessWidget {
  final Meditation meditation;

  const MindfulnessItem({
    super.key,
    required this.meditation,
  });

  void _openPlayerInfoScreenOverlay(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (ctx) => PlayerInfoScreen(
        meditation: meditation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openPlayerInfoScreenOverlay(context);
      },
      child: Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                meditation.image,
                height: 120.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Black opacity layer
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                color:
                    Colors.black.withOpacity(0.3), // Adjust opacity as needed
              ),
            ),
            // Centered text
            Center(
              child: Text(
                meditation.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

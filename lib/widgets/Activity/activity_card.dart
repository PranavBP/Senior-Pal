import 'package:flutter/material.dart';
import 'package:seniorpal/models/activity.dart';
import 'package:seniorpal/screens/modules_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  // final VoidCallback onSelect;

  const ActivityCard({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      clipBehavior: Clip.hardEdge,
      elevation: 3.0,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return ModuleScreen(activity: activity);
          }));
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage(activity.image),
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                // color: Colors.black.withOpacity(0.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.black.withOpacity(0.6),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      activity.desc,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

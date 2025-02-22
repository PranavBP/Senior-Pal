import 'package:flutter/material.dart';
import 'package:seniorpal/models/theme.dart';
import 'package:transparent_image/transparent_image.dart';

class ThemeCard extends StatelessWidget {
  final ThemeModel theme;
  final VoidCallback onSelect;

  const ThemeCard({super.key, required this.theme, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: theme.backgroundGradient),
            // image: DecorationImage(
            //   image: AssetImage(theme.backgroundImage),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Stack(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage), 
                image: AssetImage(theme.backgroundImage),
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
              Center(
                child: Text(
                  theme.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

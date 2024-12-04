import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero_minds/provider/theme_provider.dart';

class DailyQuotePopup extends ConsumerWidget {
  final String quote;
  final VoidCallback onClose;

  const DailyQuotePopup({
    super.key,
    required this.quote,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the current theme model from the provider
    final theme = ref.watch(themeNotifierProvider);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                theme.backgroundImage), // Theme-based background image
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4), // Slightly stronger shadow
              blurRadius: 12.0,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Darker overlay for better text visibility
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5), // Darker overlay layer
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
            ),

            // Text content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onClose,
                      color: Colors.white, // Close button in white
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Welcome Message
                  Text(
                    "Welcome to HERO MIND",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.white, // Fixed white color
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    "🌟 Daily Quote 🌟",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      color: Colors.white, // Fixed white color
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Quote content
                  Expanded(
                    child: Center(
                      child: Text(
                        quote,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          height: 1.5, // Improved line height for readability
                          color: Colors.white, // Fixed white color
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Footer Message
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "✨ Have a great day ✨",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, // Make the footer bold
                        fontSize: 18.0, // Larger font size for prominence
                        color: Colors.white, // Fixed white color
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Week4 extends StatelessWidget {
  const Week4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: StopPracticeView(),
        ),
      ],
    );
  }
}

class StopPracticeView extends StatelessWidget {
  const StopPracticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
                'assets/images/stop2.png', // Add your image to assets
                height: 100,
                width: 100),
          ),
          const StopCard(
            title: 'S - Stop',
            content: [
              'Bring yourself into the present moment by deliberately asking:',
              '• Thoughts… (What am I saying to myself? What images are coming to mind?)',
              '• Feelings… (happy, neutral, upset, excited, sad, mad, etc.)',
              '• Sensations… (physical sensations, tightness, holding, lightness, etc.)',
              '⌆ Acknowledge and register your experience, even if it’s uncomfortable…',
            ],
            gradientColors: [Colors.red, Colors.orange],
          ),
          const StopCard(
            title: 'T - “Take” a Breath',
            content: [
              'Gently direct full attention to breathing, to each in breath and each out breath as they follow, one after the other.',
              '⌆ Your breath can function as an anchor to bring you into the present and help you tune into a state of awareness and stillness…',
            ],
            gradientColors: [Colors.orange, Colors.yellow],
          ),
          const StopCard(
            title: 'O - Observe',
            content: [
              'Expand the field of your awareness around and beyond your breathing, so that it includes a sense of the body as a whole, your posture, your facial expression, and then further outward to what is happening around you: sights, sounds, smells, etc.',
              '⌆ As best you can, bring this expanded awareness to each moment…',
            ],
            gradientColors: [Colors.yellow, Colors.green],
          ),
          const StopCard(
            title: 'P - Proceed',
            content: [
              'Let your attention now move into the world around you, sensing how things are right now. Rather than reacting habitually or mechanically, be curious and open, responding naturally and with kindness.',
              '⌆ You may be surprised by what happens next after having created this pause…',
            ],
            gradientColors: [Colors.green, Colors.blue],
          ),
        ],
      ),
    );
  }
}

class StopCard extends StatelessWidget {
  final String title;
  final List<String> content;
  final List<Color> gradientColors;

  const StopCard({
    super.key,
    required this.title,
    required this.content,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ...content.map((text) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

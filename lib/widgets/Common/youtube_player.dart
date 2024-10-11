import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final String videoUrl;

  const YouTubePlayerScreen({super.key, required this.videoUrl});

  @override
  State<StatefulWidget> createState() {
    return _YouTubePlayerScreenState();
  }
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false, loop: false),
    )..addListener(() {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.90;

    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Player'),
      ),
      body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
        ),
        builder: (context, player) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // YouTube Player
              player,
              // Play/Pause Button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      maximumSize: Size(buttonWidth, 42)
                      // This changes the color of the text and icon
                      ),
                  onPressed: () {
                    if (_isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  },
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  label: Text(
                    _isPlaying ? 'Pause' : 'Play',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

enum DataSourceType { asset, network, file, contentUri }

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final DataSourceType dataSource;

  const VideoPlayerScreen(
      {super.key, required this.videoUrl, required this.dataSource});

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerScreenState();
  }
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isVideoPlayerInitialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    try {
      switch (widget.dataSource) {
        case DataSourceType.asset:
          _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
          break;
        case DataSourceType.network:
          _videoPlayerController =
              VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
          break;
        case DataSourceType.file:
          _videoPlayerController =
              VideoPlayerController.file(File(widget.videoUrl));
          break;
        case DataSourceType.contentUri:
          _videoPlayerController =
              VideoPlayerController.contentUri(Uri.parse(widget.videoUrl));
          break;
      }

      await _videoPlayerController.initialize();
      setState(() {
        _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            aspectRatio: _videoPlayerController.value.aspectRatio,
            autoPlay: true,
            looping: false,
            showOptions: false,
            showControls: true,
            allowFullScreen: true,
            fullScreenByDefault: true,

            // customControls: const CustomControls()
            );
        _isVideoPlayerInitialized = true;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Modules'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: _error != null
              ? Text('Error: $_error')
              : _isVideoPlayerInitialized
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

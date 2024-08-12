// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';

// class CustomControls extends StatefulWidget {
//   const CustomControls({super.key});

//   @override
//   State<CustomControls> createState() {
//     return _CustomControlsState();
//   }
// }

// class _CustomControlsState extends State<CustomControls> {
//   ChewieController? get chewieController => ChewieController.of(context);
//   VideoPlayerController? get videoPlayerController =>
//       chewieController?.videoPlayerController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black54,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 _formatDuration(videoPlayerController!.value.position),
//                 style: TextStyle(color: Colors.white),
//               ),
//               Text(
//                 _formatDuration(videoPlayerController!.value.duration),
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//           VideoProgressIndicator(
//             videoPlayerController!,
//             allowScrubbing: true,
//             colors: VideoProgressColors(
//               playedColor: Colors.red,
//               bufferedColor: Colors.white70,
//               backgroundColor: Colors.white30,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.replay_10, color: Colors.white),
//                 onPressed: () {
//                   videoPlayerController!.seekTo(
//                     videoPlayerController!.value.position -
//                         Duration(seconds: 10),
//                   );
//                 },
//               ),
//               IconButton(
//                 icon: Icon(
//                   videoPlayerController!.value.isPlaying
//                       ? Icons.pause
//                       : Icons.play_arrow,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     videoPlayerController!.value.isPlaying
//                         ? videoPlayerController!.pause()
//                         : videoPlayerController!.play();
//                   });
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.forward_10, color: Colors.white),
//                 onPressed: () {
//                   videoPlayerController!.seekTo(
//                     videoPlayerController!.value.position +
//                         Duration(seconds: 10),
//                   );
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.fullscreen, color: Colors.white),
//                 onPressed: () {
//                   chewieController!.toggleFullScreen();
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
//   }
// }

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool isLoop;
  const VideoPlayer({super.key , required this.isLoop , required this.videoPlayerController});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  late ChewieController chewieController;

  @override
  void initState() {
    chewieController = ChewieController(videoPlayerController: widget.videoPlayerController,
    looping: widget.isLoop,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: chewieController,
        
      ),
    );
  }
}


class VideoDisplay extends StatefulWidget {

  final String videoURL;
  const VideoDisplay({super.key,required this.videoURL});

  @override
  State<VideoDisplay> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(
      isLoop: true,
      videoPlayerController: VideoPlayerController.networkUrl(Uri.parse(widget.videoURL)),
    );
  }
}
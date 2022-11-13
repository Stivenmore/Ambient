import 'package:ambient/screens/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class SamplePlayer extends StatefulWidget {
  final String url;
  const SamplePlayer({Key? key, required this.url}) : super(key: key);

  @override
  SamplePlayerState createState() => SamplePlayerState();
}

class SamplePlayerState extends State<SamplePlayer> {
  late final FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url),
    );
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return SizedBox(
      height: responsive.height,
      width: responsive.width,
      child: FlickVideoPlayer(flickManager: flickManager),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
}

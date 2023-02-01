import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oulun_energia_mobile/views/utils/content.dart';
import 'package:video_player/video_player.dart';

class FishWay extends ConsumerStatefulWidget {
  const FishWay({super.key});

  static const String routeName = "fish_way";
  static const String routePath = "fish_way";

  static Map<String, dynamic> getSettings() {
    return {
      'title': '',
      'secondaryAppBar': false,
      'secondaryAppBarStyle': true,
      'initialExpanded': true,
      'hideAppBar': false,
    };
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return FishWayState();
  }
}

class FishWayState extends ConsumerState {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        "https://cdn3.wowza.com/1/TVF2N0FYbnFheFoz/MzdQQTIw/hls/gxsnzpjc/1328/chunklist.m3u8");
  }

  @override
  Widget build(BuildContext context) {
    var locals = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    return Content(
      image: Image.asset("assets/images/fishway_header.webp"),
      title: locals.fishWayViewTitle,
      text: locals.fishWayViewDescription,
      children: [
        SizedBox(
          height: 200,
          child: FutureBuilder(
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? _buildVideoView()
                    : const Center(child: CircularProgressIndicator()),
            future: _initVideoControllers(),
          ),
        ),
        Text(
          locals.fishWayViewCamDescription,
          style: textTheme.bodyText2,
        )
      ],
    );
  }

  Widget _buildVideoView() {
    return Chewie(controller: _chewieController);
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  _initVideoControllers() async {
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoInitialize: true,
      showOptions: false,
    );
  }
}

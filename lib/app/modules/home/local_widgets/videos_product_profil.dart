// ignore_for_file: file_names

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/widgets.dart';

class VideoPLayerMine extends StatefulWidget {
  final String? videoURL;
  final bool page;
  const VideoPLayerMine({Key? key, this.videoURL, required this.page}) : super(key: key);

  @override
  State<VideoPLayerMine> createState() => _VideoPLayerMineState();
}

class _VideoPLayerMineState extends State<VideoPLayerMine> {
  final HomeController _homeController = Get.put(HomeController());
  @override
  void initState() {
    super.initState();
    _homeController.controller = VideoPlayerController.network(
      widget.videoURL!,
    )
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) {
        _homeController.flickManager = FlickManager(
          autoPlay: true,
          videoPlayerController: VideoPlayerController.network(widget.videoURL!),
        );
      });
  }

  @override
  void dispose() {
    super.dispose();
    _homeController.flickManager.dispose();
    _homeController.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _homeController.controller.value.isInitialized
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      AspectRatio(
                        aspectRatio: _homeController.controller.value.aspectRatio,
                        child: FlickVideoPlayer(
                            flickVideoWithControls: FlickVideoWithControls(
                              controls: FlickPortraitControls(
                                progressBarSettings: FlickProgressBarSettings(),
                              ),
                            ),
                            preferredDeviceOrientation: const [
                              DeviceOrientation.portraitDown,
                              DeviceOrientation.portraitUp,
                            ],
                            preferredDeviceOrientationFullscreen: const [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
                            flickManager: _homeController.flickManager),
                      ),
                      // AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)),
                    ],
                  )
                : Center(child: spinKit()),
          ),
          widget.page
              ? Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(IconlyLight.arrowLeftCircle, color: kPrimaryColor, size: 30),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

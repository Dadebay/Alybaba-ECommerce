// ignore_for_file: file_names

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/product_model.dart';

class VideoPLayerMine extends StatefulWidget {
  final String? videoURL;
 final List<ProductModel> products;
  const VideoPLayerMine({Key? key, this.videoURL, required this.products}) : super(key: key);

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            TabBarView(
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
                Container(
                  color: Colors.red,
                )
              ],
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: TabBar(labelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 20), unselectedLabelStyle: const TextStyle(fontFamily: gilroyMedium, fontSize: 18), labelColor: Colors.white, unselectedLabelColor: Colors.grey, labelPadding: const EdgeInsets.only(top: 8, bottom: 4), indicatorSize: TabBarIndicatorSize.label, indicatorColor: Colors.white, indicatorWeight: 2, tabs: [
                Tab(
                  text: 'videos'.tr,
                ),
                Tab(
                  text: 'sameProducts'.tr,
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

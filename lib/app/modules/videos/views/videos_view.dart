import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/video_model.dart';
import '../../../data/services/video_services.dart';

class VideosView extends StatefulWidget {
  const VideosView({Key? key}) : super(key: key);

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {
  final _pageController = PageController();
  late Future<List<VideosModel>> videosFuture;

  @override
  void initState() {
    super.initState();
    videosFuture = VideosService().getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar:  CustomAppBar(backArrow: false, actionIcon: false, name: 'videos'),
        body: FutureBuilder<List<VideosModel>>(
            future: videosFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: spinKit());
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'noData1'.tr,
                    style: const TextStyle(color: Colors.white, fontFamily: gilroyMedium),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'error'.tr,
                    style: const TextStyle(color: Colors.white, fontFamily: gilroyMedium),
                  ),
                );
              }
              snapshot.data!.shuffle();
              return PageView.builder(
                controller: _pageController,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return VideoPlayerThisPage(
                    videoURL: '$serverURL/${snapshot.data![index].videoURL!}',
                    title: snapshot.data![index].title,
                    subtitle: snapshot.data![index].description,
                  );
                },
              );
            },),
      ),
    );
  }
}

class VideoPlayerThisPage extends StatefulWidget {
  final String? videoURL;
  final String? title;
  final String? subtitle;
  const VideoPlayerThisPage({Key? key, this.videoURL, this.title, this.subtitle}) : super(key: key);

  @override
  State<VideoPlayerThisPage> createState() => _VideoPlayerThisPageState();
}

class _VideoPlayerThisPageState extends State<VideoPlayerThisPage> {
  late VideoPlayerController controller;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(
      widget.videoURL!,
    )
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      })
      ..setLooping(true)
      ..initialize().then((value) {
        flickManager = FlickManager(
          autoPlay: true,
          autoInitialize: true,
          videoPlayerController: VideoPlayerController.network(widget.videoURL!),
        );
      });
  }

  @override
  void dispose() {
    super.dispose();
    flickManager.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: controller.value.isInitialized
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
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
                          flickManager: flickManager,),
                    ),
                    Positioned(
                      bottom: 70,
                      left: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontFamily: gilroyBold, fontSize: 20),
                          ),
                          Text(
                            widget.subtitle!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Center(child: spinKit()),
        ),);
  }
}

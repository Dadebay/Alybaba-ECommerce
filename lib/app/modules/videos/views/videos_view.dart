import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';

import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/cards/product_card.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/video_model.dart';
import '../../../data/services/video_services.dart';
import '../../home/controllers/color_controller.dart';

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

  final ColorController colorController = Get.put(ColorController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colorController.findMainColor.value == 0
            ? kPrimaryColor
            : colorController.findMainColor.value == 1
                ? kPrimaryColor1
                : kPrimaryColor2,
        appBar: CustomAppBar(
          backArrow: false,
          actionIcon: false,
          name: 'videos',
        ),
        body: Column(
          children: [
            TabBar(
              labelStyle: const TextStyle(fontFamily: gilroySemiBold, fontSize: 20),
              unselectedLabelStyle: const TextStyle(fontFamily: gilroyMedium, fontSize: 18),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              labelPadding: const EdgeInsets.only(top: 8, bottom: 4),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              tabs: [
                Tab(
                  text: 'videos'.tr,
                ),
                Tab(
                  text: 'sameProducts'.tr,
                )
              ],
            ),
            Expanded(
              child: FutureBuilder<List<VideosModel>>(
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
                      return TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          VideoPlayerThisPage(
                            videoURL: '$serverURL/${snapshot.data![index].videoURL!}',
                            title: snapshot.data![index].title,
                            subtitle: snapshot.data![index].description,
                          ),
                          Container(
                            color: Colors.white,
                            child: GridView.builder(
                              itemCount: snapshot.data!.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, indexxx) => ProductCard(
                                id: snapshot.data![indexxx].products![indexxx].id!,
                                discountValue: 0,
                                discountValueType: 0,
                                createdAt: DateTime.now().toString(),
                                historyOrder: false,
                                image: '$serverURL/${snapshot.data![index].products![indexxx].image}-mini.webp',
                                name: snapshot.data![index].products![indexxx].name!,
                                price: snapshot.data![index].products![indexxx].price!,
                              ),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 5),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
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
                      flickManager: flickManager,
                    ),
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
      ),
    );
  }
}

// ignore_for_file: file_names

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/home_controller.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/cards/product_card.dart';
import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/video_model.dart';

class VideoPLayerMine extends StatefulWidget {
  final String? videoURL;
  final String? title;
  final String? subtitle;
  final List<Products> products;
  const VideoPLayerMine({
    required this.products,
    this.videoURL,
    this.title,
    this.subtitle,
    Key? key,
  }) : super(key: key);

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
        backgroundColor: kPrimaryColor1,
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
                                flickManager: _homeController.flickManager,
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
                Container(
                  padding: const EdgeInsets.only(top: 75),
                  child: GridView.builder(
                    itemCount: widget.products.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => ProductCard(
                      id: widget.products[index].id!,
                      discountValue: 0,
                      discountValueType: 0,
                      createdAt: DateTime.now().toString(),
                      historyOrder: false,
                      image: '$serverURL/${widget.products[index].image}-mini.webp',
                      name: widget.products[index].name!,
                      price: widget.products[index].price!,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 3 / 5),
                  ),
                )
              ],
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: TabBar(
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
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:video_player/video_player.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/video_model.dart';
import '../../../data/services/video_services.dart';

class VideosView extends StatefulWidget {
  VideosView({Key? key}) : super(key: key);

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {
  final _pageController = PageController();
  late VideoPlayerController _controller;
  doFunction(String videoUrl) {
    _controller = VideoPlayerController.network(
      videoUrl,
    );
    _controller.setLooping(true);
    _controller.initialize().then((value) {
      setState(() {});
    });
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(backArrow: false, actionIcon: false, name: 'videos'),
      body: FutureBuilder<List<VideosModel>>(
          future: VideosService().getVideos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (snapshot.data == null) {
              return Text("Empty");
            } else if (snapshot.hasError) {
              return Text("Error");
            }
            return PageView(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              children: List.generate(snapshot.data!.length, (indexx) {
                doFunction("$serverURL/s${snapshot.data![indexx].videoURL!}");

                return Stack(
                  children: [
                    Center(
                      child: _controller.value.isInitialized
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)),
                              ],
                            )
                          : Center(child: spinKit()),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      child: Column(
                        children: [
                          Text(
                            snapshot.data![indexx].title.toString(),
                            style: TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
                          ),
                          Text(
                            snapshot.data![indexx].title.toString(),
                            style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 18),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }),
            );
          }),
    );
  }
}

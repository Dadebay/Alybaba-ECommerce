// ignore_for_file: file_names

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:video_player/video_player.dart';

class VideoPLayerMine extends StatefulWidget {
  final String? videoURL;

  const VideoPLayerMine({Key? key, this.videoURL}) : super(key: key);

  @override
  State<VideoPLayerMine> createState() => _VideoPLayerMineState();
}

class _VideoPLayerMineState extends State<VideoPLayerMine> {
  late ChewieController _chewieController;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.videoURL!,
    )
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: _controller.value.aspectRatio,
      autoInitialize: true,
      autoPlay: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)),
                    ],
                  )
                : CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(IconlyLight.arrowLeftCircle, color: kPrimaryColor, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: file_names, void_checks, always_use_package_imports

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:photo_view/photo_view.dart';

import '../../constants/constants.dart';

class PhotoViewPageMoreImage extends StatefulWidget {
  final List images;
  const PhotoViewPageMoreImage({required this.images, Key? key}) : super(key: key);

  @override
  State<PhotoViewPageMoreImage> createState() => _PhotoViewPageMoreImageState();
}

class _PhotoViewPageMoreImageState extends State<PhotoViewPageMoreImage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            CarouselSlider.builder(
              itemCount: widget.images.length,
              itemBuilder: (context, index, count) {
                return PhotoView(
                  minScale: 0.4,
                  maxScale: 2.0,
                  imageProvider: NetworkImage(
                    "$serverURL/${widget.images[index]['destination']}-big.webp",
                  ),
                  tightMode: false,
                  errorBuilder: (context, url, error) => const Icon(Icons.error_outline),
                  loadingBuilder: (context, url) => spinKit(),
                );
              },
              options: CarouselOptions(
                onPageChanged: (index, CarouselPageChangedReason a) {},
                viewportFraction: 1.0,
                autoPlay: true,
                height: Get.size.height,
                aspectRatio: 4 / 2,
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              ),
            ),
            Positioned(
              right: 20.0,
              top: 20.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(CupertinoIcons.xmark_circle, color: Colors.white, size: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

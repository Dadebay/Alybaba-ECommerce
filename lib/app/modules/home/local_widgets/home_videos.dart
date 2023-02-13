import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/data/models/video_model.dart';

import '../../../constants/widgets.dart';
import '../../../data/services/video_services.dart';

class HomePageVideos extends StatefulWidget {
  @override
  State<HomePageVideos> createState() => _HomePageVideosState();
}

class _HomePageVideosState extends State<HomePageVideos> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 10),
          child: Text(
            'videos'.tr,
            style: TextStyle(color: Colors.black, fontSize: size.width >= 800 ? 30 : 22, fontFamily: gilroyBold),
          ),
        ),
        SizedBox(
          height: 280,
          child: FutureBuilder<List<VideosModel>>(
              future: VideosService().getVideos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.data == null) {
                  return Text("Empty");
                } else if (snapshot.hasError) {
                  return Text("Error");
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // print(snapshot.data);
                        snapshot.data!.forEach((element) {
                          print(element.products);
                        });
                        // Get.to(() => VideoPLayerMine(
                        //       products: [],
                        //       videoURL: "$serverURL/${snapshot.data![index].videoURL!}",
                        //     ));
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 15, top: 8, right: 8, bottom: 8),
                          width: 180,
                          decoration: BoxDecoration(color: Colors.red, borderRadius: borderRadius20),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: borderRadius20,
                                  child: CachedNetworkImage(
                                    fadeInCurve: Curves.ease,
                                    imageUrl: "$serverURL/${snapshot.data![index].poster!}-mini.webp",
                                    imageBuilder: (context, imageProvider) => Container(
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: borderRadius10,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(child: spinKit()),
                                    errorWidget: (context, url, error) => Center(
                                      child: Text('No Image'),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                  child: Container(
                                decoration: BoxDecoration(borderRadius: borderRadius20, color: Colors.black26),
                              )),
                              Center(child: Lottie.asset('assets/lottie/playButton.json', width: 120, height: 120)),
                            ],
                          )),
                    );
                  },
                );
              }),
        )
      ],
    );
  }
}

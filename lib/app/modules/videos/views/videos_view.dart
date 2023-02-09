import 'package:flutter/material.dart';

import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';

import '../../../constants/constants.dart';
import '../../../constants/widgets.dart';
import '../../../data/models/video_model.dart';
import '../../../data/services/video_services.dart';
import '../../home/local_widgets/videos_product_profil.dart';

class VideosView extends StatefulWidget {
  VideosView({Key? key}) : super(key: key);

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
            return PageView.builder(
              controller: _pageController,
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return
                VideoPLayerMine(
                  page: false,
                  videoURL: "$serverURL/${snapshot.data![index].videoURL!}",
                );
              },
            );
          }),
    );
  }
}

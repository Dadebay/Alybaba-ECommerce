import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/errors/error_widgets.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/data/models/history_orders_model.dart';
import 'package:nabelli_ecommerce/app/modules/home/controllers/color_controller.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/history_order/history_order_status_wait.dart';

class OrderHistoryCard extends StatelessWidget {
  OrderHistoryCard({required this.index, required this.snapshot, Key? key}) : super(key: key);
  final int index;
  final AsyncSnapshot<List<HistoryOrdersModel>> snapshot;
  final ColorController colorController = Get.put(ColorController());

  Widget bottomPart1(String name1, String name2) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name1.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 16, fontFamily: gilroyMedium),
          ),
          Text(
            name2.tr,
            maxLines: 2,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black, fontSize: 15, fontFamily: gilroySemiBold),
          ),
        ],
      ),
    );
  }

  Row topPart(int index, AsyncSnapshot<List<HistoryOrdersModel>> snapshot) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${"order".tr} ${index + 1}",
              style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: gilroySemiBold),
            ),
            Text(
              snapshot.data![index].createdAt!,
              style: TextStyle(color: colorController.mainColor, fontSize: 15, fontFamily: gilroyRegular),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            IconlyLight.arrowRightCircle,
            color: Colors.black,
            size: 25,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => HistoryOrderProductProfil(
            id: snapshot.data![index].id!,
            pageName: "${"order".tr} ${snapshot.data!.length - index}",
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: borderRadius10,
          color: snapshot.data![index].statusId == 2
              ? Colors.green.shade100
              : snapshot.data![index].statusId == 5
                  ? Colors.red.shade100
                  : Colors.grey.shade200,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 3, spreadRadius: 3)],
        ),
        child: Column(
          children: [
            topPart(snapshot.data!.length - index - 1, snapshot),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: Get.size.width,
                child: ListView.builder(
                  itemCount: snapshot.data![index].items!.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int indexx) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: borderRadius10,
                        color: Colors.grey,
                        border: Border.all(color: colorController.mainColor),
                      ),
                      child: ClipRRect(
                        borderRadius: borderRadius10,
                        child: CachedNetworkImage(
                          fadeInCurve: Curves.ease,
                          imageUrl: "$serverURL/${snapshot.data![index].items![indexx]['image']!}-mini.webp",
                          imageBuilder: (context, imageProvider) => Container(
                            width: Get.size.width,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius10,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => spinKit(),
                          errorWidget: (context, url, error) => noBannerImage(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bottomPart1('products', '${snapshot.data![index].items!.length} haryt '),
                bottomPart1('status', snapshot.data![index].statusText!),
                bottomPart1('sum', '${snapshot.data![index].total.toString().substring(0, snapshot.data![index].total!.length - 3)} TMT'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

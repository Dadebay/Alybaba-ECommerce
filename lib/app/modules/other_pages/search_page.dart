import 'package:flutter/material.dart';
import 'package:nabelli_ecommerce/app/modules/home/local_widgets/shop_by_brand.dart';

import '../../constants/widgets.dart';
import '../../data/models/producer_model.dart';
import '../../data/services/producers_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();
  late Future<List<ProducersModel>> producersFuture;
  @override
  void initState() {
    super.initState();
    producersFuture = ProducersService().getProducers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchField(controller, context),
            const SizedBox(
              height: 10,
            ),
            ShopByBrand(
              producers: producersFuture,
            ),
          ],
        ),
      ),
    );
  }
}

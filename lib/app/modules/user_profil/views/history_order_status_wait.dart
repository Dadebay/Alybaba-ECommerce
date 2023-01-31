import 'package:flutter/material.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/data/services/history_order_service.dart';

import '../../../constants/widgets.dart';
import '../../../data/models/history_orders_model.dart';

class OrderStatusWait extends StatelessWidget {
  final int whichStatus;
  const OrderStatusWait({Key? key, required this.whichStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'Order Status Wait'),
      body: FutureBuilder<List<HistoryOrdersModel>>(
          future: HistoryOrdersService().getHistoryOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: spinKit());
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (snapshot.data!.isEmpty) {
              return Text('Empty');
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data![index].total.toString() + "TMT"),
                  subtitle: Text(snapshot.data![index].createdAt.toString()),
                  trailing: Text(snapshot.data![index].statusText.toString()),
                  leading: Text(transport[snapshot.data![index].transport!.toInt() - 1]),
                );
              },
            );
          }),
    );
  }
}

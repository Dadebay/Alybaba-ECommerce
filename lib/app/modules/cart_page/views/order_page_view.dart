import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_page_controller.dart';

class OrderPageView extends GetView<OrderPageController> {
  const OrderPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OrderPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

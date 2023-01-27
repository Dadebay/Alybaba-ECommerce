import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/order_page_controller.dart';

class OrderPageView extends GetView<OrderPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OrderPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OrderPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

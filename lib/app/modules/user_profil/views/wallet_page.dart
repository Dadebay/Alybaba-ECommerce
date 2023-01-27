import 'package:flutter/material.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(backArrow: true, actionIcon: false, name: 'Wallet Page'),
      body: Center(
        child: Text('Currently I dont have design in my head '),
      ),
    );
  }
}

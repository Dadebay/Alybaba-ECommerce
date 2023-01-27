import 'package:flutter/material.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';

import '../../../data/services/abous_us_service.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(backArrow: true, actionIcon: true, icon: SizedBox.shrink(), name: 'terms_and_conditions'),
      body: FutureBuilder<dynamic>(
          future: AboutUsService().getRules(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (snapshot.data == null) {
              return Text('Empty');
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text(
                    snapshot.data!['privacy_tm'],
                    style: TextStyle(color: Colors.black, fontFamily: gilroyRegular, fontSize: 18),
                  )
                ],
              ),
            );
          }),
    );
  }
}

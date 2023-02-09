import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class UserProfilIconButton extends StatelessWidget {
  UserProfilIconButton({Key? key, required this.icon, required this.name, required this.onTap}) : super(key: key);
  final IconData icon;
  final String name;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 32,
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                name.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: gilroyMedium, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: file_names, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../modules/home/controllers/color_controller.dart';
import '../constants.dart';

class PhoneNumber extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode mineFocus;
  final FocusNode requestFocus;
  final bool style;
  final bool? disabled;
   PhoneNumber({required this.mineFocus, required this.controller, required this.requestFocus, required this.style, this.disabled});
  final ColorController colorController = Get.put(ColorController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: TextFormField(
        enabled: disabled ?? true,
        style: const TextStyle(color: Colors.black, fontSize: 18, fontFamily: gilroyMedium),
        cursorColor: Colors.black,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        focusNode: mineFocus,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'errorEmpty'.tr;
          } else if (value.length != 8) {
            return 'errorPhoneCount'.tr;
          }
          return null;
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(8),
        ],
        onEditingComplete: () {
          requestFocus.requestFocus();
        },
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          errorMaxLines: 2,
          errorStyle: const TextStyle(fontFamily: gilroyMedium),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              '+ 993',
              style: TextStyle(color: Colors.grey, fontSize: 18, fontFamily: gilroyMedium),
            ),
          ),
          contentPadding: const EdgeInsets.only(left: 25, top: 16, bottom: 18),
          prefixIconConstraints: const BoxConstraints(minWidth: 80),
          isDense: true,
          hintText: '65 656565 ',
          filled: style,
          fillColor:  colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2,
          alignLabelWithHint: true,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontFamily: gilroyMedium),
          border: OutlineInputBorder(
            borderRadius: style ? borderRadius10 : borderRadius20,
            borderSide: BorderSide(color: style ?  colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2 : Colors.grey, width: 2,),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: style ? borderRadius10 : borderRadius20,
            borderSide: BorderSide(color: style ?  colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2 : Colors.grey.shade200, width: 2,),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: style ? borderRadius10 : borderRadius20,
            borderSide:  BorderSide(color:  colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2, width: 2,),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: style ? borderRadius10 : borderRadius20,
            borderSide:  BorderSide(color:  colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2, width: 2,),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: style ? borderRadius10 : borderRadius20,
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}

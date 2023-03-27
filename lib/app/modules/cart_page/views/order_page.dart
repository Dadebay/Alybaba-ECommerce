import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/services/create_order.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/agree_button_view.dart';
import 'package:nabelli_ecommerce/app/modules/cart_page/views/local_widget.dart';
import 'package:nabelli_ecommerce/app/modules/user_profil/controllers/user_profil_controller.dart';
import '../../../constants/text_fields/custom_text_field.dart';
import '../../../constants/text_fields/phone_number.dart';
import '../../../data/models/get_order_info_model.dart';
import '../controllers/cart_page_controller.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    required this.airPlane,
    Key? key,
  }) : super(key: key);

  final bool airPlane;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

enum PaymentMethod { cash, creditCard }

enum OrderType { train, plain, container }

class _OrderPageState extends State<OrderPage> {
  final TextEditingController addressController = TextEditingController();
  final CartPageController cartController = Get.put(CartPageController());
  final TextEditingController cityController = TextEditingController();
  String name = 'Asgabat';
  final TextEditingController noteController = TextEditingController();
  final FocusNode orderAdressFocusNode = FocusNode();
  late final Future<GetOrderInfoModel> orderModel;
  final FocusNode orderNote = FocusNode();
  final FocusNode orderPhoneNumber = FocusNode();
  OrderType orderType = OrderType.train;
  int orderTypeNum = -1;
  final FocusNode orderUserName = FocusNode();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final _orderPage = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNameController.text = Get.find<UserProfilController>().userName.toString();
    if (Get.find<UserProfilController>().userPhoneNumber.isNotEmpty && Get.find<UserProfilController>().userPhoneNumber.toString() != ' ') {
      phoneController.text = Get.find<UserProfilController>().userPhoneNumber.toString();
    }
    orderModel = CreateOrderService().getOrderInfo();
  }

  Container userInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: borderRadius10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'userInfo'.tr,
              style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
            ),
          ),
          CustomTextField(
            labelName: 'userName',
            controller: userNameController,
            focusNode: orderUserName,
            requestfocusNode: orderPhoneNumber,
            isNumber: false,
            maxline: 1,
            borderRadius: true,
            unFocus: false,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: PhoneNumber(mineFocus: orderPhoneNumber, controller: phoneController, requestFocus: orderAdressFocusNode, style: false),
          ),
          selectCity(),
          CustomTextField(
            labelName: 'orderAdress',
            controller: addressController,
            focusNode: orderAdressFocusNode,
            requestfocusNode: orderNote,
            isNumber: false,
            borderRadius: true,
            maxline: 4,
            unFocus: false,
          ),
          CustomTextField(
            labelName: 'note',
            controller: noteController,
            focusNode: orderNote,
            requestfocusNode: orderUserName,
            isNumber: false,
            maxline: 4,
            borderRadius: true,
            unFocus: true,
          ),
        ],
      ),
    );
  }

  Widget orderTypeWidget(GetOrderInfoModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "${"orderType".tr} : ",
            style: const TextStyle(color: Colors.black, fontFamily: gilroySemiBold, fontSize: 20),
          ),
        ),
        widget.airPlane
            ? RadioListTile<OrderType>(
                contentPadding: EdgeInsets.zero,
                value: OrderType.train,
                groupValue: orderType,
                onChanged: (OrderType? value) {
                  setState(() {
                    orderType = value!;
                    orderTypeNum = 1;
                  });
                },
                activeColor: colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2,
                title: Text(
                  'plain'.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
                ),
                subtitle: Text(
                  '${'orderComesThatDayTitle'.tr} ${model.transports!.first.minWeek}-${model.transports!.first.maxWeek} ${'orderComesThatDaySubtitle'.tr}',
                  style: const TextStyle(color: Colors.black54, fontFamily: gilroyRegular),
                ),
              )
            : const SizedBox.shrink(),
        model.transports![1].minWeek == 0 && model.transports![1].maxWeek == 0
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: RadioListTile<OrderType>(
                  contentPadding: EdgeInsets.zero,
                  value: OrderType.plain,
                  groupValue: orderType,
                  onChanged: (OrderType? value) {
                    setState(() {
                      orderType = value!;
                      orderTypeNum = 2;
                    });
                  },
                  activeColor: colorController.findMainColor.value == 0
                      ? kPrimaryColor
                      : colorController.findMainColor.value == 1
                          ? kPrimaryColor1
                          : kPrimaryColor2,
                  title: Text(
                    'train'.tr,
                    style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
                  ),
                  subtitle: Text(
                    '${'orderComesThatDayTitle'.tr} ${model.transports![1].minWeek}-${model.transports![1].maxWeek} ${'orderComesThatDaySubtitle'.tr}',
                    style: const TextStyle(color: Colors.black54, fontFamily: gilroyRegular),
                  ),
                ),
              ),
        model.transports![2].minWeek == 0 && model.transports![2].maxWeek == 0
            ? const SizedBox.shrink()
            : RadioListTile<OrderType>(
                contentPadding: EdgeInsets.zero,
                value: OrderType.container,
                groupValue: orderType,
                onChanged: (OrderType? value) {
                  setState(() {
                    orderType = value!;
                    orderTypeNum = 3;
                  });
                },
                activeColor: colorController.findMainColor.value == 0
                    ? kPrimaryColor
                    : colorController.findMainColor.value == 1
                        ? kPrimaryColor1
                        : kPrimaryColor2,
                title: Text(
                  'container'.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
                ),
                subtitle: Text(
                  '${'orderComesThatDayTitle'.tr} ${model.transports![2].minWeek}-${model.transports![2].maxWeek} ${'orderComesThatDaySubtitle'.tr}',
                  style: const TextStyle(color: Colors.black54, fontFamily: gilroyRegular),
                ),
              ),
      ],
    );
  }

  Widget selectCity() {
    return Container(
      margin: const EdgeInsets.only(top: 2, bottom: 2),
      decoration: BoxDecoration(borderRadius: borderRadius20, border: Border.all(color: backgroundColor, width: 2)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: Text(name.tr, style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 18)),
        shape: const RoundedRectangleBorder(
          borderRadius: borderRadius15,
        ),
        trailing: const Icon(IconlyLight.arrowRightCircle),
        onTap: () {
          Get.defaultDialog(
            title: 'selectCityTitle'.tr,
            titleStyle: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
            radius: 5,
            backgroundColor: Colors.white,
            titlePadding: const EdgeInsets.symmetric(vertical: 20),
            content: Column(
              children: List.generate(
                cities.length,
                (index) => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    dividerr(),
                    TextButton(
                      onPressed: () {
                        name = cities[index];
                        setState(() {});
                        Get.back();
                      },
                      child: Text(
                        '${cities[index]}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: orderPgaeAppBar(),
      body: Form(
        key: _orderPage,
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            userInfo(),
            FutureBuilder<GetOrderInfoModel>(
              future: orderModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: spinKit());
                } else if (snapshot.data == null) {
                  return const Text('Empty');
                } else if (snapshot.hasError) {
                  return const Text('Error');
                }
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: const BoxDecoration(color: Colors.white, borderRadius: borderRadius10),
                      child: orderTypeWidget(snapshot.data!),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              snapshot.data!.info!.toString(),
                              style: const TextStyle(color: Colors.grey, fontSize: 17, fontFamily: gilroyRegular),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 40,
            ),
            AgreeButton(
              onTap: () {
                if (_orderPage.currentState!.validate()) {
                  CreateOrderService()
                      .createOrder(
                    userName: userNameController.text,
                    userPhoneNumber: phoneController.text,
                    address: '$name + ${addressController.text}',
                    note: noteController.text,
                    transport: orderTypeNum,
                  )
                      .then((value) {
                    if (value == 200) {
                      Get.back();
                      cartController.cartListToCompare.clear();
                      cartController.removeAllCartElements();
                      showSnackBar('orderComplete', 'orderCompletedTrue', Colors.green);
                    } else {
                      showSnackBar('errorTitle', 'error', Colors.red);
                    }
                  });
                } else {
                  showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

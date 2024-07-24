import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:nabelli_ecommerce/app/constants/buttons/agree_button_view.dart';
import 'package:nabelli_ecommerce/app/constants/constants.dart';
import 'package:nabelli_ecommerce/app/constants/custom_app_bar.dart';
import 'package:nabelli_ecommerce/app/constants/loaders/loader_widgets.dart';
import 'package:nabelli_ecommerce/app/constants/widgets.dart';
import 'package:nabelli_ecommerce/app/data/services/abous_us_service.dart';
import 'package:nabelli_ecommerce/app/data/services/create_order_service.dart';

import '../../../constants/text_fields/custom_text_field.dart';
import '../../../constants/text_fields/phone_number.dart';
import '../../../data/models/get_order_info_model.dart';
import '../../home/controllers/home_controller.dart';
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
  final HomeController homeController = Get.put(HomeController());
  String name = 'Asgabat';
  final FocusNode orderAdressFocusNode = FocusNode();
  late final Future<GetOrderInfoModel> orderModel;
  final FocusNode orderPhoneNumber = FocusNode();
  OrderType orderType = OrderType.train;
  int orderTypeNum = 1;
  final FocusNode orderUserName = FocusNode();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  final _orderPage = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNameController.clear();
    phoneController.clear();
    orderModel = CreateOrderService().getOrderInfo();
  }

  Container userInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: borderRadius20),
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
            child: PhoneNumber(mineFocus: orderPhoneNumber, controller: phoneController, unFocus: false, requestFocus: orderAdressFocusNode, style: false),
          ),
          selectCity(),
          CustomTextField(
            labelName: 'orderAdress',
            controller: addressController,
            focusNode: orderAdressFocusNode,
            requestfocusNode: orderAdressFocusNode,
            isNumber: false,
            borderRadius: true,
            maxline: 4,
            unFocus: true,
          ),
        ],
      ),
    );
  }

  Widget orderTypeWidget(GetOrderInfoModel model) {
    final bool showDate = int.parse(model.transports![0].maxWeek.toString()) > 10;
    final bool showDate1 = int.parse(model.transports![1].maxWeek.toString()) > 10;
    final bool showDate2 = int.parse(model.transports![2].maxWeek.toString()) > 10;
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
        model.transports![0].minWeek == 0 && model.transports![0].maxWeek == 0
            ? const SizedBox.shrink()
            : RadioListTile<OrderType>(
                contentPadding: EdgeInsets.zero,
                value: OrderType.train,
                groupValue: orderType,
                onChanged: (OrderType? value) {
                  setState(() {
                    orderType = value!;
                    orderTypeNum = 1;
                  });
                },
                activeColor: colorController.mainColor,
                title: Text(
                  'plain'.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
                ),
                subtitle: Text(
                  showDate
                      ? '${'orderComesThatDayTitle'.tr} ${model.transports![0].minWeek.toString().substring(0, 1)}-${model.transports![0].maxWeek.toString().substring(0, 1)} ${'orderComesThatDaySubtitleDAILY'.tr}'
                      : '${'orderComesThatDayTitle'.tr} ${model.transports![0].minWeek}-${model.transports![0].maxWeek} ${'orderComesThatDaySubtitle'.tr}',
                  style: const TextStyle(color: Colors.black54, fontFamily: gilroyRegular),
                ),
              ),
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
                  activeColor: colorController.mainColor,
                  title: Text(
                    'train'.tr,
                    style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
                  ),
                  subtitle: Text(
                    showDate1
                        ? '${'orderComesThatDayTitle'.tr} ${model.transports![1].minWeek.toString().substring(0, 1)}-${model.transports![1].maxWeek.toString().substring(0, 1)} ${'orderComesThatDaySubtitleDAILY'.tr}'
                        : '${'orderComesThatDayTitle'.tr} ${model.transports![1].minWeek}-${model.transports![1].maxWeek} ${'orderComesThatDaySubtitle'.tr}',
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
                activeColor: colorController.mainColor,
                title: Text(
                  'container'.tr,
                  style: const TextStyle(color: Colors.black, fontFamily: gilroyMedium),
                ),
                subtitle: Text(
                  showDate2
                      ? '${'orderComesThatDayTitle'.tr} ${model.transports![2].minWeek.toString().substring(0, 1)}-${model.transports![2].maxWeek.toString().substring(0, 1)} ${'orderComesThatDaySubtitleDAILY'.tr}'
                      : '${'orderComesThatDayTitle'.tr} ${model.transports![2].minWeek}-${model.transports![2].maxWeek} ${'orderComesThatDaySubtitle'.tr}',
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
                    divider(),
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
      appBar: CustomAppBar(
        backArrow: true,
        actionIcon: false,
        name: 'orders',
      ),
      body: Form(
        key: _orderPage,
        child: ListView(
          padding: const EdgeInsets.all(15.0),
          children: [
            userInfo(),
            orderInfowidget(),
            const SizedBox(
              height: 40,
            ),
            AgreeButton(
              onTap: () {
                if (_orderPage.currentState!.validate()) {
                  homeController.agreeButton.value = !homeController.agreeButton.value;
                  CreateOrderService()
                      .createOrder(
                    userName: userNameController.text,
                    userPhoneNumber: phoneController.text,
                    address: '$name + ${addressController.text}',
                    note: '',
                    transport: orderTypeNum,
                  )
                      .then((value) {
                    if (value == 200) {
                      Get.back();
                      cartController.cartListToCompare.clear();
                      cartController.removeAllCartElements();
                      showSnackBar('orderComplete', 'orderCompletedTrue', Colors.green);
                      homeController.agreeButton.value = !homeController.agreeButton.value;
                    } else {
                      showSnackBar('errorTitle'.tr + '$value', 'error', Colors.red);
                      homeController.agreeButton.value = !homeController.agreeButton.value;
                    }
                  });
                } else {
                  showSnackBar('noConnection3', 'errorEmpty', Colors.red);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder<GetOrderInfoModel> orderInfowidget() {
    return FutureBuilder<GetOrderInfoModel>(
      future: orderModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return spinKit();
        } else if (snapshot.data == null) {
          return const Text('Empty');
        } else if (snapshot.hasError) {
          return const Text('Error');
        }
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
            FutureBuilder<dynamic>(
              future: AboutUsService().getRules(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return spinKit();
                } else if (snapshot.hasError) {
                  return SizedBox.shrink();
                } else if (snapshot.data == null) {
                  return SizedBox.shrink();
                }
                String lang = Get.locale!.languageCode;
                if (lang == 'tr' || lang == 'en') {
                  lang = 'tm';
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    lang == 'tm' ? snapshot.data!['privacy_tm'] : snapshot.data!['privacy_ru'],
                    style: const TextStyle(color: Colors.grey, fontFamily: gilroyRegular, fontSize: 18),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

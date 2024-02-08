// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../util/images.dart';
import '../view/base/custom_snackbar.dart';
//import 'package:intal_project/view/screens/permission/permission_request_screen.dart';

// import '../repository/banners_repo.dart';
// import '../view/base/permission_dialog.dart';
// import '../view/screens/attendance/attendance_screen.dart';
// import '../view/screens/que/bottom_navigation_bar_2.dart';
// import '../view/screens/que/que_screen.dart';

class BannersController extends GetxController {
  // BannersRepo bannersRepo;

  List<ButtonModel> buttonItem = [
    ButtonModel(
      image: Images.product,
      name: 'طلب إذن',
      //screen: const PermissionRequestScreen()
    ),
    ButtonModel(
      image: Images.billing_section,
      name: 'حظور',
      //  screen: const AttendanceScreen()
    ),
    ButtonModel(
      image: Images.limited_stock,
      name: 'المسائلات',
      //screen: const QueScreen()
    ),
    ButtonModel(
      image: Images.stock,
      name: 'غذاء',
      // screen: const BottomNavigationBar2()
    ),
    ButtonModel(image: Images.product_setup, name: 'قطعة'),
    ButtonModel(
      image: Images.empty_box,
      name: 'Profile22',
    ),
    ButtonModel(
      image: Images.limited_stock,
      name: 'window3',
      //screen: const QueScreen()
    ),
  ];

  int currentIndex = 0;

  List<String> mainBannerList = [
    'https://images.pexels.com/photos/3746957/pexels-photo-3746957.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    'https://images.pexels.com/photos/3747455/pexels-photo-3747455.jpeg?auto=compress&cs=tinysrgb&h=650&w=940',
    'https://images.pexels.com/photos/5699475/pexels-photo-5699475.jpeg?auto=compress&cs=tinysrgb&h=650&w=940'
  ];

  List<BillSearchType> searchQuery = [
    BillSearchType(queryName: "اليوم", queryType: 1),
    BillSearchType(queryName: "أمس", queryType: 2),
    BillSearchType(queryName: "خلال أسبوع", queryType: 3),
    BillSearchType(queryName: "خلال شهر", queryType: 4),
    BillSearchType(queryName: "فترة محددة", queryType: 5),
  ];

  void getLocationPrediction() async {
    _checkPermission(() async {
      Position? p = await Geolocator.getCurrentPosition();
      showCustomSnackBar(p.toString());
      log(p.toString());
    });
  }

  void _checkPermission(Function onTap) async {
    await Geolocator.requestPermission();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr);
    } else if (permission == LocationPermission.deniedForever) {
      //Get.dialog(const PermissionDialog());
    } else {
      onTap();
    }
  }
}

class ButtonModel {
  String name;
  String image;
  Widget? screen;
  ButtonModel({required this.name, required this.image, this.screen});
}

class BillSearchType {
  int queryType;
  String queryName;
  BillSearchType({
    required this.queryType,
    required this.queryName,
  });
}

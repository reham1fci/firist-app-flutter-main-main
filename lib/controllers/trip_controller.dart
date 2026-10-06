import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../api/Api.dart';
import '../model/login_model.dart';
import '../util/app_constants.dart';
import '../view/base/custom_lert_dialog.dart';
import '../view/base/custom_snackbar.dart';
import '../view/screens/shipments/trips_screens.dart';
import 'auth_controller.dart';

class TripController extends GetxController {
  Api api = Api();

  List<dynamic> citiesList = [];
  bool isLoadingCities = false;
  bool isLoading = false;
  Position? currentLocation;

  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        showCustomSnackBar('you_have_to_allow'.tr);
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          showCustomSnackBar('you_have_to_allow'.tr);
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showCustomSnackBar('you_have_to_allow'.tr);
        return null;
      }

      currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (_) {}
    return currentLocation;
  }

  Future<List<dynamic>> getCities() async {
    isLoadingCities = true;
    update();

    String url = AppConstants.getCities;
    try {
      var response = await api.getData(url: url);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data != null && data is Map) {
          if (data.containsKey('cities') && data['cities'] is List) {
            citiesList = data['cities'];
          } else if (data.containsKey('data') && data['data'] is List) {
            citiesList = data['data'];
          }
        } else if (data != null && data is List) {
          citiesList = data;
        }
      }
    } catch (_) {
      // Error fetching cities
    } finally {
      isLoadingCities = false;
      update();
    }
    return citiesList;
  }

  Future<void> addTrip({
    String? fromCity,
    String? toCity,
    String? details,
  }) async {
    isLoading = true;
    update();

    try {
      // Wait for permission check and current location acquisition
      Position? loc = await getCurrentLocation();
      if (loc == null) {
        isLoading = false;
        update();
        return;
      }

      LoginResponsModel user = await AuthController().getLoginData();
      String url = "${AppConstants.addTrip2}?employ_id=${user.id!}";
      final Map<String, dynamic> data = <String, dynamic>{};

      data['lat'] = loc.latitude.toString();
      data['lng'] = loc.longitude.toString();

      if (fromCity != null && fromCity.isNotEmpty) {
        data['city_from'] = fromCity;
      }

      if (toCity != null && toCity.isNotEmpty) {
        data['city_to'] = toCity;
      }

      if (details != null && details.isNotEmpty) {
        data['details'] = details;
      }

      final response = await api.postData2(uri: url, map: data);

      if (response.statusCode == 200) {
        var resData = jsonDecode(response.body);
        if (resData["success"] == true) {
          isLoading = false;
          update();

          if (Get.context != null) {
            Navigator.of(Get.context!).pop(); // Close AddTripDialog
            String message = resData["msg"] ?? resData["message"] ?? 'Added successfully';
            showOkDialog(
              context: Get.context!,
              message: message,
              isCancelBtn: false,
              onOkClick: () async {
                Get.back();
                await Get.to(() => const TripsScreen());
              },
            );
          }
          return;
        } else {
          isLoading = false;
          update();
          String message = resData["msg"] ?? resData["message"] ?? 'Failed to add trip';
          if (Get.context != null) {
            showOkDialog(
              context: Get.context!,
              message: message,
              isCancelBtn: false,
              onOkClick: () {
                Navigator.of(Get.context!).pop();
              },
            );
          }
          return;
        }
      }
    } catch (_) {
      // Handle exception
    } finally {
      isLoading = false;
      update();
    }
  }
}

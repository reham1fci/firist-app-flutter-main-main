
import 'dart:convert';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../model/image_data.dart';
import '../util/app_constants.dart';

class MaintenanceController extends GetxController implements GetxService {

 bool isLoading  = false  ;
  XFile tempImage = XFile('');
  List<XFile> carImages = [];
  XFile invoiceImage = XFile('');
  List<XFile> invoiceImages = [];
  //List<ImageData> imagesList = [];
  List<MultipartBody> multipartList = [];
  int bgColor = 0xFFEEFCF0;
  Color textColor = Colors.red;
 final TextEditingController costController = TextEditingController();
 final TextEditingController detailsController = TextEditingController();

  void pickImage({required String fileName ,required  List<XFile> imagesList  }) async {
    tempImage =
    (await ImagePicker().pickImage(source: ImageSource.camera))!;

    imagesList.add(tempImage);
       multipartList.add(MultipartBody(fileName, tempImage));
       update();

  }

  void removeImage(int index  , List<XFile> imagesList ) {
    imagesList.removeAt(index);
    multipartList.removeAt(index);
    update();
  }
  void resetData() {
    carImages.clear();
    invoiceImages.clear();
    costController.clear();
    update();
  }

  addMaintenanceRequest(Map<String, dynamic> body,) async {
    isLoading = true;
    update();
    Api api = Api();
    var request = http.MultipartRequest(
        "POST", Uri.parse(AppConstants.baseUrl + AppConstants.addMaintenanceReq));
    request.fields
        .addAll(body.map((key, value) => MapEntry(key, value.toString())));
    for (MultipartBody multipart in multipartList) {
      if (multipart.file != null) {
        Uint8List list = await multipart.file!.readAsBytes();
        request.files.add(http.MultipartFile(
          multipart.key,
          multipart.file!.readAsBytes().asStream(),
          list.length,
          filename: '${DateTime.now().toString()}.png',
        ));
      }
    }

    print(request.fields);
    print(request.url);
    print(request.files.toString());

    // Send the request or further handle it
    var response = await request.send();


    // Handle response as needed
    if (response.statusCode == 200) {
      print(response);

      isLoading = false;
      showOkDialog(
          context: Get.context!,
          message: 'added_to_requests_permission'.tr,
          isCancelBtn: false,
          onOkClick: () {
            Navigator.pop(Get.context!, 'someResult');
         //   getRequests(requestName!); // Replace 'someResult' with the actual result or null.
          });
      update();

      // Success handling
    } else {
      print("error");

      showOkDialog(
          context: Get.context!,
          message: 'try again',
          isCancelBtn: false,
          onOkClick: () {});
      isLoading = false;

      update();
      // Error handling
    }
  }
 Future<dynamic> showMaintenanceRequest(String functionName) async {
    Api api  = Api()  ;
   LoginResponsModel user =  await AuthController().getLoginData()  ;
   String url  =  functionName+"?"+"id=" +user.id!   ;
   print(url) ;
   try {
     var response  = await  api.getData(url: url)  ;

     if (response.statusCode == 200) {
       print("requests");
       print(jsonDecode(response.body));

       return jsonDecode(response.body);

     } else {
       return "error";
     }
   } catch (e) {
     print("Error: $e");
     return "error";
   }
 }

}

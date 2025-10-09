import 'dart:convert';
import 'dart:io';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/model/image_data.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/shipment.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/base/file_name_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/app_constants.dart';
import 'package:http/http.dart' as http;


class ShipmentController extends GetxController {
  bool isLoading = false;
  Api api = Api()  ;
  List <Shipment> allList = []  ;
  List <Shipment> processingList = []  ;
  List <Shipment> finishList = []  ;
  List <Shipment> waitingList = []  ;
  List<Shipment> shipmentDetails = [];
  XFile identityImage = XFile('');
  List<XFile> identityImages = [];
  List<ImageData> imagesList = [];
  List<String> filesNames = [];
  List<MultipartBody> multipartList = [];
  int page = 1;
  int pageWaiting = 1;
  int pageProcessing = 1;
  int pageFinishing = 1;
  int pageCancel = 1;
  bool hasMore = true;
  List<int> selectedIndexes = [];
  List<Shipment> selectedShipments = [];
  bool isFetching = false;
  Function()? onRefreshUi;   // هنا هنخزن الفانكشن
  TextEditingController fileName = TextEditingController();

  void setFetching(bool value) {
    isFetching = value;
    update();
  }
  void toggleSelection(int index, Shipment shipment) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
      selectedShipments.remove(shipment);
    } else {
      selectedIndexes.add(index);
      selectedShipments.add(shipment);
    }
    update(); // يعمل rebuild للـ GetBuilder
  }

  bool isSelected(int index) {
    return selectedIndexes.contains(index);
  }
  void pickImageFromCamera() async {
    fileName.text = "";

    // فتح الكاميرا لالتقاط صورة
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      FileNameDialog(
        context: Get.context!,
        isCancelBtn: true,
        onOkClick: () {
          String fileNameText = fileName.text.trim();

          filesNames.add(fileNameText.isEmpty
              ? image.name
              : fileNameText);

          identityImages.add(image);
          multipartList.add(MultipartBody('files[]', image));

          update();
        },
      );
    } else {
      // المستخدم لغى التصوير
      print("No image captured");
    }
  }


  void pickFile() async {
    fileName.text = "";

    // فتح اختيار الملف
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType
          .any, // ممكن تخليها FileType.custom وتحددي الأنواع لو عايزة
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile pickedFile = result.files.first;
      XFile file = XFile(pickedFile.path!);

      FileNameDialog(
        context: Get.context!,
        isCancelBtn: true,
        onOkClick: () {
          String fileNameText = fileName.text.trim();

          filesNames.add(fileNameText.isEmpty ? pickedFile.name : fileNameText);
          identityImages.add(file);
          multipartList.add(MultipartBody('files[]', file));

          update();
        },
      );
    } else {
      // المستخدم لغى الاختيار
      print("No file selected");
    }
  }

  resetImageData (){
     multipartList.clear();
     identityImages.clear();
     filesNames.clear();
   }

  void removeImage(int index) {
    identityImages.removeAt(index);
    filesNames.removeAt(index);
    multipartList.removeAt(index);
    update();
  }
  receivedShipments(String requestName , String type) async {
    LoginResponsModel user = await AuthController().getLoginData();
    var shipmentsId = StringBuffer();
      print(selectedShipments.length) ;
    for( int i  =  0 ; i <selectedShipments.length  ;  i ++){
      print(selectedShipments[i].requestId) ;
      shipmentsId.write(selectedShipments[i].requestId ) ;
      if(i != selectedShipments.length-1){
      shipmentsId.write(',') ;}

    }
    final FingerPrintController fingerPrintController = Get.put(FingerPrintController());
 double lat  = fingerPrintController.currentEmployeeLocation!.latitude ;
 double long  = fingerPrintController.currentEmployeeLocation!.longitude ;
    String url = "${requestName}?id=${user.id!}&stat_o=${type}&lat=${lat}&long=${long}&request_ids=${shipmentsId.toString()}";
    print(url);
    var response = await api.getData(url: url);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var data = jsonDecode(response.body);
      print(data["success"]);
      if (data["success"]) {
showOkDialog(context: Get.context!, message: data["msg"], isCancelBtn: false , onOkClick: (){
   if(type  == AppConstants.waiting) {
      pageWaiting  = 1  ;
     onRefreshUi!(); // استدعاء الفانكشن في الشاشة

   }if(type  == AppConstants.processing) {
      pageProcessing  = 1  ;
     onRefreshUi!(); // استدعاء الفانكشن في الشاشة

   }
})  ;

// selectedShipments .clear()  ;
// selectedIndexes .clear()  ;
      }

    }
    else {
     showCustomSnackBar('Failed to load data!');
    }

  }

  driverDeliveredShipment() async {
    isLoading = true;
    update();
    Api api = Api();
    LoginResponsModel user = await AuthController().getLoginData();
    var shipmentsId = StringBuffer();
    print(selectedShipments.length) ;
    for( int i  =  0 ; i <selectedShipments.length  ;  i ++){
      print(selectedShipments[i].requestId) ;
      shipmentsId.write(selectedShipments[i].requestId ) ;
      if(i != selectedShipments.length-1){
        shipmentsId.write(',') ;}

    }
    final FingerPrintController fingerPrintController = Get.put(FingerPrintController());
    double lat  = fingerPrintController.currentEmployeeLocation!.latitude ;
    double long  = fingerPrintController.currentEmployeeLocation!.longitude ;
    String url = "${AppConstants.receivedDriverShipment}?id=${user.id!}&stat_o=${AppConstants.processing}&lat=${lat}&long=${long}&request_ids=${shipmentsId.toString()}";
    print(url);
    Map<String, dynamic> body = <String, dynamic>{};
    for (int i = 0; i < filesNames.length; i++) {
      body['file_name[$i]'] = filesNames[i];
    }
    var request = http.MultipartRequest(
        "POST", Uri.parse(AppConstants.baseUrl + url));
    request.fields
        .addAll(body.map((key, value) => MapEntry(key, value.toString())));
    for (MultipartBody multipart in multipartList) {
      if (multipart.file != null) {
        Uint8List list = await multipart.file!.readAsBytes();
        request.files.add(http.MultipartFile(
          multipart.key,
          multipart.file!.readAsBytes().asStream(),
          list.length,
          filename: multipart.file!.path.split('/').last,
        ));
      }
    }
    print(request.fields);
    print(request.url);
    print("request.files.length");
    print(request.files.length);
    print(request.files.length);

    // Send the request or further handle it
    var response = await request.send();

    isLoading = false;
    update();

    // Handle response as needed
    if (response.statusCode == 200) {
      print(response);

      showOkDialog(
          context: Get.context!,
          message: 'added_to_requests_permission'.tr,
          isCancelBtn: false,
          onOkClick: () {
            pageProcessing  = 1  ;
            onRefreshUi!(); // استدعاء الفانكشن في الشاشة
          });
      // Success handling
    } else {
      print("error");
      showOkDialog(
          context: Get.context!,
          message: 'try again',
          isCancelBtn: false,
          onOkClick: () {
            onRefreshUi!(); //
          }
      );

      update();
      // Error handling
    }
  }

  Future<dynamic> getShipments(String requestName , {String? type  , int? pageCount}) async {
    isLoading = true;
    if (pageWaiting == 1) waitingList.clear();
    if (pageProcessing == 1) processingList.clear();
    if (pageFinishing == 1) finishList.clear();
   if (page == 1) allList.clear();
    //if (pageCancel == 1) cancelList.clear();*/
    List <Shipment> filterData = []  ;

    update();
    LoginResponsModel user = await AuthController().getLoginData();
    String url = "${requestName}?id=${user.id!}&count=${page}";
    if(type!= null){
      url = "${requestName}?id=${user.id!}&count=${pageCount}&stat_o=${type}"
      ;}

    // String url = "/show_request_limit_api.php?id=271562&count=${page}";
    print(url);
    var response = await api.getData(url: url);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var data = jsonDecode(response.body);
      print(data["success"]);
      if (data["success"]) {
        SharedPreferences sharedPreferences = Get.find();
        String languageCode =
            sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'ar';
        Locale currentLocale = Localizations.localeOf(Get.context!);
        // String languageCode = currentLocale.languageCode; // 'en' for English, 'ar' for Arabic
        print(languageCode);
        var dataArr = data["data"] as List;

       if(type == AppConstants.waiting){
         waitingList.addAll(
             dataArr.map((e) => Shipment.fromJson(e, languageCode: languageCode))
          );
          pageWaiting++  ;
          filterData = waitingList  ;
        }
        else if(type  ==  AppConstants.processing){
          processingList.addAll(
              dataArr.map((e) =>Shipment.fromJson(e, languageCode: languageCode))
          );
          pageProcessing++  ;
          filterData = processingList  ;

       } else if(type  ==  AppConstants.finished){
          finishList.addAll(
              dataArr.map((e) => Shipment.fromJson(e, languageCode: languageCode))
          );
          pageFinishing++  ;
          filterData = finishList  ;

       }
       else{
          allList.addAll(
              dataArr.map((e) => Shipment.fromJson(e, languageCode: languageCode))
          );
          page++ ;
          filterData = allList;
       }
        isLoading = false;
        if (dataArr.length < 10) hasMore = false;

        update(); // Ensure UI is updated after loading state changes
        return filterData;
      }
    } else {
      throw Exception('Failed to load data!');
    }
  }
  Future<dynamic> getDetails(String id, {bool fromPriceOffer = false}) async {
    shipmentDetails.clear();
    isLoading = true;
    update();
    String url;
      url = "${AppConstants.details}?id=${id}";
    print(url);

    var response = await api.getData(url: url);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var data = jsonDecode(response.body);
      print(data["success"]);
      if (data["success"]) {
        var dataArr = data["data"] as List;
        shipmentDetails =
            dataArr.map((e) => Shipment.fromJsonDetails(e)).toList();

        // if(fromPriceOffer){
        //   shipmentDetails = dataArr.map((e) => ModelBooking.fromJsonPriceOfferDetails(e)).toList();
        //
        // }
        // else{
        // shipmentDetails = dataArr.map((e) => ModelBooking.fromJsonDetails(e)).toList();}
        isLoading = false;

        update();

        return shipmentDetails;
      } else {
        isLoading = false;

        update();
      }
    } else {
      throw Exception('Failed to load data!');
    }
  }

  int bgColor = 0xFFEEFCF0;
  Color textColor = Colors.red;
  String getState(Shipment model) {
    if (model.stop == "1") {
      bgColor = 0xFFFFF3F3;
      textColor = Colors.red;
      // update() ;
      return model.stateTxt = "CANCELED".tr;
    } else if (model.requestState == "1") {
      bgColor = 0xFFF0F8FF;
      textColor = Colors.blue;
      //  update() ;
      return model.stateTxt = "processing".tr;
    } else {
      bgColor = 0xFFEEFCF0;
      textColor = Colors.green;
      // update() ;

      return model.stateTxt = "active".tr;
    }
  }
}
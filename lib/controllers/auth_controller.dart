import 'dart:convert';
import 'dart:developer';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/api/api_services.dart';
import 'package:betakety_app/firebase_notification/push_notification_services.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/personal_data.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:betakety_app/view/screens/auth/widget/otp_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mac_address/mac_address.dart';
//import 'package:platform_device_id/platform_device_id.dart';

import '../view/screens/auth/auth_screen.dart';
import '../view/base/custom_snackbar.dart';
import '../view/screens/home/nav_screen.dart';

class AuthController extends GetxController {


  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int _selectedIndex = 0;
   String approved = "0" ;
   String total = "0" ;
   String payed = "0" ;
  int get selectedIndex => _selectedIndex;
  Api api = Api();
  String employeeId  = "" ;
  List<PersonalData> personalDataList = [];
  bool hasMinLength = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasSpecialChar = false;
  TextEditingController? passwordController = TextEditingController();
  TextEditingController? confirmPasswordController = TextEditingController();
  bool get isPasswordValid =>
      hasMinLength && hasUpperCase && hasLowerCase && hasSpecialChar;
  void logout() async{
    // authRepo.logout()
  await  clearUserLogin();
    Get.offAll(const AuthScreen());
  }
  void validatePassword(String password) {
    hasMinLength = password.length >= 6;
    hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
    hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
    hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    update(); // علشان الـ UI يتحدث
  }

  void login({required String email, required String password}) async {
    _isLoading = true;
    update();
    APIService apiService = APIService();
    String mobileMac = await FlutterUdid.udid;

    // String? mobileMac = await PlatformDeviceId.getDeviceId;


    print(mobileMac);
    LoginReqModel user1 = LoginReqModel(
        password: password, username: email, mobileMac: mobileMac);
    LoginResponsModel res = await apiService.login(user1);
    print(res);
    if (res.success == true) {
      saveUserData(res);
    } else {
      showCustomSnackBar(res.message!);
    }
    _isLoading = false;
    update();
  }
resetData(){
    passwordController!.clear();
    confirmPasswordController!.clear();
     hasMinLength = false;
     hasUpperCase = false;
     hasLowerCase = false;
     hasSpecialChar = false;
     _isLoading  =false  ;
     update();
  }
  Future<dynamic> getRequiredData() async {
    personalDataList.clear();
    LoginResponsModel user = await getLoginData();
    String url = "${AppConstants.requiredFiles}?id=${user.id!}";
    print(url);
    var response = await api.getData(url: url);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var data = jsonDecode(response.body);
      print(data["status"]);
      if (data["status"] == "success") {
        var dataArr = data["data"] as List;
        personalDataList.addAll(dataArr.map((e) => PersonalData.fromJson(e)));
        return personalDataList;
      }
      else {
        showCustomSnackBar("try_again".tr);
      }
      update();
    } else {
      showCustomSnackBar("try_again".tr);
    }
  }
  Future<dynamic> getEmployeeRewards() async {
    personalDataList.clear();
    LoginResponsModel user = await getLoginData();
    String url = "${AppConstants.employeeRewards}?employ_id=${user.id!}";
    print(url);
    var response = await api.getData(url: url);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var data = jsonDecode(response.body);
      print(data["status"]);
      if (data["status"]) {
        var dataObj = data["data"] ;
        approved= dataObj["approved_total"].toString();
        payed= dataObj["paid_total"].toString();
        total= dataObj["grand_total"].toString();


      }
      else {
        showCustomSnackBar("try_again".tr);
      }
      update();
    } else {
      showCustomSnackBar("try_again".tr);
    }
  }
  saveUserData(LoginResponsModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'response_data', json.encode(user.toJson()));
    await prefs.setBool('is_logged_in', true);

    await prefs.setString(
        'user', json.encode(user.toJson()));
      await PushNotificationService().init();
      Get.offAll(const NavBarScreen());

  }

  clearUserLogin() async {
    await deactivateToken() ;
    await FirebaseMessaging.instance.deleteToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
    prefs.remove("response_data");
    await prefs.setBool('is_logged_in', false);
  }

  saveHeader(String header) {
    // authRepo.saveHeader(header);
  }

  String _getReqHeader() {
    // return authRepo.getHeader();
    return "";
  }

  Map<String, String>? getHeader() {
    if (json.decode(_getReqHeader()) != '') {
      return (json.decode(_getReqHeader()) as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value.toString()));
    } else {
      return null;
    }
  }

  validateSignUpData(String nameEn, String userName, String nameAr,
      String email, String password, String phone) {
    if (nameAr.isEmpty) {
      showCustomSnackBar('NAME_FIELD_MUST_BE_REQUIRED'.tr);
    }
    else if (nameEn.isEmpty) {
      showCustomSnackBar('NAME_FIELD_MUST_BE_REQUIRED'.tr);
    } else if (userName.isEmpty) {
      showCustomSnackBar('USER_NAME_REQUIRED'.tr);
    } else if (email.isEmpty) {
      showCustomSnackBar('EMAIL_MUST_BE_REQUIRED'.tr);
    } else if (password.isEmpty) {
      showCustomSnackBar('PASSWORD_MUST_BE_REQUIRED'.tr);
    }
    else {
      signUp(nameEn, userName, nameAr, email, password, phone);
    }
  }

  signUp(String nameEn, String userName, String nameAr, String email,
      String password, String phone) async {
    _isLoading = true;
    update();
    Api api = Api();
    LoginResponsModel signup = LoginResponsModel(nameAr: nameAr,
        nameEn: nameEn,
        email: email,
        mobilenumber: phone,
        password: password,
        userName: userName);
    final response = await api.postData(
        uri: AppConstants.signupUrl, map: signup.signUpToJson());
    if (response.statusCode == 200) {
      print(response.body);
      var res = jsonDecode(response.body);
      bool success = res["success"];

      _isLoading = false;
      if (success) {
        showOkDialog(context: Get.context
        !,
            message: 'sign_up_successfully_now_login'.tr,
            isCancelBtn: false,
            onOkClick: () {
              Navigator.of(Get.context!).pop();
            });
      } else {
        showOkDialog(context: Get.context
        !, message: 'try again', isCancelBtn: false, onOkClick: () {});
      }

      update();
    }
    {
      _isLoading = false;
      update();
      print(response.statusCode);
    }
  }

  // String _getUserData() {
  //   return authRepo.getUserData();
  // }

  // LoginResponsModel? getUserData() {
  //   if (json.decode(_getUserData()) != '') {
  //     return (LoginResponsModel.fromJson(json.decode(_getUserData())));
  //   } else {
  //     return null;
  //   }
  // }

  // bool isLogin() {
  //   return authRepo.isLoaging();
  // }
  Future<LoginResponsModel> getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsModel user = LoginResponsModel.fromJson(
        json.decode(prefs.getString("user")!));
    return user;
  }

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
      // Get.dialog(const PermissionDialog());
    } else {
      onTap();
    }
  }

  Future<void> forgetPassword({required String phone}) async {
    Api api = Api();
    SharedPreferences sharedPreferences = Get.find();

    String languageCode =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'ar';
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_number'] = phone;

    final response = await api.postData(
        uri: "${AppConstants.forgetPassword}", map: data);
    if (response.statusCode == 200) {
      print("return data  " + response.body);
      var res = jsonDecode(response.body);
      bool success = res["success"];
       employeeId = res["employ_id"].toString();

      if (success) {
        print("done");
        showDialog(
          context: Get.context!,
          builder: (_) => Directionality(
            textDirection: TextDirection.ltr,
            child: OtpDialog(res["otp_code"]),
          ),
        );
      } else {

        showCustomSnackBar(languageCode=="en" ? res["message_en"]:res["message_ar"]);
      }
    }
  }

  Future<void> resetPassword() async {
     _isLoading = true  ;
     update() ;
    Api api = Api();
    final Map<String, dynamic> data = <String, dynamic>{};
    data['new_password '] = passwordController!.text;
    data['employ_id '] = employeeId;

    final response = await api.postData(
        uri: "${AppConstants.resetPassword}", map: data);
    if (response.statusCode == 200) {
      print("return data  " + response.body);
      var res = jsonDecode(response.body);
      bool success = res["success"];
_isLoading  = false  ;
 update();
      if (success) {
        print("done");

       //go to login with new password
         showOkDialog(context: Get.context
        !,
            message: res["message_ar"],
            isCancelBtn: false,
            onOkClick: () {
         Navigator.pushReplacement(Get.context!, MaterialPageRoute(builder: (context) => const AuthScreen()));});
      } else {
        showCustomSnackBar(res["message_ar"]);
      }
    }
  }
  Future<void> saveToken({required String token}) async {
    Api api = Api();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    await prefs.setString('fcm_token', token);
    data['user_id'] = user.id;
    data['fcm_token'] = token;

    final response = await api.postData(
        uri: AppConstants.saveNotificationToken, map: data , isNotification: true);
    if (response.statusCode == 200) {
      print("return data  " + response.body);
      var res = jsonDecode(response.body);
     print(res["message"]) ;
    }
  }  Future<void> deactivateToken() async {
    Api api = Api();
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    data['user_id'] = user.id;
    data['fcm_token'] =  prefs.getString("fcm_token");

    final response = await api.postData(
        uri: AppConstants.deactivateToken, map: data , isNotification: true);
    if (response.statusCode == 200) {
      print("return data  " + response.body);
     // var res = jsonDecode(response.body);
    // print(res["message"]) ;
    }
  }



}

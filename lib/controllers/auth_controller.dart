import 'dart:convert';
import 'dart:developer';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/api/api_services.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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
  int get selectedIndex => _selectedIndex;

  void logout() {
    // authRepo.logout()
 clearUserLogin() ;
    Get.offAll(const AuthScreen());
  }

  void login({required String email, required String password}) async {
    _isLoading = true;
    update();
    APIService apiService = APIService();
     String mobileMac = await FlutterUdid.udid;

   // String? mobileMac = await PlatformDeviceId.getDeviceId;


print(mobileMac) ;
    LoginReqModel user1 =  LoginReqModel(password:password , username: email , mobileMac:mobileMac );
    LoginResponsModel res = await apiService.login(user1);
        print(res);
     if (res.success == true ) {
       saveUserData(res);

     } else {
      showCustomSnackBar(res.message!);
    }
    _isLoading = false;
     update();
  }
 saveUserData(LoginResponsModel user )async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              'response_data', json.encode(user.toJson()));
   await prefs.setBool('is_logged_in', true);

   await prefs.setString(
              'user', json.encode(user.toJson())).then((value) {
     Get.offAll(const NavBarScreen());


   });

 }clearUserLogin( )async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("user") ;
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
validateSignUpData(String nameEn , String userName , String nameAr , String email , String password ,String phone){
  if (nameAr.isEmpty) {
    showCustomSnackBar('NAME_FIELD_MUST_BE_REQUIRED'.tr);
  }
  else if (nameEn.isEmpty) {
    showCustomSnackBar('NAME_FIELD_MUST_BE_REQUIRED'.tr);
  }else if (userName.isEmpty) {
    showCustomSnackBar('USER_NAME_REQUIRED'.tr);
  }else if (email.isEmpty) {
    showCustomSnackBar('EMAIL_MUST_BE_REQUIRED'.tr);
  } else if (password.isEmpty) {
    showCustomSnackBar('PASSWORD_MUST_BE_REQUIRED'.tr);
  }
  else{
    signUp(nameEn, userName, nameAr, email, password, phone) ;
  }

}
signUp(String nameEn , String userName , String nameAr , String email , String password ,String phone) async {
  _isLoading = true;
  update();
  Api api = Api() ;
  LoginResponsModel signup = LoginResponsModel(nameAr:nameAr ,nameEn: nameEn ,email:  email , mobilenumber: phone , password:  password , userName:  userName) ;
  final response = await api.postData(uri: AppConstants.signupUrl, map: signup.signUpToJson()) ;
  if(response.statusCode ==200){
    print(response.body) ;
     var res  =jsonDecode(response.body) ;
     bool success = res["success"] ;

    _isLoading = false;
    if(success)
      {
    showOkDialog(context: Get.context
    !,message: 'sign_up_successfully_now_login'.tr ,isCancelBtn: false ,onOkClick:(){
      Navigator.of( Get.context!).pop();});
      }else{
      showOkDialog(context: Get.context
      !,message: 'try again' ,isCancelBtn: false ,onOkClick:(){
    });}

    update();
  }
  {
    _isLoading = false;
    update();
    print(response.statusCode) ;
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
    LoginResponsModel user = LoginResponsModel.fromJson(json.decode(prefs.getString("user")!));
return user ;
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
}

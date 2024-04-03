import 'dart:convert';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/model/account.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/salary.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController{

  Api api = Api()  ;
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  //TextEditingController dateController = TextEditingController();
  List <dynamic>posts = [];
  bool loader  = false;
  bool result = false  ;
  Salary? salary  ;

  Future<void> validateFieldsAndShowSnackbar() async {
    if (dateToController.text.isEmpty) {
      showCustomSnackBar("${'date_from'.tr} ${"is_required".tr}");
    } else if (dateToController.text.isEmpty) {
      showCustomSnackBar("${'date_to'.tr} ${"is_required".tr}");}
    else {
    posts =  await getAttendanceDetails() ;
    }
  }
  Future<String> getShiftData() async {
    LoginResponsModel user = await AuthController().getLoginData();
    String url = "${AppConstants.getShift}?employ_id=${user.id!}";
    var response  = await  api.getData(url: url)  ;
    print(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) ;
      return  data["shift_name_ar"] ;
    }
    else{
      return  "";

    }
  }
    Future<List<dynamic>> getAttendanceDetails() async {
    loader = true;
    update()  ;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    String url  =  "${AppConstants.attendanceDetails}?employ_id=${user.id!}&date_from=${dateFromController.text}&date_to=${dateToController.text}"   ;
    print(url) ;

    var response  = await  api.getData(url: url)  ;

    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      var data = jsonDecode(response.body) ;
      print(data["success"]);

      if(data["success"]){
        result  = true  ;
        loader = false;
        update() ;
        return  data["data"] ;

      }
      else{
        loader = false;

        result  = false  ;
        update() ;
        throw Exception('Failed to load data!');

      }

    }
    else {
      loader = false;
      result  = false  ;
      update() ;
      throw Exception('Failed to load data!');
    }

  }

}
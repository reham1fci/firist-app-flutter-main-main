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

class SalaryController extends GetxController{

  Api api = Api()  ;
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  //TextEditingController dateController = TextEditingController();
  List posts = [];
  bool loader  = false;
  bool result = false  ;
  Salary? salary  ;

  Future<void> validateFieldsAndShowSnackbar() async {
    if (dateToController.text.isEmpty) {
      showCustomSnackBar("${'date_from'.tr} ${"is_required".tr}");
    } else if (dateToController.text.isEmpty) {
      showCustomSnackBar("${'date_to'.tr} ${"is_required".tr}");}
     else {
      getSalaryDetails() ;
    }
  }
  Future<dynamic> getSalaryDetails() async {
    loader = true;
    update()  ;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
   String url  =  "${AppConstants.employeeSalary}?employ_id=${user.id!}&date_from=${dateFromController.text}&date_to=${dateToController.text}&employ_type=${user.loginType}"   ;
    //String url  =  "/Employ_Salary_api.php?employ_id=662918&date_from=2024-01-01&date_to=2024-01-31&employ_type=office";
    print(url) ;

      var response  = await  api.getData(url: url)  ;

      if (response.statusCode == 200) {

        print(jsonDecode(response.body));
        var data = jsonDecode(response.body) ;
        print(data["success"]);

        if(data["success"]){
          result  = true  ;
          if(user.loginType == "office_employee") {
            salary = Salary.fromJsonEmployee(data);
            update() ;

          }
          else{
            print("done") ;
            salary = Salary.fromJson(data);
             print(salary.toString()) ;
            update() ;

          }
          loader = false;
          update() ;
          return salary  ;

        }
        else{
          result  = false  ;
          update() ;
          throw Exception('Failed to load data!');

        }

        }
         else {
        throw Exception('Failed to load data!');
      }

  }

}
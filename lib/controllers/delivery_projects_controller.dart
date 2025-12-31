import 'dart:convert';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/model/day_item.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/login_model.dart';
import '../util/app_constants.dart';
import '../view/base/custom_lert_dialog.dart';
import 'auth_controller.dart';

class DeliveryProjectController  extends GetxController{

  Api api = Api()  ;
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  //TextEditingController dateController = TextEditingController();
  List <DayItem>dailyProjects = []  ;
  bool loader  = false;
  DayItem? totalProject  ;
  resetData() {
     dailyProjects.clear()  ;
     totalProject = null ;
     dateFromController.clear();
     dateToController.clear();
  }
    Future<void> validateFieldsAndShowSnackbar() async {
    if (dateToController.text.isEmpty) {
      showCustomSnackBar("${'date_from'.tr} ${"is_required".tr}");
    } else if (dateToController.text.isEmpty) {
      showCustomSnackBar("${'date_to'.tr} ${"is_required".tr}");}
    else {
      await getDailyProject() ;
    }
  }
  Future<void> getDailyProject() async {
    loader = true;
    update()  ;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    String url  =  "${AppConstants.dailyProject }?employ_id=${user.id!}";
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_from'] =dateFromController.text;
    data['date_to'] = dateToController.text;
    print(url) ;

    final response = await api.postData2(uri:url, map: data) ;

    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      var data = jsonDecode(response.body) ;
      print(data["status"]);

      if(data["status"]=="success"){
        loader = false;
         var dataArr = data["daily_projects"] as List;
         var totalProjects = data["total_projects"] ;
        totalProject = DayItem.fromJsonTotal(totalProjects) ;
        dailyProjects = dataArr.map((e) => DayItem.fromJson(e)).toList();

        update() ;
      //  return  data["data"] ;
return   ;
      }
      else{
        loader = false;

        update() ;
        throw Exception('Failed to load data!');

      }

    }
    else {
      loader = false;
      update() ;
      throw Exception('Failed to load data!');
    }

  }
Future<dynamic> getMonthlyData(String month , String year) async {
    loader = true;
    update()  ;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    String url  =  "${AppConstants.monthlyEvaluation }?employ_id=${user.id!}";
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_select'] =month;
    data['year_select'] = year;
    print(url) ;

    final response = await api.postData2(uri:url, map: data) ;

    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      var result = jsonDecode(response.body) ;
      print(result["status"]);

      if(result["status"]=="success"){
        loader = false;
         var  data = result["data"] ;
         var employeeData = data["employee_info"] ;
         user = LoginResponsModel.employeeInfo(employeeData) ;
        update() ;
      //  return  data["data"] ;
return  data ;
      }
      else{
        loader = false;

        update() ;
        throw Exception('Failed to load data!');

      }

    }
    else {
      loader = false;
      update() ;
      throw Exception('Failed to load data!');
    }

  }

  Future<void> confirmAllProject() async {
    loader = true;
    update()  ;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    String url  =  "${AppConstants.confirmDailyProject }?employ_id=${user.id!}&type=range";
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_from'] =dateFromController.text;
    data['date_to'] = dateToController.text;
    print(url) ;

    final response = await api.postData2(uri:url, map: data) ;

    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      var data = jsonDecode(response.body) ;
      print(data["status"]);

      if(data["status"]=="success"){
        loader = false;


          String message  =  data["msg"] ;
          showOkDialog(context: Get.context!, message: message, isCancelBtn: false,onOkClick: (){

            getDailyProject() ;
            update() ;
          } ,);
          update() ;

        update() ;
        //  return  data["data"] ;
        return   ;
      }
      else{
        loader = false;

        update() ;
        throw Exception('Failed to load data!');

      }

    }
    else {
      loader = false;
      update() ;
      throw Exception('Failed to load data!');
    }

  }
  Future<void> confirmProjectOfDay(String projectDate) async {
    loader = true;
    update()  ;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    String url  =  "${AppConstants.confirmDailyProject }?employ_id=${user.id!}&type=daily";
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_from'] =projectDate;
    print(url) ;

    final response = await api.postData2(uri:url, map: data) ;

    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      var data = jsonDecode(response.body) ;
      print(data["status"]);

      if(data["status"]=="success"){
        loader = false;

       String message  =  data["msg"] ;
        showOkDialog(context: Get.context!, message: message, isCancelBtn: false,onOkClick: (){
          getDailyProject() ;
          update() ;
        });
        update() ;
        //  return  data["data"] ;
        return   ;
      }
      else{
        loader = false;

        update() ;
        throw Exception('Failed to load data!');

      }

    }
    else {
      loader = false;
      update() ;
      throw Exception('Failed to load data!');
    }

  }

}
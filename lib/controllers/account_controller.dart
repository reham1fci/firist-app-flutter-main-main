import 'dart:convert';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/model/account.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:get/get.dart';


class AccountController extends GetxController
{
  Api api = Api()  ;

  Future<dynamic> getAccountStatement() async {
    // data['the_reason'] = theReason
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    data["employ_id"] =user.id;
    String url  =  AppConstants.getAccountBalance+"?"+"employ_id=" +user.id!   ;
    print(url) ;
    try {
      var response  = await  api.getData(url: url)  ;

      if (response.statusCode == 200) {
        print("account");
        print(jsonDecode(response.body));

        return response.body;

      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }
  Future<dynamic> getAccountStatementDetails(Account account) async {
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    String url  =  "${AppConstants.getAccountStatementDetails}?employ_id=${user.id!}&company_id=${account.companyId!}&account_number=${account.accountNum!}"   ;
    print(url) ;
    try {
      var response  = await  api.getData(url: url)  ;

      if (response.statusCode == 200) {
        print("account");
        return(jsonDecode(response.body));

      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:betakety_app/model/requests_permissions_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart'  as http ;
import 'package:intl/intl.dart';
import 'package:http/http.dart';

import '../util/app_constants.dart';

class Api {

  Future<Response> postData({ required String uri ,  required Map map}) async {
    String url =AppConstants.baseUrl+uri;
    print(url);
    print(map);
    final response = await http.post(
      Uri.parse(url),
      headers:{
        'Content-Type': 'application/json',
      'Access-Control-Allow-Origin':"*"},
    body: json.encode(map),
    );
    return response;
  }

  Future <Response> getData({
    required String url })async{

    final response =  await http.get(Uri.parse(AppConstants.baseUrl+url)  ) ;
    print(AppConstants.baseUrl+url);
    return response ;
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {

      return true;
    }
    return false;}


   }
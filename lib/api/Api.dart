
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart'  as http ;
import 'package:intl/intl.dart';
import 'package:http/http.dart';

import '../util/app_constants.dart';

class Api {

  Future<Response> postData({ required String uri ,  required Map map}) async {
    String url =AppConstants.baseUrl+uri;
    print(url);
    Uri urii =
    Uri(scheme: 'https', port: 3000, host: 'marsalogistics.com', path: 'new/hr_marsa_system/ar/api_hr_apps/Login_Api.php'); // to reach this endpoint: 'https://mywebsite.com:3000/folder'

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
    final response =  await http.get(Uri.parse(url)  ) ;
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


    static String getDate(String format){
  var now =  DateTime.now();
  var formatter =  DateFormat(format);
  String formattedDate = formatter.format(now);
  print(formattedDate); // 2016-01-25
  return formattedDate  ;
}}
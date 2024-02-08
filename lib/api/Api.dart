
import 'dart:convert';
import 'package:betakety_app/controllers/language_controller.dart';
import 'package:http/http.dart'  as http ;
import 'package:intl/intl.dart';
import 'package:http/http.dart';

class Api {

  Future<Response> postData({ required String uri ,  required Map map}) async {
    String url =AppConstants.baseUrl+uri;
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(map),
    );
    return response;
  }



  Future <Response> getData({
    required String url })async{
    final response =  await http.get(Uri.parse(url)  ) ;
    return response ;
  }
  


static String getDate(String format){
  var now =  DateTime.now();
  var formatter =  DateFormat(format);
  String formattedDate = formatter.format(now);
  print(formattedDate); // 2016-01-25
  return formattedDate  ;
}}
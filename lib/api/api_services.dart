import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class APIService {
  Future<LoginResponsModel> login(LoginReqModel requestModel) async {
    final response = await postData(uri: AppConstants.loginUri, map: requestModel.toJson()) ;
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }
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
}

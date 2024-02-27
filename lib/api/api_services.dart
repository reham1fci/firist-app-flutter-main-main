import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class APIService {
  Future<LoginResponsModel> login(LoginReqModel requestModel) async {
    Api api  = Api()  ;
    final response = await api.postData(uri: AppConstants.loginUri, map: requestModel.toJson()) ;
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(json.decode(response.body));
      return LoginResponsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

}

import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/view/screens/Requests/widget/permission_request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/custom_app_theme.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class PermissionRequestBody extends StatefulWidget {
  int? selectIndex ;

  PermissionRequestBody({super.key , this.selectIndex});


  @override
  State<PermissionRequestBody> createState() => PermissionRequestState();
}

class PermissionRequestState extends State<PermissionRequestBody> {
  // final AnimationController? animationController;
  bool loader = false;
  Future<dynamic> getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://marsalogistics.com/new/resting/api/show_request_permission_api_mohran.php'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }

  @override
  void initState() {
    _loadData();

    super.initState();
  }

  int slectedTab = 0;

  List<dynamic> get filteredData => _Data.where((request) =>
      widget.selectIndex == 0
          ? request["request_per_stat"] == "0"
          : request["request_per_stat"] != "0").toList();
  List<dynamic> _Data = [];

  _loadData() async {
    setState(() {
      loader = true;
    });
    var data = await  Get.find<PermissionController>().getPermissionsRequests();
    if (data != 'error') {
      setState(() {
        _Data = (data['data'] as List);
      });
    }
    print("1111111111111111111111111111111111111111111111111111111111111");
    print(data);

    setState(() {
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PermissionController>(builder: (co) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loader
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PermissionRequestItem(index ,filteredData) ;
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: filteredData.length),
                ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    });
  }
}

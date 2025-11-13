import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/model/Questions.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:betakety_app/view/screens/Requests/widget/asking_item.dart';
import 'package:betakety_app/view/screens/Requests/widget/permission_request_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/custom_app_theme.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AskingBody extends StatefulWidget {
  int? selectIndex ;
  String? requestName  ;
  AskingBody({super.key , this.selectIndex   ,  this.requestName});


  @override
  State<AskingBody> createState() => AskingState();
}

class AskingState extends State<AskingBody>  {
  // final AnimationController? animationController;
  bool loader = false;
  final PermissionController controller = Get.put(PermissionController());
  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
     controller.refreshCallback = _loadData;
    _loadData();

    super.initState();

  }


  int slectedTab = 0;
  List<Questions>  filteredData = [] ;
  // List<dynamic> get filteredData => _Data.where((request) =>
  // widget.selectIndex == 0
  //     ? request["question_stat"] == "waiting_employee_response" || request["question_stat"] == "Answered_by_the_employee"
  //     : request["question_stat"] =="Absence_was_rejected" || request["question_stat"] == "Absence_was_approved").toList();
  List<Questions> _Data = [];

  _loadData() async {
    setState(() {
      loader = true;
    });
   _Data = await  Get.find<PermissionController>().getQuestionRequest(widget.requestName!);
      setState(() {
filteredData  = _Data  ;
      });

    print("1111111111111111111111111111111111111111111111111111111111111");
    print(filteredData);

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
          getSearchWidget(

            context, searchController,
                () {},
                (value) {
              filterSearch(value);
            },
            onSubmit: (submit) {
              filterSearch(submit);
            },),
               Expanded(
            child:loader? const Center(child: CircularProgressIndicator()): ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AskingItem(index ,filteredData) ;
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
  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredData = List.from(_Data);
      });
    } else {
      setState(() {
        filteredData = _Data.where((item) {
          final searchLower = query.toLowerCase();
          final id = item.reply?.toString().toLowerCase() ?? "";
          final name = item.date?.toLowerCase() ?? "";
          return id.contains(searchLower) || name.contains(searchLower);
        }).toList();
      });
    }
  }
}

import 'package:betakety_app/controllers/maintenance_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:betakety_app/view/screens/Requests/widget/request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MaintenanceBody extends StatefulWidget {
  int? selectIndex ;

  MaintenanceBody({super.key , this.selectIndex });


  @override
  State<MaintenanceBody> createState() => MaintenanceBodyState();
}

class MaintenanceBodyState extends State<MaintenanceBody>  {
  // final AnimationController? animationController;
  bool loader = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _loadData();

    super.initState();

  }


  int slectedTab = 0;
  List<dynamic> filteredData = [];

  List<dynamic> get originalData => _Data.where((request) =>
  widget.selectIndex == 0
      ? request["stat"] == "0"
      : widget.selectIndex == 1 ? request["stat"] =="1":
  request["stat"] =="2" || request["stat"] == "5").toList();
  List<dynamic> _Data = [];

  _loadData() async {
    setState(() {
      loader = true;
    });
    var data = await  Get.find<MaintenanceController>().showMaintenanceRequest(AppConstants.maintenanceRequest);
    if (data != 'error') {
      setState(() {
        _Data = (data['data'] as List);
        filteredData = originalData;
      });
    }
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
                  return RequestItem(index ,filteredData , type: "maintenance_request".tr,) ;
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
        filteredData = List.from(originalData);
      });
    } else {
      setState(() {
        filteredData = originalData.where((item) {
          final searchLower = query.toLowerCase();
          final id = item["request_id"]?.toString().toLowerCase() ?? "";
          final name =item['details'].toLowerCase() ?? "";
          return id.contains(searchLower) || name.contains(searchLower);
        }).toList();
      });
    }
  }
}

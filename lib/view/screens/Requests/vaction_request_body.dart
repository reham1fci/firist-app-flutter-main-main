import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/view/screens/Requests/widget/asking_item.dart';
import 'package:betakety_app/view/screens/Requests/widget/vaction_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class VacationRequestBody extends StatefulWidget {
  int? selectIndex ;

  VacationRequestBody({super.key , this.selectIndex });


  @override
  State<VacationRequestBody> createState() => VacationRequestBodyState();
}

class VacationRequestBodyState extends State<VacationRequestBody>  {
  // final AnimationController? animationController;
  bool loader = false;


  @override
  void initState() {
    _loadData();

    super.initState();

  }


  int slectedTab = 0;

  List<dynamic> get filteredData => _Data.where((request) =>
  widget.selectIndex == 0
      ? request["stat"] == "0"
      : widget.selectIndex == 1 ? request["stat"] =="1":
  request["stat"] =="2" || request["stat"] == "5").toList();
  List<dynamic> _Data = [];

  _loadData() async {
    setState(() {
      loader = true;
    });
    var data = await  Get.find<PermissionController>().getRequests(AppConstants.getVacation);
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
                  return VacationItem(index ,filteredData) ;
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

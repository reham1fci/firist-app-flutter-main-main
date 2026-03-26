import 'package:betakety_app/controllers/localization_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:betakety_app/view/screens/Requests/widget/request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AllRequestsBody extends StatefulWidget {
  int? selectIndex ;

  AllRequestsBody({super.key , this.selectIndex });


  @override
  State<AllRequestsBody> createState() => VacationRequestBodyState();
}

class VacationRequestBodyState extends State<AllRequestsBody>  {
  // final AnimationController? animationController;
  bool loader = false;
  Locale? myLocale  ;

  @override
  void initState() {
    _loadData();

    super.initState();

  }

  TextEditingController searchController = TextEditingController();

  int slectedTab = 0;
  List<dynamic> filteredData = [];

  List<dynamic> get filteredData2 => _Data.where((request) =>
  widget.selectIndex == 0
      ? request["stat"] == "0"
      : widget.selectIndex == 1 ? request["stat"] =="1":
  request["stat"] =="2" || request["stat"] == "5").toList();
  List<dynamic> _Data = [];

  _loadData() async {
    setState(() {
      loader = true;
    });
    var data = await  Get.find<PermissionController>().getRequests(AppConstants.getAllRequests);
    if (data != 'error') {
      setState(() {
        _Data = (data['data'] as List);
        filteredData = filteredData2;
      });
    }
    print(data);

    setState(() {
      loader = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    myLocale= Get.find<LocalizationController>().locale;
print(myLocale!.languageCode) ;
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
                  return RequestItem(index ,filteredData ,type:  myLocale!.languageCode == "en"? filteredData[index]['type_title_en']:filteredData[index]['type_title_ar']) ;
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
        filteredData = List.from(filteredData2);
      });
    } else {
      setState(() {
        filteredData = filteredData2.where((item) {
          final searchLower = query.toLowerCase();
          final id = item["request_id"]?.toString().toLowerCase() ?? "";
          final name =  myLocale!.languageCode == "en"? item['type_title_en']:item['type_title_ar'].toLowerCase() ?? "";
          return id.contains(searchLower) || name.contains(searchLower);
        }).toList();
      });
    }
  }
}

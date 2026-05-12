import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/model/maintenance_attachment.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:betakety_app/view/base/loading_dialog.dart';
import 'package:betakety_app/view/screens/Requests/widget/attach_view.dart';
import 'package:betakety_app/view/screens/Requests/widget/attachment.dart';
import 'package:betakety_app/view/screens/Requests/widget/justification.dart';
import 'package:betakety_app/view/screens/shipments/widgets/attachments_list.dart';
import 'package:betakety_app/view/screens/shipments/widgets/trip_processing.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../util/app_constants.dart';
import '../../../base/objection_dialog.dart';

class TripItem extends StatelessWidget{
  int index ;
  String? type ;
  List<dynamic>  filteredData ;

  TripItem(this.index, this.filteredData, {this.type});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    SharedPreferences sharedPreferences = Get.find();
    String languageCode =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'ar';
    return GetBuilder<PermissionController>(builder: (pController) {

      return Padding(
        padding: const EdgeInsets.only(
            left: 8, right: 8, top: 8, bottom: 8),
        child:Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔷 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${filteredData[index]['request_id']} - ${type ?? filteredData[index]['type']}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  buildStatusBadge(languageCode=="ar"?filteredData[index]['stat_ar']:filteredData[index]['stat_en']),
                ],
              ),

              SizedBox(height: 8),

              /// 🕒 Date
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey),
                  SizedBox(width: 5),
                  Text(
                    filteredData[index]['createdDate_time'],
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              SizedBox(height: 10),

              /// 📍 From / To
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("from".tr  + (languageCode == "ar" ? "  :${filteredData[index]['city_name_from_ar']}:" : ":${filteredData[index]['city_name_from_en']}"),
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text("to".tr+ (languageCode == "ar" ? "  :${filteredData[index]['city_name_to_ar']}:" : ":${filteredData[index]['city_name_to_en']}"),
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),

              SizedBox(height: 10),

              /// 📝 Details
              Text(
                filteredData[index]['details'],
                style: TextStyle(color: Colors.grey[700]),
              ),

              SizedBox(height: 12),

              /// 🔘 Buttons Row
              Row(
                children: [

                  /// 📎 Attachments
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        List<String>attachments  =[] ;
                        var attachList  = filteredData[index]['attach_link']as List  ;
                   //     attach_url  = attachList[0]["attach_link"] ;
                        for (var item in attachList) {
                        attachments.add(item["attach_link"]);
                        }
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AttachmentsListScreen(attachments: attachments)));

                      },
                      icon: Icon(Icons.attach_file, size: 18),
                      label: Text("attachments".tr),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(width: 8),

                  /// ⚙️ Process Button (الجديد 🔥)
            filteredData[index]["stat"] =="0"?     Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showOkDialog(
                          context: context,
                          message: "want_to_process_request".tr,
                          onOkClick: () async {
                            showLoadingDialog(context , message: "confirm_location".tr+"......") ;

                            Position currentLocation = await pController.getCurrentLocation();
                         pController.checkLocation(onSuccess: (){
                           Navigator.pop(context);

                           Navigator.push(context , MaterialPageRoute(builder: (context)=>TripProcessing(levelId:
                           filteredData[index]['level_id'] , levelNum: filteredData[index]['level'] ,requestId: filteredData[index]['request_id']
                           ) ));
                         }) ;

                          },
                          isCancelBtn: true,
                        );
                      },
                      icon: Icon(Icons.settings, size: 18),
                      label: Text(languageCode=="ar"?filteredData[index]['level_stat_details_ar']:filteredData[index]['level_stat_details_en']),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ):SizedBox(),

                  SizedBox(width: 8),

                  /// ✅ Arrival (لو موجود)

                ],
              )
            ],
          ),
        )
      );
    });

  }
  Widget buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case "مقبول":
        color = Colors.green;
        break;
      case "مرفوض":
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

}
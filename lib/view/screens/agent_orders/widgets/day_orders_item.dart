import 'package:betakety_app/controllers/delivery_projects_controller.dart';
import 'package:betakety_app/controllers/localization_controller.dart';
import 'package:betakety_app/model/day_item.dart';
import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/screens/Requests/widget/insert_justification_view.dart';
import 'package:betakety_app/view/screens/agent_orders/insert_exception_view.dart';
import 'package:betakety_app/view/screens/agent_orders/widgets/project_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/custom_lert_dialog.dart';

class DayOrdersItem extends StatelessWidget {
  final DayItem day;
  bool isTotalProject  = false;
   DayOrdersItem({required this.day,required this.isTotalProject, super.key});
  Locale? myLocale  ;

  @override
  Widget build(BuildContext context) {
    myLocale= Get.find<LocalizationController>().locale;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(day.dateLabel!, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('${"targets".tr} ${day.total}', style: const TextStyle(color: Colors.grey)),
       if(!isTotalProject)     Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: day.confirmed!? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                day.confirmed! ? "confirmed".tr : "not_confirmed".tr,
                style: TextStyle(
                  color: day.confirmed! ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        children: [
          // Header row (العنوان بتاع الأعمدة)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Expanded(child: Text("project".tr, textAlign: TextAlign.start)),
               // SizedBox(width: 8,),
                SizedBox(width: 60, child: Text('order_number'.tr, textAlign: TextAlign.center)),
                SizedBox(width: 8,),
                SizedBox(width: 60, child: Text('delivery_price'.tr, textAlign: TextAlign.center)),
                SizedBox(width: 90, child: Text('details'.tr, textAlign: TextAlign.end)),
              ],
            ),
          ),
          const Divider(height: 1),
          // List of projects
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: day.projects!.length,
         //   separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final p = day.projects![i];
              return ProjectItem(project: p);
            },
          ),
          if ((day.exceptionEn ?? "").trim().isNotEmpty)
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  child:  Row(
    children: <Widget>[
    Text(
    'exception_status'.tr,
    textAlign: TextAlign.center,
    // ignore: prefer_const_constructors
    style: TextStyle(
    // fontFamily:
    //     FitnessAppTheme.fontName,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    letterSpacing: -0.2,
    color: CustomAppTheme.darkText,
    ),
    ),
    Text(
      myLocale!.countryCode=="en"? day.exceptionEn! : day.exceptionAr!,
    textAlign: TextAlign.center,
    style: TextStyle(
    // fontFamily:
    //     FitnessAppTheme.fontName,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    color: Colors.red
        .withOpacity(0.5),
    ),
    ),])),
       isTotalProject ?    CustomButton(buttonText: "confirm_all" .tr, onPressed: (){
         showOkDialog(context: Get.context!, message: "confirm_project".tr, isCancelBtn: true,onOkClick: (){
           Get.find<DeliveryProjectController>().confirmAllProject() ;
         });

       },
         //    buttonColor: Colors.green,
       ) :   Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            CustomButton(buttonText: "daily_confirmation" .tr, width: 100,onPressed: (){
              showOkDialog(context: Get.context!, message: "confirm_project".tr, isCancelBtn: true,onOkClick: (){
                Get.find<DeliveryProjectController>().confirmProjectOfDay(day.dateLabel!) ;
              });

           //   Get.find<DeliveryProjectController>().confirmProjectOfDay(day.dateLabel!) ;
              },
          //    buttonColor: Colors.green,
            ) ,
            CustomButton(buttonText: "exception".tr , width: 100,onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => InsertExceptionView(date: day.dateLabel,)))      ;

            },) ,
        /*    CustomButton(buttonText: "revision".tr , width: 100,
            //  buttonColor: Colors.green,
            ) ,*/

          ],)
        ],
      ),
    );
  }

}

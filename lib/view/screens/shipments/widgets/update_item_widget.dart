import 'package:betakety_app/model/shipment.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'update_option_screen.dart';

class UpdateItemWidget extends StatelessWidget {
   Updates? updates  ;

   UpdateItemWidget(this.updates);
   String languageCode  ="ar";

  @override
  Widget build(BuildContext context) {
    SharedPreferences sharedPreferences = Get.find() ;
    languageCode  = sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'ar' ;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(updates!.date!),
              Text(updates!.time!),
            ],
          ),
          SizedBox(width: 8), // Space between date/time and dot icon
          Column(
            children: [
              Image.asset(
                Images.dot_icon,
                height: 20,
                width: 20,
              ),
              Container(
                width: 2, // Width of the divider
                height: 50, // Adjust height as needed
                color: Colors.grey, // Color of the divider
              ),
            ],
          ),
          SizedBox(width: 8), // Space between dot icon and title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(languageCode=="ar"?updates!.name!:updates!.nameEn!),
                Text(languageCode=="ar"?updates!.details!:updates!.detailsEn!),
                // You can add other text or widgets here if needed
              ],
            ),
          ),
          TextButton(child: Text('details'.tr , style: TextStyle(color:Theme.of(context).primaryColor),),onPressed: (){


          Get.to(() => UpdateOptionScreen(updates!.optionUpdatesList!)) ;

          },)
        ],
      ),
    );
  }
}

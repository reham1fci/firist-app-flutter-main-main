import 'package:betakety_app/model/account.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/screens/account_statement/widgets/account_statement_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountStatementBody extends StatelessWidget{
  List<Account> data = [];

  AccountStatementBody(this.data);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
margin: EdgeInsets.only(top: 15 ,bottom: 15 ,right: 3 ,left: 3),
      color:lightWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 5,
      child:



      Padding(
        padding: const EdgeInsets.only(
            left: 24, right: 24, top: 8, bottom: 8),
        child:  Expanded(child:Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,

            children: <Widget>[

                  Text(
                    'debt'.tr,
                    textAlign: TextAlign.center,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      //fontFamily:
                      // FitnessAppTheme.fontName,
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      letterSpacing: -0.2,
                      color: CustomAppTheme.darkText,
                    ),
                  ),
            Text(
              'credit'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                // fontFamily: FitnessAppTheme
                //     .fontName,
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.2,
                color: CustomAppTheme
                    .darkText,
              ),
            ),
            Text(
              'balance'.tr,
              style: TextStyle(
                // fontFamily: FitnessAppTheme
                //     .fontName,
                fontWeight: FontWeight.w500,
                fontSize: 12,
                letterSpacing: -0.2,
                color: CustomAppTheme
                    .darkText,
              ),
            ),
                ],
              ),


                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AccountStatmentItem(data: data,index: index,);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: data.length),

    ]
    )
      )) );
  }

}
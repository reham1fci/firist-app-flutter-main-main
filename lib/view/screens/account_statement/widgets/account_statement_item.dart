import 'package:betakety_app/model/account.dart';
import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/screens/account_statement/account_statement_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class AccountStatmentItem extends StatelessWidget {
  List<Account> data = [];
  int index  ;


  AccountStatmentItem({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(padding: EdgeInsets.only(top: 6) ,

        child:
        Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: [
              Text(
                double.parse(data[index].debit!).toStringAsFixed(2),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily:
                  CustomAppTheme
                      .fontName,
                  fontWeight:
                  FontWeight.w600,
                  fontSize: 12,
                  color: CustomAppTheme
                      .grey
                      .withOpacity(0.5),
                ),
              ),
              Text(
                double.parse(data[index].credit!).toStringAsFixed(2),

                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily:
                  CustomAppTheme
                      .fontName,
                  fontWeight:
                  FontWeight.w600,
                  fontSize: 12,
                  color: CustomAppTheme
                      .grey
                      .withOpacity(0.5),
                ),
              ),
              Text(
                double.parse( data[index].balance!).toStringAsFixed(2),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily:
                  CustomAppTheme
                      .fontName,
                  fontWeight:
                  FontWeight.w600,
                  fontSize: 12,
                  color: CustomAppTheme
                      .grey
                      .withOpacity(0.5),
                ),
              ),
            ],
          ),
          Row(children: [
           Expanded(child:  SizedBox() ),
            CustomButton(
                width: 100,
                height: 30,
                onPressed: () {
                  // _login();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AccountStatementDetails(data[index])));
                },
                buttonText: 'details'.tr),

          ],)

        ],)
        );
  }


}

import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceItem extends StatelessWidget {
  int index ;
  List<dynamic>  filteredData ;

  AttendanceItem(this.index, this.filteredData);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return    Card(
    margin: EdgeInsets.only(top: 8 ,bottom: 8 ,right: 3 ,left: 3),
    color:lightWhite,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
    ),
    elevation: 5,
    child:
    Padding(padding: EdgeInsets.all(8) ,child:
    Column(

    children: [
    Row(
    mainAxisAlignment:
    MainAxisAlignment.center,
    children: <Widget>[
    Icon(
    Icons.access_time,
    color: CustomAppTheme.grey
        .withOpacity(0.5),
    size: 16,
    ),
    Padding(
    padding:
    const EdgeInsets.only(
    left: 4.0),
    child: Text(

        filteredData[index]["hodor_ensraf_date"],

    textAlign:
    TextAlign.center,
    style: TextStyle(
    fontFamily:
    CustomAppTheme
        .fontName,
    fontWeight:
    FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.0,
    color: CustomAppTheme
        .grey
        .withOpacity(0.5),
    ),
    ),
    ),
    ],
    ),
      Row(
        mainAxisAlignment:

        MainAxisAlignment.spaceBetween,

        children: [
      Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'attendance'.tr,
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
          Padding(
            padding:
            const EdgeInsets.only(
                top: 6),
            child: Text(
                filteredData[index]["hodor_time"],

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
          ),
        ],
      ),
      Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        crossAxisAlignment:
        CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'withdrawal'.tr,
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
          Padding(
            padding:
            const EdgeInsets.only(
                top: 6),
            child: Text(
              filteredData[index]["ensraf_time"],
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
          ),
        ],
      ),
    ],
    )
    ],
    )));
  }

}
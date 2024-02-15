import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PermissionRequestItem extends StatelessWidget{
int index ;
List<dynamic>  filteredData ;
PermissionRequestItem(
    this.index , this.filteredData
    ) ;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(
          left: 24, right: 24, top: 8, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: CustomAppTheme.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color:
                CustomAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 16, left: 16, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4, bottom: 8, top: 16),
                    child: Text(
                      "${filteredData[index]['request_per_type'].toString().tr} - ${filteredData[index]['request_type'].toString().tr}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        //  fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: -0.1,
                          color: CustomAppTheme.darkText),
                    ),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 4, bottom: 3),
                            child: Text(
                              "${filteredData[index]['request_per_stat'].toString().tr} ",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                // fontFamily:FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w200,
                                fontSize: 16,
                                color: Color.fromARGB(
                                    255, 206, 217, 6),
                              ),
                            ),
                          ),
                          Padding(
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.only(
                                left: 8, bottom: 8),
                            child: Text(
                              'PENDING'.tr,
                              textAlign: TextAlign.center,
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                // fontFamily: FitnessAppTheme
                                //     .fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: -0.2,
                                color: CustomAppTheme
                                    .nearlyDarkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: <Widget>[
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
                                  textDirection:
                                  TextDirection.ltr,
                                  "${filteredData[index]['createdDate_Time'].toString().tr} ",
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
                          ElevatedButton(
                            onPressed: () {
                              // Add the function to execute when the button is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              Color.fromARGB(
                                  255, 204, 210, 215),
                              // Background color
                              // onPrimary: Color.fromARGB(255,
                              //     23, 23, 23), // Text color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5), // Padding
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    10), // Border radius
                              ),
                            ),
                            child: Text(
                              'attachments'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.5,
                                color: Color(0xFF744ACC),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 2, bottom: 2),
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  color: CustomAppTheme.background,
                  borderRadius: BorderRadius.all(
                      Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'from_time'.tr,
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
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 6),
                          child: Text(
                            "${filteredData[index]['request_per_time_from'].toString().tr} ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily:
                              CustomAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: CustomAppTheme.grey
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'to_time'.tr,
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
                                "${filteredData[index]['request_per_time_to'].toString().tr} ",
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
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'order_date'.tr,
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
                                "${filteredData[index]['request_per_date'].toString().tr} ",
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
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 4, bottom: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'details'.tr,
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
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 6),
                          child: Text(
                            "${filteredData[index]['request_per_details'].toString().tr} ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              // fontFamily:
                              //     FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: CustomAppTheme.grey
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );;
  }


}

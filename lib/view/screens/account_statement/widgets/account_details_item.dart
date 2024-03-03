import 'package:betakety_app/model/account.dart';
import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDetailsItem extends StatelessWidget{
  List<Account> data = [];
  int index  ;

  AccountDetailsItem(this.data, this.index);

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
                      data[index].definition!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        //  fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: -0.1,
                          color: CustomAppTheme.darkText),
                    ),
                  ),
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
                 // Expanded(child:
              Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
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
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 6),
                          child: Text(
                            data[index].debit!,
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
               //   ),
                 // Expanded(child:
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: <Widget>[
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
                            Padding(
                              padding:
                              const EdgeInsets.only(
                                  top: 6),
                              child: Text(
                                data[index].credit!,
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
                //  ),
                 // Expanded(child:
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'date'.tr,
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
                                data[index].date!,
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
            //      )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 4, bottom: 8),
              child:
                 // Expanded(child:
              Column(
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
                              data[index].details!,
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
            //  ),
  ]))  );


  }

}
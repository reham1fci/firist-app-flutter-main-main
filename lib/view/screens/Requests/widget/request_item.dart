import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/model/maintenance_attachment.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:betakety_app/view/screens/Requests/widget/attach_view.dart';
import 'package:betakety_app/view/screens/Requests/widget/attachment.dart';
import 'package:betakety_app/view/screens/Requests/widget/justification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestItem extends StatelessWidget{
  int index ;
  String? type ;
  List<dynamic>  filteredData ;

  RequestItem(this.index, this.filteredData, {this.type});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<PermissionController>(builder: (pController) {

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
                      "${filteredData[index]['request_id']} - ${type ?? filteredData[index]['type']}",
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
                        CrossAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                                      "${filteredData[index]['createdDate_time'].toString().tr} ",
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, bottom: 3),
                                child: Text(
                                  "${filteredData[index]['stat_ar'].toString().tr} ",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    // fontFamily:FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 16,
                                    color:    Color.fromARGB(
                                        255, 206, 217, 6) ,
                                  ),
                                ),
                              ),
                            ],
                          ) ,
                          ElevatedButton(
                            onPressed: () {
                              // Add the function to execute when the button is pressed
                              print(filteredData[index]['attach_link']);
                              String attach_url =""  ;
                              List<MaintenanceAttachment>  files = []  ;
                              if(type== "maintenance_request".tr){
                                var attachList  = filteredData[index]['files']as List  ;
                                attachList.forEach((file) {
                                  // نفذي اللي انتي عايزاه على كل عنصر
                                  files.add(MaintenanceAttachment.fromJson(file)) ;// أو مثلاً: print(file['name']);
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AttachmentScreen(files)));

                              }


                              else{
                                var attachList  = filteredData[index]['attach_link']as List  ;
                                attach_url  = attachList[0]["attach_link"] ;
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AttachView(attach_url)));
                              }




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
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                letterSpacing: 0.5,
                                color: kMainColor,
                              ),
                            ),
                          ),

                          /*  Padding(
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
                          ),*/
                        ],
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
                  left: 24, right: 24, top: 4, bottom: 8),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  filteredData[index]['amount'].toString().isNotEmpty ?     Row(
              children: <Widget>[
                  Text(
                    'amount'.tr,
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
                    "${filteredData[index]['amount'].toString().tr} ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      // fontFamily:
                      //     FitnessAppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.red
                          .withOpacity(0.5),
                    ),
                  ),]):SizedBox() ,


                ],
              )),
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
                            "${filteredData[index]['details'].toString().tr} ",
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
          if (filteredData[index]['arrival'] == "0" && filteredData[index]['vacation_id'] == "572222" )
        (pController.loadingMap[filteredData[index]['id']] == true
          ? const CircularProgressIndicator()
          : ElevatedButton.icon(
        onPressed: () async {
          String itemId = filteredData[index]['id'];
          pController.setLoading(itemId, true);

          await Get.find<PermissionController>().resetLocation();
          await Get.find<PermissionController>().setArrival(
            id: filteredData[index]['id'],
            requestId: filteredData[index]['request_id'],
            vacationId: filteredData[index]['vacation_id'],
          );

          pController.setLoading(itemId, false);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // اللون الجديد
          padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(Icons.check_circle,
            color: Colors.white, size: 18),
        label: Text(
          'arrive'.tr,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ))

                ],
              ),
            )
          ],
        ),
      ),
    );
    });

  }

}
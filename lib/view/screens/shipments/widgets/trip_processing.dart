import 'dart:io';

import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:betakety_app/view/base/loading_dialog.dart';
import 'package:betakety_app/view/screens/Requests/widget/add_request_item.dart';
import 'package:betakety_app/view/screens/shipments/widgets/file_source_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../util/app_constants.dart';
import '../../../base/custom_snackbar.dart';

class TripProcessing extends StatefulWidget {
String levelId ;
String levelNum ;
String requestId ;
TripProcessing({required this.levelId , required this.levelNum , required this.requestId});



  @override
  State<TripProcessing> createState() => _TripProcessingState();
}

class _TripProcessingState extends State<TripProcessing> {
  String? path  ;
   @override
  void initState() {
    // TODO: implement initState
     Get.find<PermissionController>().resetData();

     super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      Get.find<PermissionController>().getProcessingOptionLevel(widget.levelId);
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<PermissionController>(builder: (pController) {
      return Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kTitleColor),
            centerTitle: true,
            title: Text(
              'processed'.tr,
              style: fontSizeMedium,
            ),
            actions: const [
              SizedBox(
                width: 5.0,
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 2.0,
          ),
          body: SingleChildScrollView(
            child:SafeArea(child: Padding(padding: EdgeInsets.only(right: 8 , left: 8),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pController.levelOptions.isEmpty?const Center(child: CircularProgressIndicator()):  ListView.separated(
                 //   key: ValueKey(widget.levelId), // هنا السر
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // اختياري لو جوا ScrollView
                    itemBuilder: (context, index) {
                      // نتأكد أن العنصر الحالي في القائمة يحتوي على controller
                      if (pController.levelOptions[index]["controller"] == null) {
                        pController.levelOptions[index]["controller"] = TextEditingController();
                      }
                      return AddRequestItem(
                        index: index,
                        filteredData: pController.levelOptions,
                        fromScreen: "trip",
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: pController.levelOptions.length,
                  ) ,



                  CustomFieldWithTitle(
                    requiredField: true,
                    title: "details".tr,
                    customTextField: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: CustomTextField(
                          maxLines: 2,
                          hintText: 'details'.tr,
                          inputType: TextInputType.text,
                          controller: pController.detailsController,
                        )),
                  ),
                  // CustomFieldWithTitle(
                  //   requiredField: false,
                  //   title: "file_add".tr,
                  //   customTextField: Container(
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Theme.of(context).primaryColor),
                  //       borderRadius: BorderRadius.circular(4.0),
                  //     ),
                  //     child: CustomTextField(
                  //       onTap: () {
                  //         pController.selectSingleFile(pController.fileNameController  , "files[]");
                  //       },
                  //       maxLines: 2,
                  //       readOnly: true,
                  //       hintText: 'file_add'.tr,
                  //       inputType: TextInputType.text,
                  //       controller: pController.fileNameController,
                  //     ),
                  //   ),
                  // ),
                  Text("other_attachments".tr , style: const TextStyle(color: Colors.red),) ,
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount :  pController.attachmentsPathsList.length + 1,
              itemBuilder: (BuildContext context, index){
                return Column(children: [
                    //Text( index==0? "identity_front".tr: index == 1 ?"identity_back".tr :"medical_image".tr,),

                    //   Text(index==0? "front image ": index == 1 ?"back image" :"Medical image") ,

                  index ==  pController.attachmentsPathsList.length ?
                         GestureDetector(
                      onTap: () async {


                        showFileSourceDialog(context, pController, "attachment_file[]");
                    //     pController.attachmentsPathsList.add(path!) ;
                      },
                      child: Container(
                        //padding: const EdgeInsets.only(left: 10 , right: 10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                        ),
                        height: MediaQuery.of(context).size.width / 4.3,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(Icons.attach_file,
                            //     size: 32, color: Theme.of(context).primaryColor),
                            Image.asset(
                              "assets/image/add_attach.png", // المسار بتاع الأيقونة
                              width: 50,
                              height: 50,
                              color: Theme.of(context).primaryColor, // لو عايزة تديها نفس اللون
                            ) ,
                            const SizedBox(height: 8),
                            Text("إضافة ملف",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    )
                        : Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                                  child:  pController.isImage(pController.attachmentsPathsList[index])
                                      ? Image.file(
                                    File(pController.attachmentsPathsList[index]),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width / 4.3,
                                    fit: BoxFit.cover,
                                  )
                                      : Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.width / 4.3,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.insert_drive_file,
                                            size: 40, color: Theme.of(context).primaryColor),
                                        const SizedBox(height: 6),
                                        Text(
                                          pController.fileNameController.text,
                                          style: const TextStyle(
                                              fontSize: 14, fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Text(
                            //   pController.filesNames[index],
                            //   style: const TextStyle(
                            //       fontSize: 14, fontWeight: FontWeight.w500),
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                 pController.removeFiles(index: index , list: true, name: true);
                              //  pController.fileNameController.clear();
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4.0),
                              child: const Icon(
                                Icons.delete_forever_rounded,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ) ,
                  SizedBox(height: 10,)
                  ]);}),

                  Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                    child: CustomButton(
                      buttonText: "save".tr,
                      onPressed: () async {

                        // افتح اللودينج
                        //showLoadingDialog(context, message: "جارٍ المعالجة...");
showLoadingDialog(context , message: "loading_process".tr+"......") ;
                        try {
                          Position currentLocation = await pController.getCurrentLocation();

                          validateRequestsAndShowSnackbar(
                            pController.levelOptions,
                            pController,
                          );

                        } catch (e) {
                          print(e);
                        }
if(!pController.isLoading){
                        // اقفل اللودينج
                        Navigator.pop(context);}
                      },
                    ),
                  )

                ] ),
            ) )));
    });
  }

  Future<void> validateRequestsAndShowSnackbar(  List<dynamic>? options ,PermissionController controller ) async {
    for (int i  = 0 ; i < options!.length ; i ++) {
      TextEditingController  controller  = options[i]["controller"] ;
      String   req  = options[i]["required_type"] ;
      if(controller.text.isEmpty &&req =="required") {
        showCustomSnackBar("${options[i]["option_name_ar"]} ${"is_required".tr}");
        return ;
      }
    }
    if (controller.detailsController.text.isEmpty) {
      showCustomSnackBar("${'details'.tr} ${"is_required".tr}");
    }


    else {
      controller.tripProcessing(uri: AppConstants.processingTrip  , level: widget.levelNum , requestId: widget.requestId , level_id: widget.levelId)  ;

    }
  }

}


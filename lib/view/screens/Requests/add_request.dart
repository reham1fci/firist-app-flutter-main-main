import 'dart:io';

import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/model/vacation_type.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/view/screens/Requests/widget/add_request_item.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../util/constant.dart';
import '../../base/custom_text_field.dart';
import '../../base/custom_button.dart';
import '../../base/custom_field_with_title.dart';
import '../../../controllers/permission_controller.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';

class AddRequest extends StatefulWidget {
  const AddRequest({super.key});

  @override
  State<AddRequest> createState() => AddRequestState();
}

class AddRequestState extends State<AddRequest> {
  String? path  ;
  @override
  void initState() {
    Get.find<PermissionController>().resetData();
    super.initState();
    Get.find<PermissionController>().getTypes(AppConstants.getRequestTypes);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PermissionController>(builder: (pController) {
      return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kTitleColor),
          centerTitle: true,
          title: Text(
            'add_request'.tr,
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
          child: Column(
            children: [
                  CustomFieldWithTitle(
                    requiredField: true,

                    title: "type".tr,
                    customTextField: Container(
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<VacationType>(
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Text('type'.tr),
                        ),
                        value: pController.vacationTypeTemp,
                        items: pController.vacationTypeList!.map((value) {
                          return DropdownMenuItem<VacationType>(
                            value: value,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 9),
                              child: Text(value.nameAr!),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                         // pController.vacationTypeTemp!.options!.clear() ;

                          pController.vacationTypeTemp = value;
                          pController.filesList.clear() ;
                         pController. fileNameController.clear();

                          pController.update();
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
              pController.vacationTypeTemp != null && pController.vacationTypeTemp!.options != null
                  ? ListView.separated(
                key: ValueKey(pController.vacationTypeTemp!.Id), // هنا السر
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // اختياري لو جوا ScrollView
                itemBuilder: (context, index) {
                  return AddRequestItem(
                    index: index,
                    filteredData: pController.vacationTypeTemp!.options!,
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: pController.vacationTypeTemp!.options!.length,
              )
                  : const SizedBox(),


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
              Column(children: [
                //Text( index==0? "identity_front".tr: index == 1 ?"identity_back".tr :"medical_image".tr,),

                //   Text(index==0? "front image ": index == 1 ?"back image" :"Medical image") ,

                pController.fileNameController.text.isEmpty
                    ? Padding(padding: EdgeInsets.only(left: 10 , right: 10) , child:  GestureDetector(
                  onTap: () async {
                    path = await pController.selectSingleFile(
                        pController.fileNameController, "files[]");
                    print("path"+ path!);
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
                ))
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
                              child:  pController.isImage(path!)
                                  ? Image.file(
                                File(path!),
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
                        //   pController.fileNameController.text,
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
                            path = null;
                            pController.fileNameController.clear();
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
                )
                ,
          if (pController.isLoading) CircularProgressIndicator() else Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: CustomButton(
                  buttonText: "save".tr,
                  onPressed: () async {
                     if(pController.vacationTypeTemp!.Id  == "572222") {
             Position currentLocation  =     await     pController.getCurrentLocation() ;
               pController.validateRequestsAndShowSnackbar(pController.vacationTypeTemp!.options! );

                     }
                     else{
                    pController.validateRequestsAndShowSnackbar(pController.vacationTypeTemp!.options! );}
                  },
                ),
              )
            ],
          ),
       ] ),
      ));
    });
  }

}

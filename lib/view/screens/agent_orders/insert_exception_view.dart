import 'dart:io';

import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/model/Questions.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsertExceptionView extends StatefulWidget{
  String? date  ;

  InsertExceptionView({this.date});

  @override
  State<InsertExceptionView> createState() => _InsertExceptionViewState();
}

class _InsertExceptionViewState extends State<InsertExceptionView> {

  String? path  ;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
     Get.find<PermissionController>().resetData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GetBuilder<PermissionController>(builder: (pController) {
        //  title: Text(title!),
        return Scaffold(
            appBar: AppBar(title: Text('exception_request'.tr)),
            body: SingleChildScrollView(
          child:  Padding(padding: EdgeInsets.all(20) , child:
          Column(
            children: <Widget>[
              // Text(message),

              Container(
                margin: const EdgeInsets.only(
                    bottom: Dimensions.PADDING_SIZE_SMALL),
                child:  CustomTextField(
                  hintText: 'enter_exception_reason'.tr,
                  inputType: TextInputType.emailAddress,
                  controller: pController.justificationController,
                ),
              ),
               SizedBox(height: 30) ,
              pController.fileName.text.isEmpty?
              Padding(padding: EdgeInsets.only(left: 10 , right: 10) , child:  GestureDetector(
                onTap: () async {
                  path = await pController.selectSingleFileWithName(
                      pController.fileName, "files");
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
                                    pController.fileName.text,
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
                          pController.fileName.clear();
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
              ),
              SizedBox(height: 30) ,

              if (pController.isLoading) CircularProgressIndicator() else Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: CustomButton(
                buttonText: "save".tr,
                onPressed: () async {
pController.insertException(date: widget.date) ;
                     },
                )  ),
            ],
        ),
        )));


    },
    );
}
}

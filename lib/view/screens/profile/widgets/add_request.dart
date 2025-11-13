import 'dart:io';

import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/localization_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/model/personal_data.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:betakety_app/view/screens/Requests/widget/request_item.dart';
import 'package:betakety_app/view/screens/profile/widgets/ProfileOptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';


class AddRequest extends StatefulWidget {
  PersonalData? data ;

  AddRequest({super.key , this.data});


  @override
  State<AddRequest> createState() => AddRequestState();
}

class AddRequestState extends State<AddRequest>  {
  // final AnimationController? animationController;
  TextEditingController textController = TextEditingController();
  String? path ;


  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor:Colors.white,
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           children: [
             widget.data!.dataType! ==  "text"?addTextItem():widget.data!.dataType == "attachment"?addFile():SizedBox(),
            ],
          ));
    });
  }
 Widget addTextItem(){
   return  CustomFieldWithTitle(
    requiredField: true,
    title: widget.data!.name!,
    customTextField: Container(
    decoration: BoxDecoration(
    border: Border.all(color: Theme
        .of(context)
        .primaryColor),
    borderRadius: BorderRadius.circular(4.0),
    ),
    child: CustomTextField(
    maxLines: 2,
    hintText: widget.data!.name!,
    inputType: TextInputType.text,
    controller: textController,
    )),
    );
  }
  Widget addFile() {

  PermissionController pController = Get.find();
    return
      Column(children: [
        //Text( index==0? "identity_front".tr: index == 1 ?"identity_back".tr :"medical_image".tr,),

        //   Text(index==0? "front image ": index == 1 ?"back image" :"Medical image") ,

        textController.text.isEmpty
            ? Padding(padding: EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () async {
                path = await pController.selectSingleFile(
                    textController, "files[]" );
                print("path" + path!);
                setState(() {

                });
              },
              child: Container(
                //padding: const EdgeInsets.only(left: 10 , right: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                height: MediaQuery
                    .of(context)
                    .size
                    .width / 4.3,
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
                      color: Theme
                          .of(context)
                          .primaryColor, // لو عايزة تديها نفس اللون
                    ),
                    const SizedBox(height: 8),
                    Text(widget.data!.name!,
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
                      child: pController.isImage(path!)
                          ? Image.file(
                        File(path!),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width / 4.3,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width / 4.3,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.insert_drive_file,
                                size: 40, color: Theme
                                    .of(context)
                                    .primaryColor),
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


      ]);
  }}

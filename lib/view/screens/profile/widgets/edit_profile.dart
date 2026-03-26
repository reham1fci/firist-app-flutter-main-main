import 'dart:io';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/vacation_type.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:betakety_app/view/screens/Requests/widget/add_request_item.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  String? from  ;
   EditProfile({super.key  , this.from});

  @override
  State<EditProfile> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  String? path  ;
  LoginResponsModel? user ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<PermissionController>().resetData();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
 if (widget.from  ==  "home"){
   Get.find<PermissionController>().getTypes(AppConstants.showMandatoryData);
 }


 else{
      Get.find<PermissionController>().getTypes(AppConstants.empData);}

    });
  }

  Future<void> getUserData() async {
      user =  await AuthController().getLoginData()  ;
setState(() {

});


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
            'edit_profile_request'.tr,
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
        body:
      pController.vacationTypeTemp!.options==null?Center(child: CircularProgressIndicator(),):
    SafeArea(child:   SingleChildScrollView(
          child: Column(
            children: [
                ListView.separated(
             //   key: ValueKey(pController.vacationTypeTemp!.Id),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AddRequestItem(
                    index: index,
                    filteredData: pController.vacationTypeTemp!.options!,fromScreen: "profile",
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: pController.vacationTypeTemp!.options!.length,
              )
              // pController.fileNameController.text.isEmpty
              //     ? Padding(padding: EdgeInsets.only(left: 10 , right: 10) , child:  GestureDetector(
              //   onTap: () async {
              //     path = await pController.selectSingleFile(
              //         pController.fileNameController, "files[]");
              //     print("path"+ path!);
              //   },
              //   child: Container(
              //     //padding: const EdgeInsets.only(left: 10 , right: 10),
              //     margin: const EdgeInsets.only(bottom: 10),
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.red),
              //       borderRadius: BorderRadius.circular(12),
              //       color: Colors.grey[200],
              //     ),
              //     height: MediaQuery.of(context).size.width / 4.3,
              //     width: double.infinity,
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         // Icon(Icons.attach_file,
              //         //     size: 32, color: Theme.of(context).primaryColor),
              //         Image.asset(
              //           "assets/image/add_attach.png", // المسار بتاع الأيقونة
              //           width: 50,
              //           height: 50,
              //           color: Theme.of(context).primaryColor, // لو عايزة تديها نفس اللون
              //         ) ,
              //         const SizedBox(height: 8),
              //         Text("personal_photo".tr,
              //             style: TextStyle(
              //                 color: Colors.grey[700],
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500)),
              //       ],
              //     ),
              //   ),
              // ))
              //     : Stack(
              //   children: [
              //     Column(
              //       children: [
              //         Padding(
              //           padding:
              //           const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
              //           child: Container(
              //             decoration: const BoxDecoration(
              //               color: Colors.white,
              //               borderRadius: BorderRadius.all(Radius.circular(20)),
              //             ),
              //             child: ClipRRect(
              //               borderRadius: const BorderRadius.all(
              //                   Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
              //               child:  pController.isImage(path!)
              //                   ? Image.file(
              //                 File(path!),
              //                 width: MediaQuery.of(context).size.width,
              //                 height: MediaQuery.of(context).size.width / 4.3,
              //                 fit: BoxFit.cover,
              //               )
              //                   : Container(
              //                 width: MediaQuery.of(context).size.width,
              //                 height: MediaQuery.of(context).size.width / 4.3,
              //                 decoration: BoxDecoration(
              //                   color: Colors.grey[200],
              //                   borderRadius: BorderRadius.circular(12),
              //                 ),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Icon(Icons.insert_drive_file,
              //                         size: 40, color: Theme.of(context).primaryColor),
              //                     const SizedBox(height: 6),
              //                     Text(
              //                       pController.fileNameController.text,
              //                       style: const TextStyle(
              //                           fontSize: 14, fontWeight: FontWeight.w500),
              //                       maxLines: 1,
              //                       overflow: TextOverflow.ellipsis,
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //         // Text(
              //         //   pController.fileNameController.text,
              //         //   style: const TextStyle(
              //         //       fontSize: 14, fontWeight: FontWeight.w500),
              //         //   overflow: TextOverflow.ellipsis,
              //         // ),
              //       ],
              //     ),
              //     Positioned(
              //       top: 8,
              //       right: 8,
              //       child: InkWell(
              //         onTap: () {
              //           setState(() {
              //             path = null;
              //             pController.fileNameController.clear();
              //           });
              //         },
              //         child: Container(
              //           decoration: const BoxDecoration(
              //             color: Colors.white,
              //             shape: BoxShape.circle,
              //           ),
              //           padding: const EdgeInsets.all(4.0),
              //           child: const Icon(
              //             Icons.delete_forever_rounded,
              //             color: Colors.red,
              //             size: 20,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
              // ,
              // CustomFieldWithTitle(
              //   requiredField: true,
              //   title: "arabic_name".tr,
              //   customTextField: Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Theme.of(context).primaryColor),
              //         borderRadius: BorderRadius.circular(4.0),
              //       ),
              //       child: CustomTextField(
              //         maxLines: 2,
              //         hintText: user!.name!??"",
              //         inputType: TextInputType.text,
              //         controller: pController.detailsController,
              //       )),
              // ), CustomFieldWithTitle(
              //   requiredField: true,
              //   title: "english_name".tr,
              //   customTextField: Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Theme.of(context).primaryColor),
              //         borderRadius: BorderRadius.circular(4.0),
              //       ),
              //       child: CustomTextField(
              //         maxLines: 2,
              //         hintText: user!.nameen!??"",
              //         inputType: TextInputType.text,
              //         controller: pController.detailsController,
              //       )),
              // ), CustomFieldWithTitle(
              //   requiredField: true,
              //   title: "PHONE_NO".tr,
              //   customTextField: Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Theme.of(context).primaryColor),
              //         borderRadius: BorderRadius.circular(4.0),
              //       ),
              //       child: CustomTextField(
              //         maxLines: 2,
              //         hintText: user!.mobilenumber!,
              //         inputType: TextInputType.text,
              //         controller: pController.detailsController,
              //       )),
              // ), CustomFieldWithTitle(
              //   requiredField: true,
              //   title: "EMAIL".tr,
              //   customTextField: Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Theme.of(context).primaryColor),
              //         borderRadius: BorderRadius.circular(4.0),
              //       ),
              //       child: CustomTextField(
              //         maxLines: 2,
              //         hintText: user!.email!,
              //         inputType: TextInputType.text,
              //         controller: pController.detailsController,
              //       )),
              // ),

                //Text( index==0? "identity_front".tr: index == 1 ?"identity_back".tr :"medical_image".tr,),

                //   Text(index==0? "front image ": index == 1 ?"back image" :"Medical image") ,

        ,  if (pController.isLoading) CircularProgressIndicator() else Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: CustomButton(
                  buttonText: "save".tr,
                  onPressed: () async {
                     if(widget.from == "home") {
                       pController.insertRequest(uri: AppConstants.editMandatoryData, );
                     }
                     else{
      pController.insertRequest(uri: AppConstants.editProfile, );

      }
                     }

                  ,
                ),

          ),
       ] ),
      )));
    });
  }

}

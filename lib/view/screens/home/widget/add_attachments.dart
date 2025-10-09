

import 'dart:io';

import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/screens/shipments/widgets/image_source_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAttachments extends StatefulWidget {
  @override
  State<AddAttachments> createState() => _AddAttachmentsState();
}

class _AddAttachmentsState extends State<AddAttachments> {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<ShipmentController>().resetImageData() ;


   }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<ShipmentController>(builder: (shipController) {

      return
     Scaffold(
       backgroundColor: Color.fromARGB(255, 252, 252, 252),
    appBar: AppBar(
    iconTheme: const IconThemeData(color: kTitleColor),
    centerTitle: true,
    title: Text(
    'add_attachments'.tr,
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
      Padding(
     padding: const EdgeInsets.all(16),child:
      ListView.builder(
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           itemCount :  shipController.identityImages.length + 1,
           itemBuilder: (BuildContext context, index){
             return
               Column(children: [
                 //Text( index==0? "identity_front".tr: index == 1 ?"identity_back".tr :"medical_image".tr,),

                 //   Text(index==0? "front image ": index == 1 ?"back image" :"Medical image") ,

                 index ==  shipController.identityImages.length ?
                 GestureDetector(
                   onTap: ()=> showImageSourceDialog(context, shipController),
                   child: DottedBorder(
                       strokeWidth: 2,
                       dashPattern: const [10,5],
                       color: Theme.of(context).hintColor,
                       borderType: BorderType.RRect,
                       radius: const Radius.circular(Dimensions.PADDING_SIZE_SMALL),
                       child: Stack(children: [
                         ClipRRect(
                             borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault),
                             child:  SizedBox(height: MediaQuery.of(context).size.width/4.3,
                                 width: MediaQuery.of(context).size.width,
                                 child: Image.asset(Images.camera_thumbnail2, scale: 3))),
                         Positioned(bottom: 0, right: 0, top: 0, left: 0,
                             child: Container(decoration: BoxDecoration(
                                 color: Theme.of(context).hintColor.withOpacity(0.07),
                                 borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault))))])),
                 )
                     :
                 Stack(children: [
                   Column(
                     children: [
                       Padding(
                           padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                           child: Container(decoration: const BoxDecoration(color: Colors.white,
                             borderRadius: BorderRadius.all(Radius.circular(20)),),
                               child: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                                   child: Get.find<PermissionController>().isImage(shipController.identityImages[index].path) ?Image.file(File(shipController.identityImages[index].path),
                                       width: MediaQuery.of(context).size.width,
                                       height: MediaQuery.of(context).size.width/4.3,
                                       fit: BoxFit.cover)
                               :Container(
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
             ],
             ),
             ) )
                           )),
                       Text(
                         shipController.filesNames[index],
                         style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                       ),   ],
                   ),
                   Positioned(top:0,right:0,
                       child: InkWell(onTap :() => shipController.removeImage(index),
                           child: Container(decoration: const BoxDecoration(color: Colors.white,
                               borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault))),
                               child: const Padding(padding: EdgeInsets.all(4.0),
                                   child: Icon(Icons.delete_forever_rounded,color: Colors.red,size: 15)))))]) ,

                 SizedBox(height: 20,)

               ],) ;


           } )),
     bottomNavigationBar:SafeArea(child:  Padding(
     padding:  EdgeInsets.all(16), child:CustomButton(buttonText: "save" , onPressed: (){
       Navigator.of(context).pop() ;
     },))),
     );
  });
}}
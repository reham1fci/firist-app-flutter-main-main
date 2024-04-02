
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showJustificationDialog({ required BuildContext context  , required String hr_question_id ,required  String hr_question_date})  {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return GetBuilder<PermissionController>(builder: (pController) {
      return  AlertDialog(
        //  title: Text(title!),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
             // Text(message),

              Container(
                margin: const EdgeInsets.only(
                    bottom: Dimensions.PADDING_SIZE_SMALL),
                child:  CustomTextField(
                  hintText: 'Enter_your_justification'.tr,
                  inputType: TextInputType.emailAddress,
                  controller: pController.justificationController,
                ),
              ),
        CustomFieldWithTitle(
          requiredField: false,
          title: "file_add".tr,
          customTextField: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: CustomTextField(
              onTap: () {
                pController.selectSingleFile();
              },
              maxLines: 2,
              readOnly: true,
              hintText: 'file_add'.tr,
              inputType: TextInputType.text,
              controller: pController.fileNameController,
            ),
          ),),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              if(pController.justificationController.text.isEmpty){
                showCustomSnackBar('Enter_your_justification'.tr) ;
              }
              else{
                pController.insertJustification( hr_question_id: hr_question_id, hr_question_date: hr_question_date);
                Navigator.of(context).pop();

              }
           //   onOkClick!();
            },
          ),
         TextButton(
            child:  const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            //  onCancelClick!();
            },
          ),
        ],
      );
    },
      );} );
}



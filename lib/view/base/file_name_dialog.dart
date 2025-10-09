
import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

   FileNameDialog({required BuildContext context   ,
    required  bool isCancelBtn ,Function? onOkClick , Function? onCancelClick })  {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return     GetBuilder<ShipmentController>(builder: (shipController) {
      return    AlertDialog(
        title:  Text("enter_file_name".tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CustomTextField( controller: shipController.fileName,hintText:"write_some_thing".tr ,)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text( 'ok'.tr , style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
                onOkClick!();
              },
            ),
            isCancelBtn? TextButton(
              child:   Text('CANCEL'.tr , style: TextStyle(color:  Theme.of(context).primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
                onCancelClick!();
              },
            ): const SizedBox(),
          ],
        );
      },
    );}
     );
  }



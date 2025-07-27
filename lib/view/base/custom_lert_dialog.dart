
import 'package:flutter/material.dart';

   showOkDialog({required BuildContext context   , required String message   ,
    required  bool isCancelBtn ,Function? onOkClick , Function? onCancelClick  ,String?okTitle})  {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
        //  title: Text(title!),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text( okTitle ??'Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                onOkClick!();
              },
            ),
            isCancelBtn? TextButton(
              child:  const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                onCancelClick!();
              },
            ): const SizedBox(),
          ],
        );
      },
    );
  }



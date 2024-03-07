import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoaderDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    content:  Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7),child:Text("Loading_info".tr )),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}
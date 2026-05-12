import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoadingDialog(BuildContext context  , {String message = "Loading..."}) {
  showDialog(
    context: context,
    barrierDismissible: false, // يمنع المستخدم من غلق الديالوج بالضغط برا
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Colors.red),
              SizedBox(width: 20),
              Text(
                message,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    },
  );
}

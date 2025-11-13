
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

   showOkDialog({required BuildContext context   ,
    required  bool isCancelBtn ,Function? onOkClick , Function? onCancelClick  })  {
    return showDialog(
      context: context,
      barrierDismissible: false, // مايتقفلش بالضغط برا
      builder: (BuildContext context) {
        return   WillPopScope(
            onWillPop: () async => false, // يمنع زر الرجوع
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
          elevation: 8,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orangeAccent,
                  size: 60,
                ),
                const SizedBox(height: 15),
                Text(
                  'important_alert'.tr,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'update_data_message'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          // السلوك عند الضغط على "حسناً"
                       //   Navigator.of(context).pop(true);
                          onOkClick!();

                        },
                        child: Text(
                          'update_info'.tr,
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                   isCancelBtn? Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.orangeAccent, width: 2),
                          foregroundColor: Colors.orangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                         // onCancelClick!();
                        },
                        child: Text(
                          'CANCEL'.tr,
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ):SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ));
      },
    );

   }



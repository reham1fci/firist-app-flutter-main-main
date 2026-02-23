import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showReasonDialog(BuildContext context, Function(String) onSave) {
  final TextEditingController reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title:  Text("objection_reason".tr),
        content: TextField(
          controller: reasonController,
          maxLines: 3,
          decoration:  InputDecoration(
            hintText: 'write_objection_reason'.tr,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:  Text('CANCEL'.tr),
          ),
          TextButton(
            onPressed: () {
              onSave(reasonController.text);
              Navigator.pop(context);
            },
            child:  Text("save".tr),
          ),
        ],
      );
    },
  );
}

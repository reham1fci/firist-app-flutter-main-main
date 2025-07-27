import 'package:betakety_app/model/maintenance_attachment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'attach_view.dart';

class AttachmentScreen extends StatelessWidget {
   List<MaintenanceAttachment> files = [
  ];


   AttachmentScreen(this.files);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('attachment'.tr)),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files[index];
          return ListTile(
            title: Text(file.name!.isEmpty? "file"+index.toString():file.name!),
            leading: Icon(Icons.insert_drive_file, color: Colors.red,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>AttachView(file.link)
                ),
              );
            },
          );
        },
      ),
    );
  }
}

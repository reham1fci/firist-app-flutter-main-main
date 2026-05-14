import 'package:betakety_app/view/screens/shipments/widgets/attachment_view_screen.dart';
import 'package:flutter/material.dart';

class AttachmentsListScreen extends StatelessWidget {
  final List<String> attachments;

  const AttachmentsListScreen({super.key, required this.attachments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المرفقات"),
      ),
      body: attachments.isEmpty
          ? Center(child: Text("لا يوجد مرفقات"))
          : ListView.separated(
        itemCount: attachments.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (context, index) {
          final item = attachments[index];

          return ListTile(
            leading: Icon(Icons.insert_drive_file, color: Colors.red),
            title: Text("attachment${index+1}"),
            subtitle: Text(
              item,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AttahmentViewScreen(url: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
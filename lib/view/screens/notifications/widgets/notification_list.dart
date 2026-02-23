import 'package:betakety_app/model/notification_model.dart';
import 'package:betakety_app/view/screens/notifications/widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatelessWidget {
  final List<NotificationModel> list;
  final String emptyText;

  const NotificationList({
    Key? key,
    required this.list,
    required this.emptyText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Center(child: Text(emptyText));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return NotificationItem(item: list[index]);
      },
    );
  }
}

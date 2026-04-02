import 'package:betakety_app/controllers/notification_controller.dart';
import 'package:betakety_app/view/screens/notifications/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/notification_list.dart';
import 'widgets/tab_widget.dart';
class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller =
  Get.find<NotificationController>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<NotificationController>().getNotificationList();

}
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(child: Text('notification'.tr)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: GetBuilder<NotificationController>(
              builder: (_) {
                return TabBar(
                  tabs: [
                    Tab(
                      child: tabWithBadge(
                        title: 'unseen'.tr,
                        count: controller.unreadCount,
                      ),
                    ),
                    Tab(
                      child: tabWithBadge(
                        title: 'seen'.tr,
                        count: controller.seenCount,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        body: GetBuilder<NotificationController>(

          builder: (_) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return TabBarView(
              children: [
                NotificationList(
                  list: controller.unreadNotifications,
                  emptyText: 'no_data_found'.tr,
                ),
                NotificationList(
                  list: controller.seenNotifications,
                  emptyText: 'no_data_found'.tr,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


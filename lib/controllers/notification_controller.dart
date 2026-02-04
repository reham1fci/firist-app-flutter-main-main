import 'dart:convert';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/notification_model.dart';
import 'package:get/get.dart';

import '../util/app_constants.dart';
class NotificationController extends GetxController {
  List<NotificationModel> notifications = [];
  bool isLoading = false;

  List<NotificationModel> get unreadNotifications =>
      notifications.where((e) => !e.isSeen!).toList();

  List<NotificationModel> get seenNotifications =>
      notifications.where((e) => e.isSeen!).toList();

  int get unreadCount => unreadNotifications.length;
  int get seenCount => seenNotifications.length;
  Future<void> getNotificationList() async {
    isLoading = true;
    update();

    Api api = Api();
    final authController = Get.find<AuthController>();
    LoginResponsModel user = await authController.getLoginData();

    String url =
        "${AppConstants.showNotification}?user_id=${user.id}";

    try {
      final response = await api.getData(url: url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data['items'];

        notifications = list
            .map((e) => NotificationModel.fromJson(e))
            .toList();
      }
    } catch (e) {
      print('Notification error: $e');
    }

    isLoading = false;
    update();
  }
}

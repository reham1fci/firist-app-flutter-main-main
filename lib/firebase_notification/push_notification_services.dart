import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/notification_controller.dart';
import 'package:betakety_app/firebase_notification/local_notification_service.dart';
import 'package:betakety_app/view/screens/home/nav_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Map<String, dynamic>? initialData;


  Future<void> init() async {
    await _requestPermission();
    await _getAndSendToken();
    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.data.isNotEmpty) {
        if (message.data['type'] == 'notification') {
          Get.find<NotificationController>().getNotificationList();
        }
        LocalNotificationService.show(
          title: message.data['title'] ?? 'Notification',
          body: message.data['body'] ?? '',
          payload: message.data,
        );
      }
    });
   // background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data.isNotEmpty) {
        if (message.data['type'] == 'notification') {
          Get.find<NotificationController>().getNotificationList();
        }
        _handleNavigation(message.data);
      }
    });
     // if app terminated
    final initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleNavigation(initialMessage.data);
    }

    _listenTokenRefresh();
  }

  Future<void> _requestPermission() async {
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _getAndSendToken() async {
    final token = await _fcm.getToken();
    if (token != null) {
      Get.find<AuthController>().saveToken(token: token);
    }
  }
  void handleLocalNotificationTap(Map<String, dynamic> data) {
    _handleNavigation(data);
  }
  void _listenTokenRefresh() {
    _fcm.onTokenRefresh.listen((newToken) {

      Get.find<AuthController>().saveToken(token: newToken);
    });
  }
  void _handleNavigation(Map<String, dynamic> data) {
    Get.find<NavbarController>().changeScreen(2);

    // Add more types if needed
  }

}

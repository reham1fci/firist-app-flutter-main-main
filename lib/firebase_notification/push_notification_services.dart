import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/notification_controller.dart';
import 'package:betakety_app/firebase_notification/local_notification_service.dart';
import 'package:betakety_app/view/screens/home/nav_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Map<String, dynamic>? initialData;

  Future<void> init() async {
    await _requestPermission();
    await _getAndSendToken();
    
    // foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null || message.data.isNotEmpty) {
        String title = message.notification?.title ?? message.data['title'] ?? 'Notification';
        String body = message.notification?.body ?? message.data['body'] ?? '';
        
        if (message.data['type'] == 'notification') {
          Get.find<NotificationController>().getNotificationList();
        }
        
        // إظهار البانر اللي شبه واتساب
        _showBanner(title, body, message.data);
        
        // إظهار الإشعار في الـ Status Bar أيضاً
        LocalNotificationService.show(
          title: title,
          body: body,
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
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNavigation(initialMessage.data);
    }

    _listenTokenRefresh();
  }

  void _showBanner(String title, String body, Map<String, dynamic> data) {
    Get.snackbar(
      title,
      body,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      borderRadius: 15,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.vertical,
      forwardAnimationCurve: Curves.easeOutBack,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 5),
        )
      ],
      icon: Container(
        margin: const EdgeInsets.only(left: 10),
        child: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.notifications, color: Colors.white),
        ),
      ),
      onTap: (_) {
        _handleNavigation(data);
      },
      mainButton: TextButton(
        onPressed: () => Get.back(),
        child: const Text("إغلاق", style: TextStyle(color: Colors.grey)),
      ),
    );
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
    try {
      Get.find<NavbarController>().changeScreen(2);
    } catch (e) {
      debugPrint("Navigation error: $e");
    }
  }
}

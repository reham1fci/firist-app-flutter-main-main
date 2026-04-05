import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/notification_controller.dart';
import 'package:betakety_app/firebase_notification/local_notification_service.dart';
import 'package:betakety_app/view/screens/home/nav_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Map<String, dynamic>? initialData;


  Future<void> init() async {
    await _requestPermission();
    await _getAndSendToken();
    //foreground
    FirebaseMessaging.onMessage.listen((message) {
      final data = message.data;
      final title = message.notification?.title ?? data['title'] ?? 'Notification';
      final body = message.notification?.body ?? data['body'] ?? '';

      if (data.isNotEmpty && data['type'] == 'notification') {
        Get.find<NotificationController>().getNotificationList();
      }

      LocalNotificationService.show(
        title: title,
        body: body,
        payload: data.isNotEmpty ? data : {'type': 'notification'},
      );
    });
   // background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final data = message.data;
      if (data.isNotEmpty && data['type'] == 'notification') {
        Get.find<NotificationController>().getNotificationList();
      } else {
        Get.find<NotificationController>().getNotificationList();
      }
      _handleNavigation(data);
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
    String? token;
    for (int i = 0; i < 3; i++) {
      token = await _fcm.getToken();
      if (token != null && token.isNotEmpty) break;
      await Future.delayed(const Duration(milliseconds: 800));
    }
    if (token != null && token.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      if (isLoggedIn) {
        Get.find<AuthController>().saveToken(token: token);
      }
    }
  }
  void handleLocalNotificationTap(Map<String, dynamic> data) {
    _handleNavigation(data);
  }
  void _listenTokenRefresh() {
    _fcm.onTokenRefresh.listen((newToken) async {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      if (isLoggedIn) {
        Get.find<AuthController>().saveToken(token: newToken);
      }
    });
  }
  void _handleNavigation(Map<String, dynamic> data) {
    Get.find<NavbarController>().changeScreen(2);

    // Add more types if needed
  }

}

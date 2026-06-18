import 'package:betakety_app/firebase_notification/push_notification_services.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/view/screens/auth/auth_screen.dart';
import 'package:betakety_app/view/screens/home/nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  late SharedPreferences sharedPrefs;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () => checkUser());
  }

  checkUser() async {
    sharedPrefs = await SharedPreferences.getInstance();
    
    // الاعتماد على Flag تسجيل الدخول مع التأكد من وجود بيانات المستخدم
    bool isLoggedIn = sharedPrefs.getBool('is_logged_in') ?? false;
    bool hasUser = sharedPrefs.containsKey("user");

    if (isLoggedIn && hasUser) {
      Get.offAll(() => const NavBarScreen());
    } else {
      Get.offAll(() => const AuthScreen());
    }

    // معالجة بيانات الإشعارات إن وجدت
    if (Get.isRegistered<PushNotificationService>()) {
      final pushService = Get.find<PushNotificationService>();
      if (pushService.initialData != null) {
        pushService.handleLocalNotificationTap(pushService.initialData!);
        pushService.initialData = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Image.asset(
              Images.logo_hr,
              fit: BoxFit.cover,
            ),
            const Text(
              AppConstants.company_name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: kMainColor,
              ),
            ),
            const Spacer(),
            const CircularProgressIndicator(color: kMainColor),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

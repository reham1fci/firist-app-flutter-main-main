import 'dart:convert';

import 'package:betakety_app/controllers/account_controller.dart';
import 'package:betakety_app/controllers/attendance_controller.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/banner_controller.dart';
import 'package:betakety_app/controllers/delivery_projects_controller.dart';
import 'package:betakety_app/controllers/maintenance_controller.dart';
import 'package:betakety_app/controllers/notification_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/controllers/salary_controller.dart';
import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/firebase_notification/local_notification_service.dart';
import 'package:betakety_app/firebase_notification/push_notification_services.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/view/screens/home/nav_screen.dart';
import 'package:betakety_app/view/screens/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/language_controller.dart';
import 'controllers/localization_controller.dart';
import 'firebase_notification/firebase_background_handler.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SharedPreferences قبل أي حاجة
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('is_logged_in');

  // إعداد اللغات (لو عندك init)
  Map<String, Map<String, String>> languages = await init();

  // Firebase initialization
  await Firebase.initializeApp(
    options: kIsWeb
        ? throw UnsupportedError('Web not supported')
        : FirebaseOptions(
      apiKey: 'AIzaSyCXNWG95tMBd0cMt3pH87EFC-3GBEazs0c',
      appId: '1:206102003007:ios:d4862ddce17eea412c278a',
      messagingSenderId: '206102003007',
      projectId: 'marsa-hr',
      storageBucket: 'marsa-hr.firebasestorage.app',
      iosBundleId: 'com.marsa.marsa-hr', // لازم يكون زي Xcode
    ),
  );

  // Push notification service
  final pushService = PushNotificationService();
  Get.put<PushNotificationService>(pushService, permanent: true);

  // Local notifications (مهم تمرري إعدادات iOS)
  await LocalNotificationService.init(
    onNotificationTap: pushService.handleLocalNotificationTap,

  );

  // Firebase messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // طلب إذن الإشعارات على iOS
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Initial message (لو التطبيق فتح من notification)
  RemoteMessage? initialMessage =
  await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    pushService.initialData = initialMessage.data;
  }

  // Initializing Push Service
  await pushService.init();

  // Run the app
  runApp(MyApp(
    languages: languages,
    isLoggedIn: isLoggedIn,
  ));
}







class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final bool? isLoggedIn;

  const MyApp({Key? key, required this.languages, this.isLoggedIn})
      : super(key: key);

  get d => null;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizeController) {
        return GetMaterialApp(
          theme: ThemeData(
            // useMaterial3: true,
          //  fontFamily: AppConstants.fontFamily,
            primaryColor: kMainColor,
            secondaryHeaderColor: const Color(0xFF1ED7AA),
            disabledColor: const Color(0xFFBABFC4),
            brightness: Brightness.light,
            hintColor: const Color(0xFF9F9F9F),
            cardColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: kMainColor)),
            colorScheme: const ColorScheme.light(
                    primary: kMainColor, secondary: kMainColor)
                .copyWith(background: const Color(0xFFF3F3F3))
                .copyWith(error: const Color(0xFFE84D4F)),
          ),
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          locale: localizeController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
              AppConstants.languages[0].countryCode),
          home: const Splash(),

          // home: isLoggedIn == true ? Myapp() : AuthScreen(),

          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),

          // New: register routes (GetPages) for notifications

        );
      },
    );
  }
}

//mmmmmmmmmmmmmm

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put(sharedPreferences);

  // Repository

  Get.put(LanguageRepo());

  // Controller

  Get.put(LocalizationController(sharedPreferences: Get.find()));
  Get.put(LanguageController(sharedPreferences: Get.find()));
  Get.put(AuthController());
  Get.lazyPut(() => NotificationController(), fenix: true);
  //Get.put(PushNotificationService(), permanent: true);
  Get.put(NavbarController());
  Get.put(ShipmentController());
  Get.put(BannersController());
  Get.put(PermissionController());
  Get.put(AccountController());
  Get.put(SalaryController());
  Get.put(AttendanceController());
  Get.put(MaintenanceController());
  Get.put(DeliveryProjectController());
  // Notification service (simple in-memory service)
  //Get.put(NotificationController());
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> jsons = {};
    mappedJson.forEach((key, value) {
      jsons[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        jsons;
  }

  return languages;
}
/*Future<void> execute(
    InternetConnectionChecker internetConnectionChecker,
    ) async {
  // Simple check to see if we have Internet
  // ignore: avoid_print
  print('''The statement 'this machine is connected to the Internet' is: ''');
  final bool isConnected = await InternetConnectionChecker().hasConnection;
  // ignore: avoid_print
  print(
    isConnected.toString(),
  );
  // returns a bool

  // We can also get an enum instead of a bool
  // ignore: avoid_print
  print(
    'Current status: ${await InternetConnectionChecker().connectionStatus}',
  );
  // Prints either InternetConnectionStatus.connected
  // or InternetConnectionStatus.disconnected

  // actively listen for status updates
  final StreamSubscription<InternetConnectionStatus> listener =
  InternetConnectionChecker().onStatusChange.listen(
        (InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
        // ignore: avoid_print
          print('Data connection is available.');
          break;
        case InternetConnectionStatus.disconnected:
        // ignore: avoid_print
          print('You are disconnected from the internet.');
          break;
      }
    },
  );

  // close listener after 30 seconds, so the program doesn't run forever
  await Future<void>.delayed(const Duration(seconds: 30));
  await listener.cancel();
}*/
class Messages extends Translations {
  final Map<String, Map<String, String>> languages;
  Messages({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages;
  }
}

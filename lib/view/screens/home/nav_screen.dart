import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/language_controller.dart';
import 'package:betakety_app/main.dart';
import 'package:betakety_app/model/personal_data.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/screens/account_statement/account_statement.dart';
import 'package:betakety_app/view/screens/profile/profile_screen.dart';
import 'package:betakety_app/view/screens/home/widget/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/permission_controller.dart';
import '../../../util/constant.dart';
import '../notifications/notifications_screen.dart';
import 'widget/home_notification_dialog.dart';
import 'home_screen.dart';
import '../../../util/styles.dart';
import 'widget/custom_drawer.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  bool mustDialog = true ;
  void _loadData() {

  }
  List<PersonalData> personalDataList = [] ;
  bool isLoading = true;
  Future<void>  mandatoryData() async {
    personalDataList  = await Get.find<AuthController>().getRequiredData();
  }
  Future<void> _initData() async {
    await mandatoryData(); // ✅ ننتظر انتهاء تحميل البيانات
    setState(() {
      isLoading = false; // ✅ انتهى التحميل
    });
  }
  Future<void> checkInternet() async {
    Api api = Api() ;

   /* bool  isConn = await api.checkInternet();
    if (!isConn){
      showCustomSnackBar('no_internet_connection'.tr) ;

    }*/
  }

  @override
  void initState() {
    super.initState();
   //_loadData();
    //checkInternet();
    _initData()  ;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(builder: (navbarController) {
      return Scaffold(
          endDrawer: const CustomDrawer(),
          appBar: AppBar(
            elevation: 2.0,
            leading: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(
                     Images.logo_hr,
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                // Icon(
                //   Icons.notifications,
                //   color: kGreyTextColor,
                // ),
              ],
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: kTitleColor),
            title: Text(
              AppConstants.appName,
              style: kTextStyle,
            ),
            centerTitle: true,
            actions: [
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  icon: Icon(Icons.menu_outlined,
                      color: Theme.of(context).primaryColor),
                );
              }),
            ],
          ),
          resizeToAvoidBottomInset: false,
          body:  isLoading
              ? const Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          ):PageStorage(
              bucket: bucket,
              child: navbarController.screen[navbarController.currentTab]),
          bottomNavigationBar: isLoading?SizedBox():SalomonBottomBar(
            backgroundColor: const Color.fromARGB(255, 250, 247, 247),
            currentIndex: navbarController.currentTab,
            onTap: (i) {
              navbarController.changeScreen(i);
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: const Icon(Icons.home_rounded),
                title: Text(
                  "home".tr,
                  style: fontSizeMedium,
                ),
                selectedColor: kMainColor,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: const Icon(Icons.account_balance_wallet),
                title: Text("account_statement".tr, style: fontSizeMedium),
                selectedColor: kMainColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.notifications),
                // title: const Text("Chat"),
                title: Text("notification".tr, style: fontSizeMedium),
                selectedColor: kMainColor,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: Text("PROFILE".tr, style: fontSizeMedium),
                selectedColor: kMainColor,
              ),
            ],
          ));
    });
  }
}

class NavbarController extends GetxController implements GetxService {
  int _currentTab = 0;
  int get currentTab => _currentTab;

  final List<Widget> screen = [
    const Myapp(),
    const AccountStatement(),
    NotificationScreen(),
    const ProfileScreen()
  ];

  resetNavBar() {
    _currentTab = 0;
    update();
  }

  void changeScreen(int index) {
    _currentTab = index;
    update();
  }
}


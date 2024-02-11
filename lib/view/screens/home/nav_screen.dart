import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/language_controller.dart';
import 'package:betakety_app/main.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/screens/home/widget/mohran2.dart';
import 'package:betakety_app/view/screens/profile/profile_screen.dart';
import 'package:betakety_app/view/screens/home/widget/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/permission_controller.dart';
import '../../../util/constant.dart';
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

  void _loadData() {}
  Future<void> checkInternet() async {
    Api api = Api() ;

    bool  isConn = await api.checkInternet();
    if (!isConn){
      showCustomSnackBar('no_internet_connection'.tr) ;

    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    checkInternet();
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
                      'images/lms.png',
                    ),
                    backgroundColor: Colors.white,
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
          body: PageStorage(
              bucket: bucket,
              child: navbarController.screen[navbarController.currentTab]),
          bottomNavigationBar: SalomonBottomBar(
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
    const FirstRoute(),
    const Screen3(),
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

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Screen 3"),
      ),
    );
  }
}

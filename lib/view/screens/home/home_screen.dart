import 'dart:convert';
import 'dart:io';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/model/instructor_model.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/view/base/banners_view.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/screens/attendance/finger_print.dart';
import 'package:betakety_app/view/screens/salary_details/salary_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../api/api_test.dart';
import '../../../util/app_constants.dart';
import '../../../util/constant.dart';
import 'widget/card_test.dart';
import '../../../util/images.dart';
import 'widget/instructor_list.dart';
import 'widget/mohran.dart';
import '../../../note/add.dart';
import '../../../requests/permissions_requests/add_request_perr_mohran_saddam.dart';
import '../../../requests/permissions_requests/add_request_perr_mohran_saddam2.dart';
import 'widget/squer_screen.dart';
import '../../../util/styles.dart';
import 'widget/widget_list.dart';

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  Api api  = Api()  ;
  List<dynamic> _Data = [];
  List<InstructorItem> instructorsList = [];
  bool loader   = false  ;
  final appcastURL = 'https://www.marsalogistics.com/new/marsadelivery/appcast.xml';
  getBestEmployee() async{
     setState(() {
       loader =  true  ;
     });
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    data["employ_id"] =user.id;
    String url  =  AppConstants.bestEmployee+"?"+"employ_id=" +user.id!   ;
    print(url) ;
    try {
      var response  = await  api.getData(url: url)  ;

      if (response.statusCode == 200) {
        print("employee");
        print(jsonDecode(response.body));
        var result = jsonDecode(response.body) ;
        _Data = (result['data'] as List);
        for (int i = 0 ; i < _Data.length ; i ++) {
          var jsonObj = _Data [i];
          InstructorItem item = InstructorItem.fromJsonEmployee(jsonObj);
          print(item.instructorName) ;

          instructorsList.add(item) ;
        }
        setState(() {
          loader  = false  ;
        });
        return response.body;

      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }
  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Future<void> checkForUpdate() async {
   // InAppUpdate.
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
        if( _updateInfo?.updateAvailability ==
            UpdateAvailability.updateAvailable
        ) {
print("new update")  ;
          InAppUpdate.performImmediateUpdate()
              .catchError((e) {
            showCustomSnackBar(e.toString());

            return AppUpdateResult.inAppUpdateFailed;
          });
        }
        else{
          print("no update")  ;

          showCustomSnackBar("no update");

        }
      });

    }).catchError((e) {
      showCustomSnackBar(e.toString());
    });
  }
  var cfg ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  /*  Upgrader(
        appcastConfig:
        AppcastConfiguration(url: appcastURL, supportedOS: ['android']));*/
    checkForUpdate();

    getBestEmployee() ;
  }
  Future<void> _openStore() async {
    String packageName = 'put your_package_name';
    String appStoreUrl = 'https://apps.apple.com/app/$packageName';
    String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.marsa.marsa_hr';

    if (await canLaunchUrl(Uri.parse(appStoreUrl )) && !Platform.isAndroid) {
      await launchUrl(Uri.parse(appStoreUrl));
    } else if (await canLaunchUrl(Uri.parse(playStoreUrl)) && Platform.isAndroid) {
      await launchUrl(Uri.parse(playStoreUrl));
    } else {
      throw 'Could not launch store';
    }
  }
  @override
  Widget build(BuildContext context) {
     const appcastURL =
        'https://www.marsalogistics.com/new/marsadelivery/appcast.xml';
    final upgrader = Upgrader(
        durationUntilAlertAgain: const Duration(seconds: 3),
        appcastConfig:
        AppcastConfiguration(url: appcastURL, supportedOS: ['android' ,'ios']));
    return

     UpgradeAlert(
       /* onIgnore: (){
          SystemNavigator.pop();
          throw UnsupportedError('_');
        } ,*/
        upgrader: upgrader,
         onUpdate: (){
_openStore()  ;
SystemNavigator.pop();
throw UnsupportedError('_');
return true;
         },
          showIgnore: true,
         showLater: false,

         child:

      Scaffold(
        key: _scaffoldKey,
      backgroundColor: Colors.white,
      body:


      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const Slider1(),
                SizedBox(
                  height: 20,
                ),
                const BannersView(),
                SizedBox(
                  height: 40,
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Squermain(
                      title: 'requests'.tr,
                      //title: Text("PROFILE".tr)
                      image: Images.request,
                      width: Get.width / 3.2,
                      height: Get.width / 3.2,
                      screen: WidgetList(),
                    ),
                    Squermain(
                      title: 'salaries'.tr,
                      image: Images.salary,
                      width: Get.width / 3.2,
                      height: Get.width / 3.2,
                      screen: salary_details_view(),
                    ),
                    Squermain(
                      title: 'Attendance_and_Departure'.tr,
                      image: Images.att,
                      width: Get.width / 3.2,
                      height: Get.width / 3.2,
                      screen: FingerPrint(),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HelloWorldApp()),
                    );
                  },
                  child: Container(
                    child: const Text(''),
                    color: Color.fromARGB(255, 255, 255, 255),
                    height: 20,
                    width: 100,
                  ),
                ),
//notification_screen=========================================================
            /*   const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: [
                      Text(
                        'best_employees'.tr,
                        style: fontSizeMedium.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                           InstructorList(instructors:instructorsList).launch(context);
                        },
                        child: Text(
                          'see_all'.tr,
                          style: fontSizeMedium.copyWith(color: kGreyTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
            loader?  Center(child: Container(width: 24,child:CircularProgressIndicator())) :  HorizontalList(
                  spacing: 10,
                  itemCount: instructorsList.length,
                  itemBuilder: (_, i) {
                    return InstructorCard(instructorList: instructorsList[i]).onTap(
                      () {},
                      highlightColor: context.cardColor,
                    );
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),*/
//notification_screen==============/=======================================

                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => HelloWorldApp()),
                //     );
                //   },
                //   child: const Text('Button'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => HelloWorldApp()),
                //     );
                //   },
                //   child: const Text('Button1'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const FirstRoute()),
                //     );
                //   },
                //   child: const Text('Button2'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => MyApp3()),
                //     );
                //   },
                //   child: const Text('Button3'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const BottomNavigationBar1()),
                //     );
                //   },
                //   child: const Text('Bottom Navigation1'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const BottomNavigationBar11()),
                //     );
                //   },
                //   child: const Text('Bottom Navigation11 class footer'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               const BottomNavigationBarExampleApp()),
                //     );
                //   },
                //   child: const Text('Bottom Navigation3 open page'),
                // ),

                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const appbar_top()),
                //     );
                //   },
                //   child: const Text('appbar_top'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const SimpleTabBar()),
                //     );
                //   },
                //   child: const Text('SimpleTabBar'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const ProfileScreen()),
                //     );
                //   },
                //   child: const Text('Profile'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const MyApp()),
                //     );
                //   },
                //   child: const Text('drawer'),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     // Add your button's functionality here
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const Slider1()),
                //     );
                //   },
                //   child: const Text('slider2222'),
                // ),
             /*   ElevatedButton(
                  onPressed: () {
                    // Add your button's functionality here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AddRequestPerMohranSaddam()),
                    );
                  },
                  child: const Text('إضافة طلب إذن 22555555'),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Add your button's functionality here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AddRequestPerMohranSaddamm()),
                    );
                  },
                  child: const Text('إضافة طلب إذن 2024 بدون مرفقات'),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Add your button's functionality here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListLayouts()),
                    );
                  },
                  child: const Text('api test'),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Add your button's functionality here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CardExamplesApp()),
                    );
                  },
                  child: const Text('Card Test'),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Add your button's functionality here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddNotes()),
                    );
                  },
                  child: const Text('Add Note'),
                ),*/

                // // Container(
                //   child: const Text('Container 2'),
                //   color: Colors.green,
                //   height: 100,
                //   width: 100,
                // ),
                // Container(
                //   child: const Text('Container 3'),
                //   color: Colors.red,
                //   height: 100,
                //   width: 100,
                // ),
              ],
            ),
          ),
        ),
      ),
      //  bottomNavigationBar: const BottomNavigationBar11(),
      )) ;
  }
}

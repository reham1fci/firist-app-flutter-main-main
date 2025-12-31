import 'dart:convert';
import 'dart:io';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/model/instructor_model.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/personal_data.dart';
import 'package:betakety_app/view/base/banners_view.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/screens/agent_orders/agent_daily_order_screen.dart';
import 'package:betakety_app/view/screens/home/widget/home_notification_dialog.dart';
import 'package:betakety_app/view/screens/attendance/finger_print.dart';
import 'package:betakety_app/view/screens/home/widget/shipments_type_list.dart';
import 'package:betakety_app/view/screens/home/widget/target_type.dart';
import 'package:betakety_app/view/screens/profile/widgets/edit_profile.dart';
import 'package:betakety_app/view/screens/profile/widgets/requests_list.dart';
import 'package:betakety_app/view/screens/salary_details/salary_details_view.dart';
import 'package:betakety_app/view/screens/shipments/shipments_screen.dart';
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

  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  var cfg ;
   bool mustDialog = false ;
  List<PersonalData> personalDataList = [] ;

  getUserData() async {
     LoginResponsModel user =  await AuthController().getLoginData()  ;
      if(user.mustDialog !=null ){
        mustDialog =user.mustDialog!  =="1" ? false : true;
      }
      print(user.mustDialog);
   }
  Future<bool>  mandatoryDataFound() async {
    personalDataList  = await Get.find<AuthController>().getRequiredData();
     if(personalDataList.isNotEmpty) {
       return true ;
     } else {
       return false ;
     }

  }
  bool  mandatoryData()  {
      personalDataList  =  Get.find<AuthController>().personalDataList;
       if(personalDataList.isNotEmpty){
         return true ;
       }
        else{
          return false ;
       }

    }
     bool isMandatoryData   = true  ;
   showDialog()  async {

     bool result = await mandatoryDataFound();

     setState(() {
       isMandatoryData = result;
     });

print("man"+ isMandatoryData.toString()) ;
     if( isMandatoryData){
     print(mustDialog) ;
     showOkDialog(context: context,  isCancelBtn: true, onOkClick: (){
     Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(from: "home",))).then((value) async {
if( isMandatoryData){

     }
else{
Navigator.of(context).pop() ;
}
     });

     }) ;
     }
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_)  {

showDialog();
    });
  /*  Upgrader(
        appcastConfig:
        AppcastConfiguration(url: appcastURL, supportedOS: ['android']));*/
   // checkForUpdate();

   // getBestEmployee() ;
  }
  Future<void> _openStore() async {
    String packageName = 'com.marsa.marsa-hr';
    String appStoreUrl = ''
        '';
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
       onIgnore: (){
          SystemNavigator.pop();
          throw UnsupportedError('_');
        } ,
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
                      image: Images.requests,
                      width: Get.width / 3.2,
                      height: Get.width / 3,
                      screen:
                      isMandatoryData? null:
                      WidgetList(),
                    ),
                    Squermain(
                      title: 'salaries'.tr,
                      image: Images.salary,
                      width: Get.width / 3.2,
                      height: Get.width / 3,
                      screen: isMandatoryData? null :salary_details_view(),
                    ),
                    Squermain(
                      title: 'Attendance_and_Departure'.tr,
                      image: Images.attendance,
                      width: Get.width / 3.2,
                      height: Get.width / 3,
                      screen: FingerPrint(),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),

                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Squermain(
                      title: 'shipments'.tr,
                      //title: Text("PROFILE".tr)
                      image: Images.shipments,
                      width: Get.width / 3.2,
                      height: Get.width / 3,
                      screen: isMandatoryData? null:ShipmentsTypeList(),
                    ),
                    Squermain(
                      title: 'target'.tr,
                      //title: Text("PROFILE".tr)
                      image: Images.target,
                      width: Get.width / 3.2,
                      height: Get.width / 3,
                      screen: isMandatoryData? null:TargetType(),
                    ),
                    SizedBox(width: Get.width / 3.2)
                  ],
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
     )
    ) ;
  }
}

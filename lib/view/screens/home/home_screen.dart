import 'package:betakety_app/view/base/banners_view.dart';
import 'package:betakety_app/view/screens/attendance/finger_print.dart';
import 'package:betakety_app/view/screens/salary_details/salary_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../api/api_test.dart';
import '../../../util/constant.dart';
import 'widget/card_test.dart';
import '../../../util/images.dart';
import 'widget/instructor_list.dart';
import 'widget/instructor_model.dart';
import 'widget/mohran.dart';
import '../../../note/add.dart';
import '../../../requests/permissions_requests/add_request_perr_mohran_saddam.dart';
import '../../../requests/permissions_requests/add_request_perr_mohran_saddam2.dart';
import 'widget/squer_screen.dart';
import '../../../util/styles.dart';
import 'widget/widget_list.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
                const SizedBox(
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
                          const InstructorList().launch(context);
                        },
                        child: Text(
                          'see_all'.tr,
                          style: fontSizeMedium.copyWith(color: kGreyTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
                HorizontalList(
                  spacing: 10,
                  itemCount: instructors.length,
                  itemBuilder: (_, i) {
                    return InstructorCard(instructorList: instructors[i]).onTap(
                      () {},
                      highlightColor: context.cardColor,
                    );
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
    );
  }
}

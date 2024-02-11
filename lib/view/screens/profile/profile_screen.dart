// import 'package:betakety_app/images.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// //import '../Home/wishlist_screen.dart';
// //import '../Notification/notification_screen.dart';
// //import 'package:maan_ui/Screens/Full%20Template/MaanLMS/Screens/Profile/edit_profile.dart';
// //import 'package:nb_utils/nb_utils.dart';
// import 'styles.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   iconTheme: const IconThemeData(color: kTitleColor),
//       //   backgroundColor: const Color.fromARGB(255, 186, 178, 178),
//       //   elevation: 0.0,
//       //   centerTitle: true,
//       //   title: Text(
//       //     'Profile',
//       //     style: kTextStyle.copyWith(color: kTitleColor),
//       //   ),
//       //   actions: [
//       //     Padding(
//       //       padding: const EdgeInsets.only(right: 15.0),
//       //       child: GestureDetector(
//       //         onTap: () {
//       //           // const NotificationScreen().launch(context);
//       //         },
//       //         child: const Icon(FontAwesomeIcons.solidBell),
//       //       ),
//       //     ),
//       //   ],
//       // ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20.0,
//             ),
//             const CircleAvatar(
//               radius: 60.0,
//               backgroundImage: AssetImage(Images.calender),
//               backgroundColor: kTitleColor,
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//             Text(
//               'مهران أحمد حسن محمد',
//               style: fontSizeMedium.copyWith(
//                   color: kTitleColor,
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '+1254 2563 2565',
//               style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 14.0),
//             ),
//             const SizedBox(
//               height: 20.0,
//             ),
//             ProfileOptions(
//               title: 'Edit Profile',
//               image: 'images/lms/editprofileicon.png',
//               pressed: () {
//                 // const EditProfile().launch(context);
//               },
//               background: const Color(0xFFFBECD9),
//             ),
//             ProfileOptions(
//               title: 'Payment Details',
//               image: 'images/lms/paymentdetailsicon.png',
//               pressed: () {},
//               background: const Color(0xFFD2E4FF),
//             ),
//             ProfileOptions(
//               title: 'Notification',
//               image: 'images/lms/notificationicon.png',
//               pressed: () {
//                 //const NotificationScreen().launch(context);
//               },
//               background: const Color(0xFFE1DDFF),
//             ),
//             ProfileOptions(
//               title: 'WishList',
//               image: 'images/lms/wishlisticon.png',
//               pressed: () {
//                 // const WishListScreen().launch(context);
//               },
//               background: const Color(0xFFFBEAE2),
//             ),
//             ProfileOptions(
//               title: 'Language',
//               image: 'images/lms/languageicon.png',
//               pressed: () {},
//               background: const Color(0xFFD5EDED),
//             ),
//             ProfileOptions(
//               title: 'Log Out',
//               image: 'images/lms/logouticon.png',
//               pressed: () {},
//               background: const Color(0xFFF8E2E2),
//             ),
//           ],
//         ),
//       ),
//       //  bottomNavigationBar: BottomNavigationBar11(),
//     );
//   }
// }

// // ignore: must_be_immutable
// class ProfileOptions extends StatelessWidget {
//   ProfileOptions(
//       {Key? key,
//       required this.title,
//       required this.image,
//       required this.pressed,
//       required this.background})
//       : super(key: key);
//   String title, image;
//   Color background;

//   // ignore: prefer_typing_uninitialized_variables
//   var pressed;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
//       child: GestureDetector(
//         onTap: pressed,
//         child: Container(
//           width: double.infinity,
//           height: 60.0,
//           decoration: kButtonDecoration.copyWith(color: background),
//           child: Center(
//             child: ListTile(
//               leading: Image.asset(image),
//               title: Text(
//                 title,
//                 style: kTextStyle.copyWith(color: kTitleColor),
//               ),
//               // trailing: const Icon(
//               //   Icons.arrow_forward_ios,
//               //   color: kTitleColor,
//               // ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/constant.dart';
import '../../../util/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // عرض بيانات الموظفين
  String id = '';
  String name = '';
  String email = '';
  String mobilenumber = '';
  String photo = '';
  String nameen = '';
  String companynamear = '';
  String companynameen = '';
  String deptname = '';
  String deptnameen = '';
  String jobname = '';
  String jobnameen = '';
  @override
  void initState() {
    super.initState();
    getLoginData();
  }

  void getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseData = prefs.getString('user');
    if (responseData != null) {
      Map<String, dynamic> responseJson = json.decode(responseData);
      setState(() {
        id = responseJson['id'];
        name = responseJson['name'];
        email = responseJson['email'];
        mobilenumber = responseJson['mobilenumber'];
        photo = responseJson['photo'];
        nameen = responseJson['nameen'];
        companynamear = responseJson['companynamear'];
        companynameen = responseJson['companynameen'];
        deptname = responseJson['deptname'];
        deptnameen = responseJson['deptnameen'];
        jobname = responseJson['jobname'];
        jobnameen = responseJson['jobnameen'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(photo),
              backgroundColor: kTitleColor,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              name,
              style: fontSizeMedium.copyWith(
                  color: kTitleColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              nameen,
              style: kTextStyle.copyWith(color: kGreyTextColor, fontSize: 14.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ProfileOptions(
              title: mobilenumber,
              image: 'images/lms/mobie_num_icon.png',
              pressed: () {
                // const EditProfile().launch(context);
              },
              background: const Color(0xFFFBECD9),
            ),
            ProfileOptions(
              title: email,
              // image: 'images/lms/paymentdetailsicon.png',
              image: 'images/lms/email-icon1.png',
              pressed: () {},
              background: const Color(0xFFD2E4FF),
            ),
            ProfileOptions(
              title: companynamear.tr,
              image: 'images/lms/comp44_icon.png',
              pressed: () {
                //const NotificationScreen().launch(context);
              },
              background: const Color(0xFFE1DDFF),
            ),
            ProfileOptions(
              title: deptname,
              image: 'images/lms/dept_gz_icon1.png',
              pressed: () {
                // const WishListScreen().launch(context);
              },
              background: const Color(0xFFFBEAE2),
            ),
            ProfileOptions(
              title: jobname,
              image: 'images/lms/job_gz_icon1.png',
              pressed: () {},
              background: const Color(0xFFD5EDED),
            ),
            // ProfileOptions(
            //   title: 'Log Out1',
            //   image: 'images/lms/logouticon.png',
            //   pressed: () {},
            //   background: const Color(0xFFF8E2E2),
            // ),
            // ProfileOptions(
            //   title: 'Log Out2',
            //   image: 'images/lms/logouticon.png',
            //   pressed: () {},
            //   background: const Color(0xFFF8E2E2),
            // ),
            // ProfileOptions(
            //   title: 'Log Out3',
            //   image: 'images/lms/logouticon.png',
            //   pressed: () {},
            //   background: const Color(0xFFF8E2E2),
            // ),
          ],
        ),
      ),
      //  bottomNavigationBar: BottomNavigationBar11(),
    );
  }
}

// ignore: must_be_immutable
class ProfileOptions extends StatelessWidget {
  ProfileOptions(
      {Key? key,
      required this.title,
      required this.image,
      required this.pressed,
      required this.background})
      : super(key: key);
  String title, image;
  Color background;

  // ignore: prefer_typing_uninitialized_variables
  var pressed;

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
  //     child: GestureDetector(
  //       onTap: pressed,
  //       child: Container(
  //         width: double.infinity,
  //         height: 60.0,
  //         decoration: kButtonDecoration.copyWith(color: background),
  //         child: Center(
  //           child: ListTile(
  //             leading: Image.asset(image),
  //             title: Text(
  //               title,
  //               style: kTextStyle.copyWith(color: kTitleColor),
  //             ),
  //             // trailing: const Icon(
  //             //   Icons.arrow_forward_ios,
  //             //   color: kTitleColor,
  //             // ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: GestureDetector(
        onTap: pressed,
        child: Container(
          width: double.infinity,
          height: 60.0,
          decoration: kButtonDecoration.copyWith(color: background),
          child: Center(
            child: ListTile(
              leading: Image.asset(
                image,
                width: 30.0, // Set your desired width
                height: 30.0, // Set your desired height
              ),
              title: Text(
                title,
                //style: kTextStyle.copyWith(color: kTitleColor),
                style: fontSizeMedium.copyWith(
                    color: kTitleColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              // trailing: const Icon(
              //   Icons.arrow_forward_ios,
              //   color: kTitleColor,
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

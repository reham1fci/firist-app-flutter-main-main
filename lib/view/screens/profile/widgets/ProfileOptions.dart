// ignore: must_be_immutable
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:flutter/material.dart';

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
            child: Material(
            color: Colors.transparent, child: ListTile(
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
    ));
  }
}
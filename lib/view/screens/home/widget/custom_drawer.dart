import 'dart:convert';

import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_category_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../langulage/change_language.dart';
import '../../../base/animated_custom_dialog.dart';
import '../../../base/sign_out_confirmation_dialog.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String id = "" ;
  String name = "" ;
  String email = "" ;
  String photo = "" ;
  @override
  void initState() {
    super.initState();
    getUserData() ;
  }
  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseData = prefs.getString('user');
    if (responseData != null) {
      Map<String, dynamic> responseJson = json.decode(responseData);
      setState(() {
        id = responseJson['id'];
        name = responseJson['name'];
        email = responseJson['email'];
        photo = responseJson['photo'];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width > 750
          ? MediaQuery.of(context).size.width * 0.25
          : MediaQuery.of(context).size.width * 0.6,
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            height: 250,
            child: Column(children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top),
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        Images.logo_with_name,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Text(
                name,
                style: fontSizeRegular.copyWith(
                  color: Theme.of(context).cardColor,
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  email,
                  style: fontSizeRegular.copyWith(
                    color: Theme.of(context).cardColor,
                    fontSize: Dimensions.fontSizeSmall,
                  ),
                ),
              ),
            ]),
          ),
          Expanded(
            child: ListView(padding: EdgeInsets.zero, children: [
              CustomCategoryButton(
                icon: Images.language_logo,
                buttonText: 'change_language'.tr,
                onTap: () {
                  Get.back();
                  Get.to(const ChooseLanguageScreen());
                },
              ),
              CustomCategoryButton(
                  icon: Images.logout,
                  buttonText: 'log_out'.tr,
                  onTap: () => {
                        Get.back(),

                        showAnimatedDialog(
                            context, const SignOutConfirmationDialog(),
                            isFlip: true),
                        // Get.find<AuthController>().logout()
                      }),
            ]),
          ),
        ],
      ),
    );
  }
}

import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_password_textfield.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/constant.dart';

class NewPassScreen extends StatefulWidget {
  const NewPassScreen({super.key});

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<AuthController>().resetData();
    });  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return Scaffold(

  appBar: AppBar(
    iconTheme: const IconThemeData(color: kTitleColor),
    centerTitle: true,
    title: Text(
      'new_password'.tr,
      style: fontSizeMedium,
    ),
    actions: const [
      SizedBox(
        width: 5.0,
      ),
    ],
    backgroundColor: Colors.white,
    elevation: 2.0,
  ),
   body:
   GetBuilder<AuthController>(
     builder: (auth) => Expanded(
         child: ListView(
             padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
             children: [
               Padding(
                 padding: const EdgeInsets.all(50),
                 child: Image.asset(Images.logo_hr,
                     height: 150, width: 200),
               ),
               Text('enter new password'.tr, style: titilliumSemiBold),
               Container(
                   margin: const EdgeInsets.only(
                       bottom: Dimensions.PADDING_SIZE_DEFAULT),
                   child: CustomPasswordTextField(
                     hintTxt: 'new_password'.tr,
                     textInputAction: TextInputAction.done,
                    // focusNode: _passNode,
                     controller: auth.passwordController,
                     onChanged: (value) {
                       auth.validatePassword(value);
                     },
                   )),
               passwordRule('6 characters minimum', auth.hasMinLength),
               passwordRule('Capital letter', auth.hasUpperCase),
               passwordRule('Small letter', auth.hasLowerCase),
               passwordRule('Special character', auth.hasSpecialChar),
               const SizedBox(height: 20),

               Container(
                   margin: const EdgeInsets.only(
                       bottom: Dimensions.PADDING_SIZE_DEFAULT),
                   child: CustomPasswordTextField(
                     hintTxt: 'confirm_password'.tr,
                     textInputAction: TextInputAction.done,
                    // focusNode: _passNode,
                     controller: auth.confirmPasswordController,
               )),

               const SizedBox(height: 100),
               !auth.isLoading
                   ? CustomButton(
                 buttonText: 'reset'.tr,
                 onPressed: auth.isPasswordValid
                   ? () {
                 // call API
                    if(auth.passwordController!.text == auth.confirmPasswordController!.text){
                   auth.resetPassword();
                    }
                    else{
                      showCustomSnackBar('password_not_match'.tr);
                    }
               }
                   : null,
               )
                   : Center(
                   child: CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation<Color>(
                           Theme.of(context).primaryColor))),
             ]),
       ),

)) ;


  }
  Widget passwordRule(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isValid ? Colors.green : Colors.grey,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.grey,
          ),
        ),
      ],
    );
  }

}
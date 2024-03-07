import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/screens/auth/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/custom_button.dart';
import '../../../base/custom_password_textfield.dart';
import '../../../base/custom_text_field.dart';

class SignInWidget extends StatefulWidget {
 const  SignInWidget({Key? key}) : super(key: key);

  @override
  SignInWidgetState createState() => SignInWidgetState();
}

class SignInWidgetState extends State<SignInWidget> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeyLogin;
  Api api = Api() ;

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    //_emailController!.text = '';
    //_passwordController!.text = '';
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }

  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        builder: (s) => Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_LARGE),
              child: Form(
                key: _formKeyLogin,
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL),
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: Dimensions.PADDING_SIZE_SMALL),
                      child: CustomTextField(
                        hintText: 'ENTER_YOUR_EMAIL_or_mobile'.tr,
                        focusNode: _emailNode,
                        nextFocus: _passNode,
                        inputType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            bottom: Dimensions.PADDING_SIZE_DEFAULT),
                        child: CustomPasswordTextField(
                          hintTxt: 'ENTER_YOUR_PASSWORD'.tr,
                          textInputAction: TextInputAction.done,
                          focusNode: _passNode,
                          controller: _passwordController,
                        )),
                    Container(
                      margin: const EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_SMALL),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => {Get.to(const ForgetPasswordScreen())},
                            child: Text('FORGET_PASSWORD'.tr,
                                style: titilliumRegular.copyWith(
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 30),
                      child: Get.find<AuthController>().isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          : CustomButton(
                              onPressed: () {
                                _login();
                              },
                              buttonText: 'SIGN_IN'.tr),
                    ),
                    const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  ],
                ),
              ),
            ));
  }

  Future<void> _login() async {
    String email = _emailController!.text.trim();
    String password = _passwordController!.text.trim();
    if (email.isEmpty) {
      showCustomSnackBar('EMAIL_MUST_BE_REQUIRED'.tr);
    } else if (password.isEmpty) {
      showCustomSnackBar('PASSWORD_MUST_BE_REQUIRED'.tr);
    } else {
     // Get.offAll(NavBarScreen());
      if(await api.checkInternet()) {
        Get.find<AuthController>().login(email: email, password: password);
      }
      else {
        showCustomSnackBar('no_internet_connection'.tr) ;
      }
    }
  }
}

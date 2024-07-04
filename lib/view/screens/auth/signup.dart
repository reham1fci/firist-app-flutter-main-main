import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_password_textfield.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:betakety_app/view/screens/auth/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class  SignUp extends StatefulWidget{


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController? _emailController;
  TextEditingController? _nameEnController;
  TextEditingController? _nameArController;
  TextEditingController? _userNmController;
  TextEditingController? _phoneController;
  TextEditingController? _passwordController;
  GlobalKey<FormState>? _formKeySignUp;
  Api api = Api() ;

  @override
  void initState() {
    super.initState();
    _formKeySignUp= GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameArController = TextEditingController();
    _nameEnController = TextEditingController();
    _userNmController = TextEditingController();
    _phoneController = TextEditingController();
    //_emailController!.text = '';
    //_passwordController!.text = '';
  }

  @override
  void dispose() {
    _emailController!.dispose();
    _passwordController!.dispose();
    super.dispose();
  }
  signup(){
    print("signupfunc") ;

    String email = _emailController!.text.trim();
    String password = _passwordController!.text.trim();
    String nameEn = _nameEnController!.text;
    String nameAr = _nameArController!.text;
    String phone = _phoneController!.text.trim();
    String userName = _userNmController!.text;
    print(userName) ;

    Get.find<AuthController>().validateSignUpData(nameEn, userName, nameAr, email, password, phone);


  }
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passNode = FocusNode();
  final FocusNode _nameEnNode = FocusNode();
  final FocusNode _nameArNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _userNameNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(

        appBar: AppBar(
        iconTheme: const IconThemeData(color: kTitleColor),
    centerTitle: true,
    title: Text(
    'SIGN_UP'.tr,
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
    body:  GetBuilder<AuthController>(
        builder: (s) => Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: Form(
            key: _formKeySignUp,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_SMALL),
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                  child: CustomTextField(
                    hintText: 'Enter_full_name_en'.tr,
                    focusNode: _nameEnNode,
                    nextFocus: _nameArNode,
                    inputType: TextInputType.name,
                    controller: _nameEnController,
                  ),
                ),  Container(
                  margin: const EdgeInsets.only(
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                  child: CustomTextField(
                    hintText: 'Enter_full_name_ar'.tr,
                    focusNode: _nameArNode,
                    nextFocus: _userNameNode,
                    inputType: TextInputType.name,
                    controller: _nameArController,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                  child: CustomTextField(
                    hintText: 'user_name'.tr,
                    focusNode: _userNameNode,
                    nextFocus: _phoneNode,
                    inputType: TextInputType.emailAddress,
                    controller: _userNmController,
                  ),
                ),  Container(
                  margin: const EdgeInsets.only(
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                  child: CustomTextField(
                    hintText: 'PHONE_NO'.tr +"   "+'optional'.tr,
                    focusNode: _phoneNode,
                    nextFocus: _emailNode,
                    inputType: TextInputType.emailAddress,
                    controller: _phoneController,
                  ),
                ),  Container(
                  margin: const EdgeInsets.only(
                      bottom: Dimensions.PADDING_SIZE_SMALL),
                  child: CustomTextField(
                    hintText: 'EMAIL'.tr,
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
                      hintTxt: 'PASSWORD'.tr,
                      textInputAction: TextInputAction.done,
                      focusNode: _passNode,
                      controller: _passwordController,
                    )),

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
                        print("btn work ") ;
                        signup();
                      },
                      buttonText: 'SIGN_UP'.tr),
                ),
                const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
              ],
            ),
          ),
        )));
  }

}
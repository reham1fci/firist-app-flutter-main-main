import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../base/custom_button.dart';
import '../../base/custom_text_field.dart';
import '../../../controllers/auth_controller.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _controller = TextEditingController();
  String completeNumber = '';
  final GlobalKey<ScaffoldMessengerState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Column(
        children: [
          SafeArea(
              child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () => Navigator.pop(context),
            ),
          )),
          Expanded(
            child: ListView(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Image.asset(Images.logo_hr,
                        height: 150, width: 200),
                  ),
                  Text('FORGET_PASSWORD'.tr, style: titilliumSemiBold),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Divider(
                            thickness: 1,
                            color: Theme.of(context).primaryColor)),
                    Expanded(
                        flex: 2,
                        child: Divider(
                            thickness: 0.2,
                            color: Theme.of(context).primaryColor)),
                  ]),
                  Text('enter_register_phone'.tr,
                      style: titilliumRegular.copyWith(
                          color: Theme.of(context).hintColor,
                          fontSize: Dimensions.fontSizeExtraSmall)),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  // CustomTextField(
                  //   controller: _controller,
                  //   hintText: 'ENTER_YOUR_EMAIL'.tr,
                  //   inputAction: TextInputAction.done,
                  //   inputType: TextInputType.emailAddress,
                  // ),
    Directionality(
    textDirection: TextDirection.ltr,
   child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'PHONE_NO'.tr,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'SA', // تبدأ بمصر مثلاً
                    onChanged: (phone) {
                      print(phone.completeNumber);
                      completeNumber  = phone.completeNumber ;// +201234567890
                    },
                  )),

                  const SizedBox(height: 100),
                  !Get.find<AuthController>().isLoading
                      ? CustomButton(
                          buttonText: 'send_otp'.tr,
                          onPressed: () {
                            Get.find<AuthController>().forgetPassword(
                                phone: completeNumber.substring(1));
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor))),
                ]),
          ),
        ],
      ),
    );
  }
}

import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  const SignOutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width > 750
            ? MediaQuery.of(context).size.width * 0.3
            : null,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 50),
            child: Text('want_to_sign_out'.tr,
                style: fontSizeRegular, textAlign: TextAlign.center),
          ),
          const Divider(height: 0),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () {
                  Get.offAll(AuthScreen());
                  //Get.find<AuthController>().logout();
                },
                child: Container(
                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(10))),
                  child: Text('yes'.tr,
                      style: fontSizeRegular.copyWith(
                          color: Theme.of(context).primaryColor)),
                ),
              )),
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10))),
                    child: Text('no'.tr,
                        style: fontSizeRegular.copyWith(
                            color: Theme.of(context).cardColor)),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

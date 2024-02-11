import 'package:betakety_app/view/base/color_resources.dart';
import 'package:betakety_app/view/screens/auth/widget/sign_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../langulage/change_language.dart';
import '../../../util/styles.dart';

class AuthScreen extends StatelessWidget {
  final int initialPage;
  const AuthScreen({Key? key, this.initialPage = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Stack(

      body: Container(
        // color: Color.fromRGBO( 95, 171, 199, 0.477), // Set the background color here

        child: Stack(
          clipBehavior: Clip.none,
          children: [
            GetBuilder<AuthController>(
              builder: (authController) => SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: Dimensions.topSpace),
                    Image.asset(Images.logo_with_name, height: 150, width: 200),
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            bottom: 0,
                            right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                            left: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                              color: ColorResources.getGainsBoro(context),
                            ),
                          ),
                          GetBuilder<AuthController>(
                            builder: (authController) => Row(
                              children: [
                                Column(
                                  children: [
                                    Text('SIGN_IN'.tr,
                                        style: titilliumSemiBold),
                                    Container(
                                      height: 1,
                                      width: 40,
                                      margin: const EdgeInsets.only(top: 8),
                                      color: authController.selectedIndex == 0
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SignInWidget()),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 30,
              child: InkWell(
                child: const Icon(
                  Icons.language_sharp,
                  size: 30,
                ),
                onTap: () => {Get.to(const ChooseLanguageScreen())},
              ),
            )
          ],
        ),
      ),

      //   clipBehavior: Clip.none,
      //   children: [
      //     GetBuilder<AuthController>(
      //       builder: (authController) => SafeArea(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             const SizedBox(height: Dimensions.topSpace),
      //             Image.asset(Images.logo_with_name, height: 150, width: 200),
      //             Padding(
      //               padding:
      //                   const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      //               child: Stack(
      //                 clipBehavior: Clip.none,
      //                 children: [
      //                   Positioned(
      //                     bottom: 0,
      //                     right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
      //                     left: 0,
      //                     child: Container(
      //                       width: MediaQuery.of(context).size.width,
      //                       height: 1,
      //                       color: ColorResources.getGainsBoro(context),
      //                     ),
      //                   ),
      //                   GetBuilder<AuthController>(
      //                     builder: (authController) => Row(
      //                       children: [
      //                         Column(
      //                           children: [
      //                             Text('SIGN_IN'.tr, style: titilliumSemiBold),
      //                             Container(
      //                               height: 1,
      //                               width: 40,
      //                               margin: const EdgeInsets.only(top: 8),
      //                               color: authController.selectedIndex == 0
      //                                   ? Theme.of(context).primaryColor
      //                                   : Colors.transparent,
      //                             ),
      //                           ],
      //                         ),
      //                         const SizedBox(
      //                             width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             const Expanded(child: SignInWidget()),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Positioned(
      //       top: 50,
      //       right: 30,
      //       child: InkWell(
      //         child: const Icon(
      //           Icons.language_sharp,
      //           size: 30,
      //         ),
      //         onTap: () => {Get.to(const ChooseLanguageScreen())},
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}

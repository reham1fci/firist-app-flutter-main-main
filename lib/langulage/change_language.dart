import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/language_controller.dart';
import '../controllers/localization_controller.dart';
import '../view/base/custom_snackbar.dart';
import '../util/dimensions.dart';
import '../util/styles.dart';
import '../view/base/custom_button.dart';
import 'widget/language_widget.dart';

class ChooseLanguageScreen extends StatelessWidget {
  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<LocalizationController>(
        builder: (localizationController) {
          return Column(children: [
            Expanded(
              child: Center(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width > 750
                            ? MediaQuery.of(context).size.width * 0.5
                            : MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Text('select_language'.tr,
                                  style: fontSizeMedium.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                                  )),
                            ),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: (1 / 1),
                              ),
                              itemCount:
                                  localizationController.languages.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => LanguageWidget(
                                languageModel:
                                    localizationController.languages[index],
                                localizationController: localizationController,
                                index: index,
                              ),
                            ),
                            const SizedBox(
                                height: Dimensions.PADDING_SIZE_LARGE),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT,
                right: Dimensions.PADDING_SIZE_DEFAULT,
                bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonText: 'save'.tr,
                      onPressed: () {
                        if (localizationController.languages.isNotEmpty &&
                            localizationController.selectedIndex != -1) {
                          localizationController.setLanguage(
                            Locale(
                              AppConstants
                                  .languages[
                                      localizationController.selectedIndex]
                                  .languageCode!,
                              AppConstants
                                  .languages[
                                      localizationController.selectedIndex]
                                  .countryCode,
                            ),
                          );
                          Get.back();
                        } else {
                          showCustomSnackBar('select_a_language'.tr,
                              isError: false);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]);
        },
      ),
    );
  }
}

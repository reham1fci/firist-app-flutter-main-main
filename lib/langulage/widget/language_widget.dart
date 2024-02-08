import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/language_controller.dart';
import '../../controllers/localization_controller.dart';
import '../../util/dimensions.dart';
import '../../util/styles.dart';
import '../../view/base/custom_ink_well.dart';


class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;
  const LanguageWidget({super.key, required this.languageModel, required this.localizationController, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200]!, blurRadius: 5, spreadRadius: 1)],
      ),
      child: CustomInkWell(
        onTap: (){
          localizationController.setLanguage(Locale(
            AppConstants.languages[index].languageCode!,
            AppConstants.languages[index].countryCode,
          ));
          localizationController.setSelectIndex(index);
        },
        radius: Dimensions.RADIUS_SMALL,
        child: Stack(children: [

          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(height: 65, width: 65,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  border: Border.all(color: Theme.of(context).textTheme.bodyLarge?.color??Colors.black, width: 1)),
                alignment: Alignment.center,
                child: Image.asset(languageModel.imageUrl!, width: 36, height: 36)),
              const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

              Text(languageModel.languageName!, style: fontSizeMedium.copyWith(color: Theme.of(context).primaryColor)),
            ]),
          ),

          localizationController.selectedIndex == index ?
          Positioned(top: 10, right: 10,
            child: Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 25),
          ) : const SizedBox(),

        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/dimensions.dart';
import '../../util/styles.dart';


class CustomFieldWithTitle extends StatelessWidget {
  final Widget customTextField;
  final String? title;
  final bool requiredField;
  final bool isPadding;
  final double? height;
  final bool isSKU;
  final bool limitSet;
  final String? setLimitTitle;
  final double? width;
  final Function()? onTap;
  const CustomFieldWithTitle(
      {Key? key,
      required this.customTextField,
      this.title,
      this.setLimitTitle,
      this.width,
      this.requiredField = false,
      this.isPadding = false,
      this.isSKU = false,
      this.limitSet = false,
      this.onTap,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: isPadding
            ? const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
            : const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: title,
                    style: fontSizeRegular.copyWith(
                        color: Theme.of(context).primaryColor),
                    children: <TextSpan>[
                      requiredField
                          ? TextSpan(
                              text: '  *',
                              style: fontSizeBold.copyWith(color: Colors.red))
                          : const TextSpan(),
                    ],
                  ),
                ),
                isSKU
                    ? InkWell(
                        onTap: onTap,
                        child: Text(
                            limitSet ? setLimitTitle! : 'auto_generate'.tr,
                            style: fontSizeRegular.copyWith(
                                color: Theme.of(context).secondaryHeaderColor)))
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            SizedBox(height: height, child: customTextField),
          ],
        ),
      ),
    );
  }
}

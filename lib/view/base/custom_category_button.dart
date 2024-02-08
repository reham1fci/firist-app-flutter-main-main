import 'package:betakety_app/view/base/color_resources.dart';
import 'package:betakety_app/view/base/gradient_color_helper.dart';
import 'package:flutter/material.dart';

import '../../util/dimensions.dart';
import '../../util/styles.dart';


class CustomCategoryButton extends StatelessWidget {
  final String icon;
  final String buttonText;
  final bool isSelected;
  final double padding;
  final bool isDrawer;
  final Function()? onTap;
  const CustomCategoryButton({
    Key? key,
    required this.icon,
    required this.buttonText,
    this.isSelected = false,
    this.padding = Dimensions.PADDING_SIZE_DEFAULT,
    this.isDrawer = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: isDrawer
            ? const EdgeInsets.all(0.0)
            : const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: isDrawer
                  ? BorderRadius.zero
                  : BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
              gradient: GradientColorHelper.gradientColor(),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: Column(children: [
                Image.asset(
                  icon,
                  width: 30,
                  color: isSelected
                      ? Theme.of(context).secondaryHeaderColor
                      : Colors.blue,
                ),
                Text(
                  buttonText,
                  style: fontSizeMedium.copyWith(
                    color: isSelected
                        ? Theme.of(context).secondaryHeaderColor
                        : ColorResources.containerShedow,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                ),
              ]),
            )),
      ),
    );
  }
}

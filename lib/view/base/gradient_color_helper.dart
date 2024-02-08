import 'package:betakety_app/view/base/color_resources.dart';
import 'package:flutter/material.dart';

class GradientColorHelper {
  static LinearGradient gradientColor({double? opacity}) {
    return LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.topLeft,
      colors: <Color>[
        opacity == null
            ? ColorResources.getSplashColor1()
            : ColorResources.getSplashColor1().withOpacity(opacity),
        opacity == null
            ? ColorResources.getSplashColor2()
            : ColorResources.getSplashColor2().withOpacity(opacity),
      ],
    );
  }
}

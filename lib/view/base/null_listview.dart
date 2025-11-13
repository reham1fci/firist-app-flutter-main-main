import 'package:betakety_app/util/resizer/fetch_pixels.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NullListview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return

       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*  getSvgImage("clipboard.svg",
            height: FetchPixels.getPixelHeight(124),
            width: FetchPixels.getPixelHeight(124)),*/
          getVerSpace(FetchPixels.getPixelHeight(40)),
          getCustomFont("no_data_found".tr, 20, Colors.black, 1,
              fontWeight: FontWeight.w800),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          /*  getCustomFont(
            "Go to services and book the best services. ", 16, Colors.black, 1,
            fontWeight: FontWeight.w400),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getButton(
            context, backGroundColor, "Go to Service", blueColor, () {}, 18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            insetsGeometry: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(106)),
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
            isBorder: true,
            borderColor: blueColor,
            borderWidth: 1.5)*/
        ],
      );
    }
  }


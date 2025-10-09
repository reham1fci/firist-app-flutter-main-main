import 'package:betakety_app/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import 'resizer/fetch_pixels.dart';

Widget getVerSpace(double verSpace) {
  return SizedBox(
    height: verSpace,
  );
}
Widget getCustomFont(String text, double fontSize, Color fontColor, int maxLine,
    {
      //String fontFamily = Constant.fontsFamily,
      TextOverflow overflow = TextOverflow.ellipsis,
      TextDecoration decoration = TextDecoration.none,
      FontWeight fontWeight = FontWeight.normal,
      TextAlign textAlign = TextAlign.start,
      txtHeight}) {
  return Text(
    text,
    overflow: overflow,
    style: TextStyle(
        decoration: decoration,
        fontSize: fontSize,
        fontStyle: FontStyle.normal,
        color: fontColor,
       // fontFamily: fontFamily,
        height: txtHeight,
        fontWeight: fontWeight),
    maxLines: maxLine,
    softWrap: true,
    textAlign: textAlign,
  );
}Widget getPaddingWidget(EdgeInsets edgeInsets, Widget widget) {
  return Padding(
    padding: edgeInsets,
    child: widget,
  );
}
  Widget getSearchWidget(
      BuildContext context,
      TextEditingController searchController,
      Function filterClick,
      ValueChanged<String> onChanged,
      {bool withPrefix = true,
        ValueChanged<String>? onSubmit}) {
    double height =50;

    final mqData = MediaQuery.of(context);
    final mqDataNew =
    mqData.copyWith(textScaleFactor: FetchPixels.getTextScale());

    return  Padding( padding: EdgeInsets.only(
       top: 8,
      right:8,
      left:8,),child:
        Container(
      width: double.infinity,
      height: height,
      alignment: Alignment.centerLeft,

      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
          ],
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                right:16,
                left:16,),
            child:const Icon(
              Icons.search,
              color: kTitleColor,
            ),
          ),
          Expanded(
            flex: 1,
                  child: TextField(
                    onSubmitted: onSubmit,
                    textInputAction: TextInputAction.search,
                    controller: searchController,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: '${"search".tr}...' ,
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          )),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                       ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),

          ),
     const SizedBox(
    width: 3,
    )        ],
      ),
    ));
  }

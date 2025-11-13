
import 'package:betakety_app/model/shipment.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/resizer/fetch_pixels.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/null_listview.dart';
import 'package:betakety_app/view/screens/shipments/widgets/option_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class UpdateOptionScreen extends StatelessWidget {

  List<OptionUpdates> optionList  =  []  ;


  UpdateOptionScreen(this.optionList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
          resizeToAvoidBottomInset: false,
         // backgroundColor: backGroundColor,
       appBar:    AppBar(
            iconTheme: const IconThemeData(color: kTitleColor),
            centerTitle: true,
            title: Text(
              'details'.tr,
              style: fontSizeMedium,
            ),
            actions: const [
              SizedBox(
                width: 5.0,
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 2.0,
          ),

          body:
          Column(
            children: [
              // هنا الشرط بتاعك
              Expanded(
                child: optionList.isEmpty
                    ? Center(child: NullListview())
                    : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(20)),
                  itemCount: optionList.length,
                  itemBuilder: (context, index) {
                    return OptionItemWidget(optionList[index]);
                  },
                ),
              )
            ],
          )

      );


  }}
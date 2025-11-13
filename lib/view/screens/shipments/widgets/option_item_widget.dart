
import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/model/shipment.dart';
import 'package:betakety_app/util/resizer/fetch_pixels.dart';
import 'package:betakety_app/view/screens/shipments/widgets/attachment_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OptionItemWidget  extends StatelessWidget {
  OptionUpdates optionItem  ;


  OptionItemWidget(this.optionItem);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  GetBuilder<ShipmentController>(builder: (shipmentController)
    {
      return
         Container(
          margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
          padding: EdgeInsets.symmetric(
              vertical: FetchPixels.getPixelHeight(16),
              horizontal: FetchPixels.getPixelWidth(16)),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              borderRadius:
              BorderRadius.circular(FetchPixels.getPixelHeight(12))),
          child: Column(
            children: [
          Text(optionItem.optionName!) ,
              optionItem.optionType=="text" || optionItem.optionType=="number" ?
          Text(optionItem.optionValue!)  :
              GestureDetector (
                  onTap: () {

         //  isDropdownVisible = false;
                    Get.to(() => AttahmentViewScreen(name: optionItem.optionName , url: optionItem.optionValue,)) ;

         },
                child: Padding(
              padding: const EdgeInsets.all(16.0),
             child:Row
               (
                mainAxisAlignment:   MainAxisAlignment.center ,

                children: [
               //  Text(optionItem.optionType!,style:  TextStyle(fontSize: 16 ,color: Colors.blue)),
                 Icon(Icons.image ,)
               ],
             )

         ),

              )
            ],
          ),

      );

    }
    );}}

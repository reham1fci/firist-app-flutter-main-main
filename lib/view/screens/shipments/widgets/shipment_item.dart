
import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/model/shipment.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/screens/shipments/widgets/shipment_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShipmentItem extends StatelessWidget {
  Shipment item  ;
   int index  ;
  bool select   ;


  ShipmentItem(this.item ,this.index  , {this.select= true  });

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ShipmentController>(builder: (shipmentController) {
      final isSelected = shipmentController.isSelected(index);

      return GestureDetector(
          onTap: select?() {
            shipmentController.toggleSelection(index, item);
          }:(){},
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              color: isSelected ? Colors.white38 : Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'shipment_num'.tr, // Shipment Number
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.requestId! ,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14
                              ),
                            ),
                            const SizedBox(height: 4),

                            Text(
                              '${'from'.tr } ${'city'.tr }' , // Shipment Number
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.fromCity!.isEmpty?'...':  item.fromCity!,
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14
                              ),
                            ),
                            const SizedBox(height: 4 ),
                            item.requestTypeKey != "clearance" &&  item.requestTypeKey != "dgr"?
                            Column(children: [
                              Text(
                                '${'to'.tr } ${'city'.tr }' , // Shipment Number
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.toCity!.isEmpty?'...':  item.toCity!,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14
                                ),
                              ),
                            ],):SizedBox() ,

                          ],
                        ),
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'policy'.tr, // Policy Number
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              item.policy!.isEmpty?'...':  item.policy!,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 14),
                            ),
                            SizedBox(height: 4),
                            item.requestTypeKey != "trans"?
                            Column(children: [
                              Text(
                                '${'from'.tr } ${'port'.tr }'  ,// Policy Number
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 2),
                              Container(
                                width: 150, // أو العرض اللي يناسبك
                                child:Center(child:  Text(
                                  item.fromPort!.isEmpty ? '...' : item.fromPort!,
                                  style: TextStyle(color: Colors.grey, fontSize: 14 ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),) ,
                              ),

                            ],):SizedBox(),
                            SizedBox(height: 4),
                            item.requestTypeKey != "clearance" &&  item.requestTypeKey != "dgr"&&  item.requestTypeKey != "trans"?
                            Column(children: [
                              Text(
                                '${'to'.tr } ${'port'.tr }'  ,// Policy Number
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                item.toPort!.isEmpty?'...':  item.toPort!,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ],) :SizedBox()

                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Divider(color: Colors.grey.shade300),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              '${'shipment_type'.tr} : ${item.requestType!} ',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${'shipment_state'.tr} : ${item.stateTxt ?? ""}' ,

                              // Shipment Type: Clearance
                              style: TextStyle(fontSize: 14),
                            ),

                            //    SizedBox(height: 8),
                            Text(
                              ' ${'shipment_date'.tr} : ${item.date}' ,
                              style: TextStyle(fontSize: 14,),
                            ),
                          ],
                        ) ,
                           CustomButton(
                            width: 70,
                            buttonText: "details".tr,
                            buttonColor: kMainColor,
                            onPressed: ()  {

                              Get.to(() => ShipmentDetails(shipmentItem: item,));

                            })


                      ],
                    )



                  ],
                ),
              ),
            ),
          ));
    });}
}
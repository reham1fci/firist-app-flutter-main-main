import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/view/screens/Requests/add_request.dart';
import 'package:betakety_app/view/screens/Requests/add_request_permission.dart';
import 'package:betakety_app/view/screens/Requests/add_vaction_request.dart';
import 'package:betakety_app/view/screens/Requests/asking_body.dart';
import 'package:betakety_app/view/screens/Requests/vaction_request_body.dart';
import 'package:betakety_app/view/screens/shipments/widgets/all_body.dart';
import 'package:betakety_app/view/screens/shipments/widgets/delivered_body.dart';
import 'package:betakety_app/view/screens/shipments/widgets/pending_body.dart';
import 'package:betakety_app/view/screens/shipments/widgets/received_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../controllers/permission_controller.dart';
import '../../../util/constant.dart';
import '../../../util/styles.dart';

class ShipmentsScreen extends StatefulWidget {
   String type  ;
   ShipmentsScreen({Key? key , required this.type }) : super(key: key);

  @override
  ShipmentsScreenState createState() => ShipmentsScreenState();
}

class ShipmentsScreenState extends State<ShipmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        // backgroundColor: kFirstColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kTitleColor),
          centerTitle: true,
          title: Text(
            widget.type==AppConstants.showShipments ?   'customs_broker_shipments'.tr : 'driver_shipments'.tr ,
            style: fontSizeMedium,
          ),
          actions: const [
            SizedBox(
              width: 5.0,
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 2.0,
          bottom: TabBar(


            onTap: (value) {
              Get.find<PermissionController>().changeSelected(value);
            },
            labelColor: kTitleColor,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                //icon: Icon(Icons.cloud_outlined),
                text: 'pending'.tr,
              ),
              Tab(
                //icon: Icon(Icons.brightness_5_sharp),
                text: 'received2'.tr,
              ),  Tab(
                //icon: Icon(Icons.brightness_5_sharp),
                text: widget.type==AppConstants.showShipments ?'finished'.tr : 'delivered2'.tr,
              ) ,Tab(
                //icon: Icon(Icons.brightness_5_sharp),
                text: 'all'.tr,
              ),

            ],

          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10.0),
            // const SizedBox(height: 10.0),
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 8),
            //   decoration: BoxDecoration(
            //     color: const Color(0xFFF7F5F2),
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(
            //       color: Theme.of(context).primaryColor,
            //       width: 2,
            //     ),
            //   ),
            //   child: AppTextField(
            //     textFieldType: TextFieldType.NAME,
            //     decoration: const InputDecoration(
            //       suffixIcon: Icon(
            //         Icons.search,
            //         color: kTitleColor,
            //       ),
            //       border: InputBorder.none,
            //       fillColor: Color(0xFFF7F5F2),
            //       contentPadding: EdgeInsets.all(10.0),
            //       hintText: 'Search',
            //     ),
            //   ),
            // ),
            Expanded(
              child: TabBarView(
                children: [
                  // Center(
                  //   child: Text("It's cloudy here"),
                  // ),
                  PendingBody(selectIndex: 0 , type: widget.type, ),
                  ReceivedBody(selectIndex: 1  , type: widget.type,),
                  DeliveredBody(selectIndex: 2  ,type: widget.type, ),
                  AllShipmentBody(selectIndex: 3 ,  type: widget.type, ),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //     child: const Icon(
        //       Icons.add,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       //   Get.to(AddRequestPermission());
        //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddRequest()));
        //     }
        // ),
      ),
    );
  }
}

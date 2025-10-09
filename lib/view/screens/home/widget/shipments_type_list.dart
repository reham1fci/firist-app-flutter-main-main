import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/view/screens/Requests/all_requests.dart';
import 'package:betakety_app/view/screens/Requests/widget/requests_type_item.dart';
import 'package:betakety_app/view/screens/shipments/shipments_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/styles.dart';
import 'package:betakety_app/util/app_constants.dart' ;

//import 'Navigation Bar/navigation_list.dart';

class ShipmentsTypeList extends StatefulWidget {
  const ShipmentsTypeList({Key? key}) : super(key: key);

  @override
  ShipmentsTypeListState createState() => ShipmentsTypeListState();
}

class ShipmentsTypeListState extends State<ShipmentsTypeList> {
   String? employeeType ;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
getUserData() ;
   }
    getUserData() async {
      LoginResponsModel user = await AuthController().getLoginData();
      setState(() {
        employeeType  = user.employeeType  ;

      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
    iconTheme: const IconThemeData(color: kTitleColor),
    centerTitle: true,
    title: Text(
    'shipments'.tr,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: Get.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  color: Colors.white),
              child:
              employeeType!=null?

              Column(
                children: [
                  const SizedBox(height: 20.0),
                  ( employeeType=="Customs_Broker" || employeeType  == "view_all_shipping") ?
                  RequestsTypeItem(title:
                  'customs_broker_shipments'.tr,

                    onTap: (){
                      Get.to(() => ShipmentsScreen(type:AppConstants.showShipments ,));

                    },):SizedBox(),
                  ( employeeType=="Driver" || employeeType  == "view_all_shipping") ?

                     RequestsTypeItem(title:
                      'driver_shipments'.tr,

                        onTap: (){
                          Get.to(() => ShipmentsScreen(type:AppConstants.showShipmentsDriver ,));
                        },):SizedBox() ,



                ],
              ):SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

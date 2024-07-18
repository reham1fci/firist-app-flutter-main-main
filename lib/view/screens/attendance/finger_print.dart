
import 'dart:async';

import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/base/loading_dialog.dart';
import 'package:betakety_app/view/screens/attendance/attendance_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mac_address/mac_address.dart';

class FingerPrint extends StatefulWidget {

  @override
  _FingerPrintState createState() => _FingerPrintState();
}

class _FingerPrintState extends State<FingerPrint> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(FingerPrintController());


  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FingerPrintController>(builder: (co)
    {
      return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AttendanceDetails(),
              ),
            );
          },
           child: Text('details'.tr),
          ),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kTitleColor),
            centerTitle: true,
            title: Text(
              'attendance_and_withdrawal'.tr,
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

          !co.isAuthenticated  || co.loginB4?

          Column(children: [
Padding(padding: const EdgeInsets.all(10) , child:
          Container(
            width: double.infinity,
           // height:130 ,
            padding: const EdgeInsets.only(top: 20),
            child:
            co.currentLocation==null?
            Center( child: Column(
              children: [
            const    CircularProgressIndicator(),
                Container(margin: const EdgeInsets.only(left: 7),child:Text('loading_info'.tr ,
                  style: TextStyle(color: Colors.red), ) ,),
              ],))
                :
            Padding(padding: const EdgeInsets.all(10)   ,child:    Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
//Padding(padding: EdgeInsets.all(10) ,child:

    Container(
        decoration: BoxDecoration(
          color: Colors.green,

          // shape: BoxShape.rectangle, // You can also use BoxShape.circle directly
          borderRadius: BorderRadius.circular(10.0), // Half of the container's size
        ),
        width: MediaQuery.of(context).size.width/2.5,
              child:  TextButton(

              onPressed:
              () {
                showOkDialog(context: context,
                    message: 'login_confirmation'.tr,
                    isCancelBtn: true,
                    onOkClick: () {
                      setState(() {
                        co.registerFingerPrintFunction =
                            AppConstants.loginFingerPrint;
                        co.validateFieldsAndShowSnackbar();
                      });
                    });
              }
                  ,

              child:
              Center(child:    Column(children: [
                  const   Padding (padding:EdgeInsets.only( bottom: 8) ,child:  Icon(Icons.fingerprint ,size: 30 ,color: Colors.white),) ,
                    Text('login_finger_print'.tr ,style:const TextStyle(color: Colors.white),)


                  ],))

            )
            )
    ,
          Container(
              decoration: BoxDecoration(
                color: Colors.red,

                // shape: BoxShape.rectangle, // You can also use BoxShape.circle directly
                borderRadius: BorderRadius.circular(10.0), // Half of the container's size
              ),
              width: MediaQuery.of(context).size.width/2.5,
              child:  TextButton(

                  onPressed:
                  (){

                  showOkDialog(context: context, message: 'logout_confirmation'.tr, isCancelBtn: true  , onOkClick: (){
                    setState(() {
                      co.registerFingerPrintFunction =AppConstants.logoutFingerPrint ;
                      co.validateFieldsAndShowSnackbar() ;
                    });
                  }) ;},
                  child:
                  Center(child:    Column(children: [
                  const  Padding (padding:EdgeInsets.only( bottom: 8) ,child:  Icon(Icons.fingerprint ,size: 30 ,color: Colors.white),) ,
                    Text('logout_finger_print'.tr ,style:const TextStyle(color: Colors.white),)


                  ],))

              )
          )

    ] )
      )
          ))
         ,
  co.companyLocation!=null?
     Expanded(
          child:
  GoogleMap(

    mapType: MapType.normal,
    initialCameraPosition: co.companyLocation!,
    markers: Set<Marker>.of(co.markers.values), // YOUR MARKS IN MAP

    onMapCreated: (GoogleMapController controller) {
      _controller.complete(controller);
    },
  )):const CircularProgressIndicator(),

         ] ):
       Image.asset(
            Images.successIcon,
            height: double.infinity,
            width: double.infinity,
          )

      );
    });
  }}


/*enum _SupportState {
  unknown,
  supported,
  unsupported,
}*/
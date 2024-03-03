
import 'dart:async';

import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/images.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mac_address/mac_address.dart';
import 'package:flutter_udid/flutter_udid.dart';

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
Column(children: [
          !co.isAuthenticated ?
          Container(
            width: double.infinity,
            height:250 ,
            padding: EdgeInsets.only(top: 20),
            child:Center(child: TextButton(

              onPressed: co.validateFieldsAndShowSnackbar,
              child:
                  Column(children: [
                    const Center (child:  Icon(Icons.fingerprint ,size: 100),) ,
                    Text("login finger print")


                  ],)

            ),) ):
          Image.asset(
            Images.successIcon,
            height: double.infinity,
            width: double.infinity,
          ),
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

         ] )
      );
    });
  }}


/*enum _SupportState {
  unknown,
  supported,
  unsupported,
}*/
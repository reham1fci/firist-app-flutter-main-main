import 'dart:async';
import 'dart:convert';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/base/fingerprint_alert.dart';
import 'package:betakety_app/view/base/password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as toolkit;
//import 'package:platform_device_id/platform_device_id.dart';

class FingerPrintController extends GetxController {
   LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  String registerFingerPrintFunction  =  "" ;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool isAuthenticating = false;
  bool isAuthenticated = false;
  Api api  = Api() ;
  bool inCompany = false;
  var currentLocation  ;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   StreamSubscription<ServiceStatus> serviceStatusStream = Geolocator.getServiceStatusStream().listen(
            (ServiceStatus status) {
          print(status);
          if(status  ==ServiceStatus.enabled ) {
            _checkUserLocation() ;
          }
        });
    auth.isDeviceSupported().then(
          (bool isSupported) {
            _supportState = isSupported
                ? _SupportState.supported
                : _SupportState.unsupported ;

            update() ;
          }
    );
    _initData() ;
  }
 bool loginB4   = true  ;

   Future<dynamic> registerFingerPrint() async {
     LoginResponsModel user =  await AuthController().getLoginData()  ;
     DateTime currentDate = DateTime.now();
String date = DateFormat('yyyy-MM-dd').format(currentDate);
String time = DateFormat('HH:mm:ss').format(currentDate);
     String url  =  "${registerFingerPrintFunction}?employ_id=${user.id!}&hodor_ensraf_date=${date}&hodor_time=${time}&company_id=${user.companyId!}"   ;
     //String url  =  "/Employ_Salary_api.php?employ_id=662918&date_from=2024-01-01&date_to=2024-01-31&employ_type=office";
     print(url) ;

     var response  = await  api.getData(url: url)  ;

     if (response.statusCode == 200) {

       print(jsonDecode(response.body));
       var data = jsonDecode(response.body) ;

       if(data["success"]){
       print(data["msg"]) ;
       String msg  = data["msg"]  ;
       print(msg) ;
       if(msg  == "تمت الإضافه مسبقا"){
         loginB4  = true  ;
         update()  ;
         showOkDialog(context: Get.context!    ,message: msg, isCancelBtn: false  ) ;
       }
       else{
         loginB4  = false  ;
          update() ;
         Future.delayed(Duration(seconds: 3)).then((_) {
           Navigator.of(Get.context!).pop();
           // Anything else you want
         });
       }
       }
        else{
         showOkDialog(context: Get.context!    ,message: "'Failed to load data!'", isCancelBtn: false  ) ;

       }

     /*  */


     }
     else {
       showOkDialog(context: Get.context!    ,message: "'Failed to load data!'", isCancelBtn: false  ) ;

       throw Exception('Failed to load data!');
     }

   }
   Future<void> _authenticateWithBiometrics() async {
     bool authenticated = false;
     try {
         isAuthenticating = true;
         _authorized = 'Authenticating';
         update() ;
       authenticated = await auth.authenticate(
         localizedReason:
         'Scan your fingerprint (or face or whatever) to authenticate',
         options: const AuthenticationOptions(
           stickyAuth: true,
           biometricOnly: true,
         ),
       );
         isAuthenticating = false;
         _authorized = 'Authenticating';
         update();
     } on PlatformException catch (e) {
       print(e);
         isAuthenticating = false;
         _authorized = 'Error - ${e.message}';
       update();
       return;
     }
  /*   if (!mounted) {
       return;
     }*/

     final String message = authenticated ? 'Authorized' : 'Not Authorized';
       isAuthenticated  = authenticated  ;
       _authorized = message;
       if(isAuthenticated) {
         registerFingerPrint() ;
       }
        else{
         showPasswordDialog(Get.context!, (String password) {
            if(password == user!.passwordFingerprint) {
              isAuthenticated  = true  ;
              _authorized = "Authorized";
              registerFingerPrint() ;

            }
            else{
              showCustomSnackBar('PASSWORD_DID_NOT_MATCH'.tr);
            }
           // Handle the password entered by the user
           print('Password entered: $password');
           // You can add authentication logic here
         });
          // make password
       }
     update()
     ;}
   Future<void> validateFieldsAndShowSnackbar() async {
    if(!inCompany){
       showCustomSnackBar("${'out_company'.tr} ${"log".tr}");

     }
     else if(mobileMac != user!.mobileMac ){
       showCustomSnackBar("${'mac_mobile'.tr} ${"log".tr}");

     }
     else{
      _authenticateWithBiometrics() ;
      // webFingerprintCheck() ;
     }
   }
   webFingerprintCheck(){
  showFingerPrintDialog(context: Get.context! ,onOkClick: (){
    Navigator.of(Get.context!).pop();
    isAuthenticated = true  ;
     registerFingerPrint() ;
      update() ;


  }) ;

   }
   void _checkUserLocation() async {
     bool serviceEnabled;
     LocationPermission permission;


     // Test if location services are enabled.
     serviceEnabled = await Geolocator.isLocationServiceEnabled();
     if (!serviceEnabled) {
       // Location services are not enabled don't continue
       // accessing the position and request users of the
       // App to enable the location services.
       showCustomSnackBar('you_have_to_allow'.tr);
       return Future.error('Location services are disabled.');
     }

     permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.denied) {
         // Permissions are denied, next time you could try
         // requesting permissions again (this is also where
         // Android's shouldShowRequestPermissionRationale
         // returned true. According to Android guidelines
         // your App should show an explanatory UI now.

         return Future.error('Location permissions are denied');
       }
     }

     if (permission == LocationPermission.deniedForever) {
       // Permissions are denied forever, handle appropriately.
       return Future.error(
           'Location permissions are permanently denied, we cannot request permissions.');
     }
     Position position = await Geolocator .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     print(position);
      currentLocation = toolkit.LatLng(position.latitude, position.longitude);
     final companyLocation = toolkit.LatLng(double.parse(user!.companyLat!), double.parse(user!.companyLng!));
    final testLocation = toolkit.LatLng(29.8765411,31.2921507 );
     final MarkerId markerId = MarkerId("user");

     Marker marker2 = Marker(
       markerId: markerId,
       position:LatLng(position.latitude, position.longitude),
       infoWindow: InfoWindow(title: "my location", snippet: '*'),
     );
     markers[markerId] = marker2;

     final distance =
     toolkit.SphericalUtil.computeDistanceBetween(currentLocation, testLocation) ;

     if(distance<200){
         inCompany  = true ;
         update();

     }
     else{
         inCompany =false  ;
       //  showCustomSnackBar("${'out_company'.tr} ${distance}");

        // showCustomSnackBar('out_company'.tr);

       update() ;
     }
     print('Distance between London and Paris is $distance km.');

   }
   LoginResponsModel?   user ;
   String?   mobileMac ;
   CameraPosition? companyLocation ;
   Map<MarkerId, Marker> markers = <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

   _initData() async {
     user = await AuthController().getLoginData()  ;
     mobileMac = await FlutterUdid.udid;
     // mobileMac = await PlatformDeviceId.getDeviceId;

     companyLocation = CameraPosition(
       target: LatLng(double.parse(user!.companyLat!), double.parse(user!.companyLng!)),
       zoom: 14.4746,
     );
     final MarkerId markerId = MarkerId("company");

     Marker marker = Marker(
       markerId: markerId,
       position:LatLng(double.parse(user!.companyLat!), double.parse(user!.companyLng!)),
       infoWindow: InfoWindow(title: "company location", snippet: '*'),
     );
     markers[markerId] = marker;

     print(mobileMac) ;
     _checkUserLocation() ;

   }




}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}
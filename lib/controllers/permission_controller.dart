// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';
import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/model/File.dart';
import 'package:betakety_app/model/Questions.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/pending_check.dart';
import 'package:betakety_app/model/request_options.dart';
import 'package:betakety_app/model/vacation.dart';
import 'package:betakety_app/model/vacation_type.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:betakety_app/view/screens/Requests/all_requests.dart';
import 'package:betakety_app/view/screens/Requests/deduction_requests.dart';
import 'package:betakety_app/view/screens/Requests/main_permissions.dart';
import 'package:betakety_app/view/screens/Requests/vacation_request.dart';
import 'package:betakety_app/view/screens/Requests/widget/pendingPopup.dart';
import 'package:betakety_app/view/screens/Requests/widget/vaction_popup.dart';
import 'package:betakety_app/view/screens/shipments/trips_screens.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:betakety_app/view/base/file_name_dialog.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import '../view/base/custom_snackbar.dart';
import '../model/requests_permissions_model.dart';

class PermissionController extends GetxController {
  // PermissionRepo permissionRepo;

  // PermissionController({
  //   required this.permissionRepo,
  // });
  TextEditingController fileName = TextEditingController();
  bool canApplyVacation = true;
  bool isLoading = false;
  var loadingMap = <String, bool>{}.obs;
  setLoading(String id, bool value) {
    loadingMap[id] = value;
    update();
  }
  int _selectedIndex = 0;
  Api api = Api()  ;
  int get selectedIndex => _selectedIndex;
  List<String> selectedIds =  [] ;
  changeSelected(int x) {
    _selectedIndex = x;
    update();
  }
  List<VacationType> selectedItems = [];

  List<RequestTypeModel> requestTypeList = [
    RequestTypeModel(name: "Late", id: 1),
    RequestTypeModel(name: "leave_before", id: 2),
  ];

  List<PermissionTypeModel> permissionTypeList = [
    PermissionTypeModel(name: "business_trip", id: 1),
    PermissionTypeModel(name: "emergency", id: 2),
  ];
  List<RequestTypeModel> vacationPlaceList = [
    RequestTypeModel(name: "inside", id: 1),
    RequestTypeModel(name: "outside", id: 2),
    RequestTypeModel(name: "financial_settlement", id: 3),
  ];
  List<VacationType>? vacationTypeList;
  List<VacationType>? apiList;

  RequestTypeModel? requestTypeTemp;
  PermissionTypeModel? permissionTypeTemp;
  RequestTypeModel? vacationPlaceTemp;
  VacationType? vacationTypeTemp;
  VacationType? apiItemTemp;
   String monthTemp = "1" ;
  int? selectedYear =  2025;
  List<dynamic> levelOptions = [];

  TextEditingController detailsController = TextEditingController();
  TextEditingController vacationPlaceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController departureDateController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  TextEditingController timeFromController = TextEditingController();
  TextEditingController timeToController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();
  TextEditingController justificationController = TextEditingController();
  FilePickerResult? addedFile;
  var stream ;
  var length ;
  List<SendFile> filesList  = [] ;
  List<String> attachmentsPathsList  = [] ;
  List<String> filesNames = [];

  resetData() {
    canApplyVacation  = true  ;
     selectedIds  .clear()  ;
    selectedItems.clear()  ;
  detailsController.clear();
  dateController.clear();
  minutesController.clear();
  timeFromController.clear();
  dateFromController.clear();
  dateToController.clear();
  justificationController.clear();
 timeToController.clear();
 departureDateController.clear();
 vacationPlaceController.clear();
 returnDateController.clear();
     apiItemTemp = null ;
 requestTypeTemp = requestTypeList[0];
 permissionTypeTemp = permissionTypeList[0];
 vacationPlaceTemp = vacationPlaceList[0];
 vacationTypeTemp = VacationType(nameEn: "Extended sick leave 16", Id: "279916");
  addedFile = null;
   fileNameController.clear();
   fileName.clear();
   filesList.clear()  ;
   levelOptions.clear()  ;
   filesNames.clear()  ;
   attachmentsPathsList.clear()  ;
  }
  String? filePath  ;
  RequestsPermissionsModel ? permissionsModel  ;
  Position? currentLocation  ;

  Future<Position> getCurrentLocation() async {
    Get.put(FingerPrintController() );
    Get.find<FingerPrintController>().checkPermission();
    currentLocation = await Geolocator .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(currentLocation);
    return currentLocation! ;

  }
   selectFile() async {
    int selectFiles = 3;
   FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      allowMultiple: true,
  allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'docx'],
   );

   if (result != null) {
    if (result.files.length <= selectFiles) {
     String fileNames = result.files.map((file) => file.path).join();
       fileNameController.text = fileNames;
    } else {
      showCustomSnackBar("${"files_allowed".tr} $selectFiles ${"files".tr}");
      }
    }
  }
 var fileBytes  ;
//   selectSingleFile(TextEditingController  controller  , String key ) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
// if(key.isEmpty){
//   key = controller.text  ;
// }
//     if (result != null) {
//       if(kIsWeb){
//       fileBytes = result.files.single.bytes;
// print(fileBytes);
//       controller.text = result.files.single.name;
//
//       }
//       else{
//          File file = File(result.files.single.path!);
//
//         stream =  http.ByteStream(file.openRead())..cast();
//         // get file length
//          length = await file.length();
//          controller.text = result.files.single.path!;
//       }
//
//
//     } else {
//       // User canceled the picker
//     }
//      filesList.add(SendFile(key: key, stream: stream, length: length)) ;
//   }

  checkLocation ({ required Function onSuccess})async {
isLoading =true ;
      update()  ;
      LoginResponsModel user =  await AuthController().getLoginData()  ;
      String url  =  "${AppConstants.checkUserLocation}?employ_id=${user.id!}";
      final Map<String, dynamic> data = <String, dynamic>{};
      data['employ_id'] = user.id;
      data['user_lat'] = currentLocation!.latitude.toString();
      data['user_lng'] = currentLocation!.longitude.toString();
      data['company_id'] = user.companyId;
      print(url) ;

      final response = await api.postData(uri:url, map: data) ;

      if (response.statusCode == 200) {

        print(jsonDecode(response.body));
        var data = jsonDecode(response.body) ;
        print(data["status"]);

        if(data["status"]=="success"){
          bool isInside = data["is_inside"] ;
         bool allowAnywhere = data["allow_anywhere"] ;
          isLoading = false;

          update() ;
          if(isInside|| allowAnywhere){
            onSuccess() ;
           /* Navigator.of(Get.context!).pop();
            Navigator.push(Get.context!, MaterialPageRoute(
                builder: (BuildContext context) => VacationRequest()));*/

          }
           else{
            SharedPreferences sharedPreferences = Get.find();
            String languageCode = sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'ar';
             String messageEn = data["message_en"] ;
             String messageAr = data["message"] ;
             showOkDialog(context: Get.context!, message: languageCode == 'ar' ? messageAr : messageEn, isCancelBtn: false , onOkClick: (){
               Navigator.of(Get.context!).pop();
             }) ;
          }
        //  loader = false;

          //  return  data["data"] ;
          return   ;
        }
        else{
          isLoading = false;

          update() ;
          throw Exception('Failed to load data!');

        }

      }
      else {
        isLoading = false;
        update() ;
        throw Exception('Failed to load data!');
      }

    }



   Future<String?> selectSingleFile(TextEditingController controller, String key ,) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (key.isEmpty) {
      key = controller.text;
    }

    if (result != null) {
      // Mobile
      File file = File(result.files.single.path!);

       stream = http.ByteStream(file.openRead())..cast();
       length = await file.length();

      controller.text = result.files.single.path!.split('/').last;
     // fileNameController.text = result.files.single.path!;

      filesList.add(SendFile(
        key: key,
        stream: stream,
        length: length,
        fileName:  result.files.single.path!.split('/').last, // يجيب الاسم بس من غير الباث
      ));
      update() ;

      return result.files.single.path ;
    } else {
      // User canceled the picker
    }
  }
  removeFiles({  required int index , bool name = false   , bool list = false}){
     filesList.removeAt(index) ;
   if(list) attachmentsPathsList.removeAt(index)  ;
   if(name)  filesNames.removeAt(index) ;
     update() ;
   }
  Future<String?> pickImageFromCamera(TextEditingController controller ,String key  ,{ bool nameDialog  =  true }) async {

    // فتح الكاميرا لالتقاط صورة
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    stream = http.ByteStream(image!.openRead())..cast();
    length = await image.length();
    if (image != null) {
      if(nameDialog){

      FileNameDialog(
        context: Get.context!,
        isCancelBtn: true,
        controller: controller,

        onOkClick: () {
          String fileNameText = controller.text.trim();

          filesNames.add(fileNameText.isEmpty
              ? image.name
              : fileNameText);

        //  identityImages.add(image);
       //   multipartList.add(MultipartBody('files[]', image));


          attachmentsPathsList.add(image.path) ;
          update();
        },
      ); }
      else{
        controller.text = image.name;
      }
      filesList.add(SendFile(
        key: key,
        stream: stream,
        length: length,
        fileName: image.name, // يجيب الاسم بس من غير الباث
      ));
      return image.path;

    } else {
      // المستخدم لغى التصوير
      print("No image captured");
    }
  }
/////// select file name with name
  Future<String?> selectSingleFileWithName(TextEditingController controller, String key ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    fileName.text = "";

    if (key.isEmpty) {
      key = controller.text;
    }

    if (result != null) {
      // Mobile
      File file = File(result.files.single.path!);

      stream = http.ByteStream(file.openRead())..cast();
      length = await file.length();

      //controller.text = result.files.single.path!.split('/').last;
      // fileNameController.text = result.files.single.path!;
      FileNameDialog(
          context: Get.context!,
          isCancelBtn: true,
          controller: controller,
          onOkClick: () {
            String name = controller .text.trim() ;
             print("file_name") ;
             print(name) ;
            // identityImage.name  = fileNameText  ;
            // imagesList.add(ImageData(file: identityImage, fileName: fileNameText));
            filesNames.add(name);
           // identityImages.add(identityImage);
           // multipartList.add(MultipartBody('files[]', identityImage));
            update();
          });
      filesList.add(SendFile(
        key: key,
        stream: stream,
        length: length,
        fileName:  result.files.single.path!.split('/').last, // يجيب الاسم بس من غير الباث
      ));
      attachmentsPathsList.add(result.files.single.path!) ;
      update() ;

      return result.files.single.path ;
    }
    else {
      // User canceled the picker
    }
  }
  bool _isGetRequestsPermissions = false;
  bool get isGetRequestsPermissions => _isGetRequestsPermissions;

  bool _isGetRequestsPermissionsError = false;
  bool get isGetRequestsPermissionsError => _isGetRequestsPermissionsError;

  final List<RequestsPermissionsModel> _requestsPermissionsList = [
    RequestsPermissionsModel(
      success: true,
      requestId: '113165',
      requestPerType: 'Type 1',
      requestType: 'Type A',
      requestPerDetails:
          'ذهب الى المستشفى بسبب اني كنت تعبان ولم استطيع مواصلة العمل بسبب المرضDetails 1',
      requestPerDate: '2023-10-23',
      requestPerTimeFrom: '10:00 AM',
      requestPerTimeTo: '12:00 PM',
      requestPerStat: 'Pending',
      updateDateTime: '2023-10-22 15:30:00',
      updateUserId: 'user123',
      theReason: 'Reason 1',
      addUserId: 'user456',
      createdDateTime: '2023-10-21 09:45:00',
      attatchement: [
        AttatchementModel(
          attachLink: 'https://example.com/attachment1',
          attachId: 'attachment1',
          attName: 'Attachment 1',
        ),
        AttatchementModel(
          attachLink: 'https://example.com/attachment2',
          attachId: 'attachment2',
          attName: 'Attachment 2',
        ),
      ],
    ),
    RequestsPermissionsModel(
      success: false,
      requestId: '223165',
      requestPerType: 'ضرف طارئ',
      requestType: 'إنصراف قبل إنتهاء الدوام',
      requestPerDetails:
          'كان لدي ضرف طارئ ولم استطع مواصلة العمل لاني ذهبت الى المطار وهذا مثال للفاصيل من اجل العرض',
      requestPerDate: '2023-10-24',
      requestPerTimeFrom: '2:00 PM',
      requestPerTimeTo: '4:00 PM',
      requestPerStat: '0',
      updateDateTime: '2023-10-23 11:15:00',
      updateUserId: 'user789',
      theReason: 'Reason 2',
      addUserId: 'user012',
      createdDateTime: '2023-10-23 08:30:00',
      attatchement: [
        AttatchementModel(
          attachLink: 'https://example.com/attachment3',
          attachId: 'attachment3',
          attName: 'Attachment 3',
        ),
      ],
    ),
  ];

  int get waitingLength => _requestsPermissionsList
      .where((request) => request.requestPerStat == "0")
      .length;

  List<RequestsPermissionsModel> get waitingList => _requestsPermissionsList
      .where((request) => request.requestPerStat == "0")
      .toList();
  List<RequestsPermissionsModel> get donePorcceningList =>
      _requestsPermissionsList
          .where((request) => request.requestPerStat != "0")
          .toList();

  int get donePorcceningWaitingLength => _requestsPermissionsList
      .where((request) => request.requestPerStat != "0")
      .length;
  void getRequestsPermissions({bool notfiy = true}) async {
    _isGetRequestsPermissions = true;
    _isGetRequestsPermissionsError = false;

    if (notfiy) {
      update();
    }

    // Response res = await permissionRepo.getRequestsPermissions(
    //     Get.find<AuthController>().getUserData()?.id ?? "1");
    // if (res.statusCode == 200 && res.body['success'] == true) {
    //   _requestsPermissionsList = (res.body['data'] as List)
    //       .map((e) => RequestsPermissionsModel.fromJson(e))
    //       .toList();
    // } else {
    //   _isGetRequestsPermissionsError = true;
    // }
    // _isGetRequestsPermissions = false;
    // update();
  }

  Future<void> validateFieldsAndShowSnackbar() async {
    if (detailsController.text.isEmpty) {
      showCustomSnackBar("${'details'.tr} ${"is_required".tr}");
    } else if (dateController.text.isEmpty) {
      showCustomSnackBar("${'date'.tr} ${"is_required".tr}");
    } else if (timeFromController.text.isEmpty) {
      showCustomSnackBar("${'from_time'.tr} ${"is_required".tr}");
    } else if (timeToController.text.isEmpty) {
      showCustomSnackBar("${'to_time'.tr} ${"is_required".tr}");
    } else {
postDataWithFile(uri: AppConstants.addPermissionReq) ;
    }
  } Future<void> validateVacationAndShowSnackbar() async {
    if (detailsController.text.isEmpty) {
      showCustomSnackBar("${'details'.tr} ${"is_required".tr}");
    } else if (vacationPlaceController.text.isEmpty) {
      showCustomSnackBar("${'vacation_place'.tr} ${"is_required".tr}");
    }else if (dateFromController.text.isEmpty) {
      showCustomSnackBar("${'date_from'.tr} ${"is_required".tr}");
    } else if (dateToController.text.isEmpty) {
      showCustomSnackBar("${'date_to'.tr} ${"is_required".tr}");}
    else if (vacationPlaceTemp!.id ==2 && departureDateController.text.isEmpty) {
      showCustomSnackBar("${'departure_date'.tr} ${"is_required".tr}");
    }
    else if (vacationPlaceTemp!.id ==2 && returnDateController.text.isEmpty) {
      showCustomSnackBar("${'return_date'.tr} ${"is_required".tr}");
    }
   else {
insertVacationRequest(uri: AppConstants.insertVacation) ;
    }
  } Future<void> validateRequestsAndShowSnackbar(  List<dynamic>? options ) async {
    for (int i  = 0 ; i < options!.length ; i ++) {
       TextEditingController  controller  = options[i]["controller"] ;
       String   req  = options[i]["required_type"] ;
      if(controller.text.isEmpty &&req =="required") {
        showCustomSnackBar("${options[i]["option_name_ar"]} ${"is_required".tr}");
return ;
      }
    }
    if (detailsController.text.isEmpty) {
      showCustomSnackBar("${'details'.tr} ${"is_required".tr}");
    }


   else {
insertRequest(uri: AppConstants.AddAllRequests) ;
    }
  }

  Future<dynamic> getRequests(String functionName) async {
    // data['the_reason'] = theReason
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    data["employ_id"] =user.id;
 String url  =  functionName+"?"+"employ_id=" +user.id!   ;
// String url  =  functionName+"?"+"employ_id=" +"568714"!   ;
 print(url) ;
 try {
    var response  = await  api.getData(url: url)  ;
      if (response.statusCode == 200) {
        print("requests");
        print(jsonDecode(response.body));

        return jsonDecode(response.body);

      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }
  Future<dynamic> getQuestionRequest(String functionName) async {
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    String url  =  functionName+"?"+"employ_id=" +user.id!   ;
    print(url) ;
    try {
      var response  = await  api.getData(url: url)  ;
      if (response.statusCode == 200) {
        print("requests");
        var jsonObj  =  jsonDecode(response.body)  ;
        print(jsonObj);
        var jsonArr  =  jsonObj["data"] as List ;
       List <Questions> questionsList = jsonArr.map((e) => Questions.fromJson(e ,)).toList();
        return questionsList;

      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }
  Future<dynamic> getTypes( String functionName) async {
    vacationTypeList  = []  ;
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    data["company_id"] =user.companyId;

 String url  =  functionName+"?company_id=" +user.companyId!   ;
 if(functionName == AppConstants.empData || functionName == AppConstants.showMandatoryData){
   url  =  functionName+"?company_id=" +user.companyId! +"&id=" +user.id! ;
 }
 print(url) ;
 try {
    var response  = await  api.getData(url: url)  ;

      if (response.statusCode == 200) {
        print("vacations");
        print(jsonDecode(response.body));
        var jsonObj  =  jsonDecode(response.body)  ;
        var jsonArr  =  jsonObj["data"] as List ;
        print(jsonArr) ;
         if(functionName == AppConstants.vacationTypes){
          vacationTypeList!.add(VacationType(nameAr:"اختر نوع  الاجازة"  , Id: "000" , nameEn:"choose vacation type" )) ;
        }
        for(int i  =0  ; i< jsonArr.length ; i++  ){
           if (functionName  == AppConstants.vacationTypes){
          VacationType v  =  VacationType.fromJson(jsonArr[i]) ;
          print(v.nameAr)  ;
           vacationTypeList!.add(v);
           }
            else{
             VacationType v  =  VacationType.fromJsonRequests(jsonArr[i]) ;
             print(v.nameAr)  ;
             for( int i  =  0  ;  i  <v.options!.length ; i ++){
               v.options![i]["controller"] = TextEditingController();
             }
             vacationTypeList!.add(v);


           }

        }

        vacationTypeTemp =vacationTypeList![0];
        update();
        return jsonDecode(response.body);

      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }Future<dynamic> getHoursStatistic( ) async {
    LoginResponsModel user =  await AuthController().getLoginData()  ;
 String url  =  "${AppConstants.hoursCount}?id=${user.id!}"   ;
 print(url) ;
 try {
    var response  = await  api.getData(url: url)  ;

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        var jsonObj  =  jsonDecode(response.body)  ;
         update() ;
          return jsonObj ;

      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }

  Future<dynamic> getApiList( String functionName) async {
    apiList  = []  ;
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    data["company_id"] =user.companyId;
 String url  =  AppConstants.getRequestApiList+"?company_id=" +user.companyId!+"&value_type_checkif="+functionName   ;
 print(url) ;
 try {
    var response  = await  api.getData(url: url)  ;

      if (response.statusCode == 200) {
        print("vacations");
        print(jsonDecode(response.body));
        var jsonObj  =  jsonDecode(response.body)  ;
        var jsonArr  =  jsonObj["data"] as List ;
        print(jsonArr) ;
        for(int i  =0  ; i< jsonArr.length ; i++  ){
          VacationType item  =  VacationType.fromJsonApiList(jsonArr[i]) ;
          print(item.nameAr)  ;
           apiList!.add(item);
        }

        ////apiItemTemp =apiList![0];
        update();
        return jsonDecode(response.body);

      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }

/*addRequest  (){
    Api api = Api() ;
    api.postDataWithFile(uri: AppConstants.addPermissionReq, obj: permissionsModel!, path: filePath!);
}*/

  resetLocation() async {
    currentLocation =null  ;
   await  getCurrentLocation() ;
  }

  setArrival  ({ required  String  id  , required String requestId   ,  required String vacationId}) async {
      setLoading(id, true) ;
      update();
      Api api = Api() ;
      final Map<String, dynamic> data = <String, dynamic>{};
      LoginResponsModel user =  await AuthController().getLoginData()  ;

      data['vacation_id'] = vacationId;
      data['employ_id'] = user.id;
    //  data['company_id'] = user.companyId;
      data['lat_arrive'] = currentLocation!.latitude.toString();
      data['lng_arrive'] = currentLocation!.longitude.toString();
      data['request_id'] =requestId ;
      data['id'] = id;
      final response = await api.postData2(uri: AppConstants.setArrival, map: data) ;
      if(response.statusCode ==200){
        print("return data  " +response.body) ;
        var res  =jsonDecode(response.body) ;
        bool success = res["success"] ;

       // isLoading = false;
        setLoading(id, false) ;

        if(success)
        {
          showOkDialog(context: Get.context
          !,message: 'confirm_arrive'.tr ,isCancelBtn: false ,onOkClick:(){
            Navigator.of(Get.context!).pop();
            Navigator.push(Get.context!, MaterialPageRoute(
                builder: (BuildContext context) => AllRequests()));

          }
          );
        }else{
          showOkDialog(context: Get.context
          !,message: 'try again' ,isCancelBtn: false ,onOkClick:(){
          });}

        update();
      }
      {
      //  isLoading = false;
        setLoading(id, false) ;

        update();
        print(response.statusCode) ;
      }
    }
    objectionReason ({ required  String  id  ,  String? objectionReason  , String? requestName }) async {
      update();
      Api api = Api() ;
      final Map<String, dynamic> data = <String, dynamic>{};
      LoginResponsModel user =  await AuthController().getLoginData()  ;
      data['employ_id'] = user.id;
      if(requestName == AppConstants.objectionReason){
      data['objection_reason'] =objectionReason ;
      }
      data['id'] = id;
      final response = await api.postData2(uri: requestName!, map: data) ;
      if(response.statusCode ==200){
        print("return data  " +response.body) ;
        var res  =jsonDecode(response.body) ;
        bool success = res["success"] ;
       // isLoading = false;
        if(success)
        {
          showOkDialog(context: Get.context
          !,message: res["msg"] ,isCancelBtn: false ,onOkClick:(){
            Navigator.of(Get.context!).pop();
            Navigator.push(Get.context!, MaterialPageRoute(
             builder: (BuildContext context) => DeductionRequests()));

          }
          );
        }else{
          showOkDialog(context: Get.context
          !,message: 'try again' ,isCancelBtn: false ,onOkClick:(){
          });
        }

        update();
      }
      {
      //  isLoading = false;
        setLoading(id, false) ;

        update();
        print(response.statusCode) ;
      }
    }
  getTime  () async {
    Api api = Api() ;
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    data['request_per_type'] = permissionTypeTemp!.name;
    data['request_type'] = requestTypeTemp!.name;
    data['request_per_date'] =dateController.text;
    final response = await api.postData2(uri: "${AppConstants.getTime}?id=${user.id!}", map: data) ;
    if(response.statusCode ==200){
      print("return data  " +response.body) ;
      var res  =jsonDecode(response.body) ;
      String result = res["status"] ;
      String checkMessage = res["mesaage_check"] ;
      String message = res["message"] ;
      if(result == "success"){
 if ( checkMessage.isEmpty){
   // save able
   Navigator.of( Get.context!).pop();

   String timeFrom = res["time_from"] ;
   String timeTo = res["time_to"] ;
   String minutes = res["sum_minuts"].toString() ;
   timeFromController.text = timeFrom;
   timeToController.text = timeTo;
   minutesController.text = minutes +" "+ "min".tr;

 }
  else{
   Navigator.of( Get.context!).pop();

   showOkDialog(context: Get.context!, message: checkMessage, isCancelBtn: false) ;
  }
      }
       else{
        Navigator.of( Get.context!).pop();

        showOkDialog(context: Get.context!, message: checkMessage, isCancelBtn: false) ;

      }
      update();
      print(response.statusCode) ;
    }
    return ;
  }

  Future<void> postDataWithFile({ required String uri }) async {
    isLoading = true   ;
    update() ;
    String url =AppConstants.baseUrl+uri;
    print(url) ;
    var request =  http.MultipartRequest("POST",   Uri.parse(url));
    request.fields['request_per_type'] = permissionTypeTemp!.name;
    request.fields['request_type'] = requestTypeTemp!.name;
    request.fields['request_per_details'] =detailsController.text;
    request.fields['request_per_date'] =dateController.text;
    request.fields['request_per_time_from'] = timeFromController.text;
    request.fields['request_per_time_to'] = timeToController.text;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    request.fields['employ_id'] = user.id!;
    request.fields['company_id'] = user.companyId!;
    print(request.fields);
    print(stream);
    print(length);
    if(fileNameController.text.isNotEmpty){
      var multipartFile ;
      if(kIsWeb){
         multipartFile =  http.MultipartFile.fromBytes('files', fileBytes ,filename: fileNameController.text);

            }
else{
       multipartFile = http.MultipartFile('files', stream, length,
        filename:fileNameController.text);
}

    request.files.add(multipartFile);

    }
    var streamedResponse = await request.send() ;
    var response = await http.Response.fromStream(streamedResponse);

    print(response.statusCode) ;

    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      print(response) ;
      print("Uploaded!");
      isLoading = false   ;
      update();
      if(data["status"] ==  "success") {
        showOkDialog(context: Get.context
        !, message: data["message"], isCancelBtn: false, onOkClick: () {
          Navigator.of(Get.context!).pop();
          Navigator.push(Get.context!, MaterialPageRoute(
              builder: (BuildContext context) => MainPermissions()));

        });

        //return "success" ;
      }
      else  if (data["status"] ==  "error"){
        showOkDialog(context: Get.context
        !, message: data["message"], isCancelBtn: false,);
      }
      }
//return "error" ;

  }
  Future<void> insertVacationRequest({ required String uri }) async {
    isLoading  = true  ;
    update() ;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    String url ="${AppConstants.baseUrl}$uri?employ_id=${user.id!}";
    print(url) ;
    var request =  http.MultipartRequest("POST",   Uri.parse(url));
    request.fields['vacation_typee'] =vacationTypeTemp!.Id!;
    request.fields['vacation_place'] = vacationPlaceTemp!.name;
    request.fields['details'] =detailsController.text;
    request.fields['where_travel'] =vacationPlaceController.text;
    request.fields['start_date_vacation'] = dateFromController.text;
    request.fields['end_date_vacation'] = dateToController.text;
    if(vacationPlaceTemp!.id==2){
    request.fields['exit_date'] = departureDateController.text;
    request.fields['return_date'] = returnDateController.text;}
    request.fields['employ_id'] = user.id!;
    request.fields['company_id'] = user.companyId!;
    print(request.fields);
    print(stream);
    print(length);

    if(fileNameController.text.isNotEmpty){
      var multipartFile ;
      if(kIsWeb){
        multipartFile =  http.MultipartFile.fromBytes('files', fileBytes ,filename: fileNameController.text);

      }
      else{
        multipartFile = http.MultipartFile('files', stream, length,
            filename:fileNameController.text);
      }

      request.files.add(multipartFile);

    }
    var streamedResponse = await request.send() ;
    var response = await http.Response.fromStream(streamedResponse);

    print(response.statusCode) ;

    if (response.statusCode == 200){
      isLoading=  false  ;
      var data = jsonDecode(response.body);
      print(data.toString()) ;
      update() ;
      //print(data) ;
      print("Uploaded!");
      showOkDialog(context: Get.context
      !,message: data["msg"] ,isCancelBtn: false ,onOkClick:(){
        //  Navigator.of( Get.context!).pop();
        Navigator.of( Get.context!).pop();
          Navigator.push(Get.context!, MaterialPageRoute(builder: (BuildContext context) => VacationRequest()));
      //  refreshCallback?.call() ;
        update() ;
      } );

      //return "success" ;

    }



  }



  Future<void> getVacationData( ) async {
  //  String url =AppConstants.baseUrl+uri;

    //var request =  http.MultipartRequest("POST",   Uri.parse(url));
    Api api = Api() ;
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    data['vacation_typee'] =vacationTypeTemp!.Id!;
   data['vacation_place'] = vacationPlaceTemp!.name;
    data['start_date_vacation'] = dateFromController.text;
    data['end_date_vacation'] = dateToController.text;
    final response = await api.postData2(uri: "${AppConstants.getVacationData}?employ_id=${user.id!}", map: data) ;
    if(response.statusCode ==200){
      print("return data  " +response.body) ;
      var res  =jsonDecode(response.body) ;
      String status = res["status"] ;
      if(status == "success")
      {
         var pendingCheck  =  res["pending_check"] ;
         canApplyVacation  =  pendingCheck["can_apply_vacation"] ;
        PendingCheck pendingCheckObj  =  PendingCheck.fromJson(pendingCheck) ;
        print(pendingCheckObj.toString()) ;
        Vacation vacationObj  =  Vacation.fromJson(res) ;
        print(pendingCheckObj.toString()) ;
update() ;
if(canApplyVacation){
  showDialog(
    context: Get.context!,
    builder: (_) =>
        VacationPopup(
    vacation: vacationObj, message: pendingCheck["message"]
    ),
  );
}else{
  showDialog(
    context: Get.context!,
    builder: (_) => PendingPopup(
      pendingCheck: pendingCheckObj,
    ),
  );

}



    }
       else if(status == "error"){
        String msg = res["msg"] ;
        canApplyVacation = false  ;
        update();
        showOkDialog(context: Get.context!, message: msg, isCancelBtn: false)  ;
      }
      }}
  getProcessingOptionLevel  (String levelId) async {
    levelOptions = []; // قم بتصفية القائمة أولاً لتجنب ظهور بيانات قديمة
    update();
    String url;
    url = "${AppConstants.levelOptions}?request_type_id=${levelId}";
    print(url);

    var response = await api.getData(url: url);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var data = jsonDecode(response.body);
      print(data["success"]);
      if (data["success"]) {
        levelOptions = data["data"] as List;



        // if(fromPriceOffer){
        //   shipmentDetails = dataArr.map((e) => ModelBooking.fromJsonPriceOfferDetails(e)).toList();
        //
        // }
        // else{
        // shipmentDetails = dataArr.map((e) => ModelBooking.fromJsonDetails(e)).toList();}
        isLoading = false;

        update();

        return levelOptions;
      } else {
        isLoading = false;

        update();
      }
    } else {
      throw Exception('Failed to load data!');
    }

  }
  Future<void> tripProcessing({ required String uri  , required String level_id ,  required String level  , required String requestId}) async {
    isLoading  = true  ;
    update() ;
    String url =AppConstants.baseUrl+uri;
    print(url) ;
    var request =  http.MultipartRequest("POST",   Uri.parse(url));

    request.fields['request_id'] =requestId;
    request.fields['details'] =detailsController.text;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    request.fields['add_user_id'] = user.id!;
    request.fields['levell_id'] = level_id;
    request.fields['level_num'] = level;
      if(currentLocation != null){
        request.fields['level_lat'] = currentLocation!.latitude.toString();
        request.fields['level_long'] = currentLocation!.longitude.toString();
      }
      else{
        showOkDialog(context: Get.context!    ,message: "you_have_to_allow".tr, isCancelBtn: false  ) ;
        isLoading  = false  ;
        return ;

      }

    print(request.fields);
    print(stream);
    print(length);
    List< Map<String, dynamic>> itemsMap = [];

    for (int i  = 0 ; i <levelOptions.length ; i ++) {
      TextEditingController  controller  =levelOptions[i]["controller"] ;
      request.fields["options[$i][options_id]"] =
      levelOptions[i]["options_id"];
      request.fields["options[$i][update_options_id]"] =
      levelOptions[i]["update_options_id"];
      request.fields["options[$i][value_type]"] =
      levelOptions[i]["value_type"];
      if(uri==AppConstants.editProfile){
        request.fields["options[$i][var_name]"] = controller.text.isEmpty?levelOptions[i]["value"]:controller.text;
      }
      else if(levelOptions[i]["value_type"] =="checkbox" && controller.text.isEmpty){
        request.fields["options[$i][var_name]"] ="0" ;
      }
      else{
        request.fields["options[$i][var_name]"] = controller.text; }
    }
    if(filesList.isNotEmpty){
      // var multipartFile ;
      print( filesList.length);
      for (int i = 0; i < filesNames.length; i++) {
        request.fields['attachment_name[$i]'] = filesNames[i];
      }
      for(int i =0 ; i < filesList.length  ; i++) {
        // if(kIsWeb){
        //   multipartFile =  http.MultipartFile.fromBytes(filesList[i].key!, filesList[i].fileBytes! ,filename: fileNameController.text);
        //    print(filesList[i].key!) ;
        //
        // }
        var file = filesList[i];

        var multipartFile = http.MultipartFile(
          file.key!,
          file.stream,
          file.length,
          filename: file.fileName, // كل ملف باسمه
        );
        print(file.fileName) ;
        print(file.stream) ;
        print(file.length) ;
        print(file.key) ;

        //   }
        request.files.add(multipartFile);

      }



    }
    var response  = await request.send() ;
    print(response.statusCode) ;
    print(request.fields);
    print(request.files);
    var responseBody = await response.stream.bytesToString();
    print("Response Body: $responseBody");

    if (response.statusCode == 200) {
      print("Uploaded!");
      isLoading=  false  ;
      showOkDialog(context: Get.context
      !,
          message: 'added_to_requests_permission'.tr,
          isCancelBtn: false,
          onOkClick: () {
         Navigator.of(Get.context!).pop();
              Navigator.pushReplacement(Get.context!, MaterialPageRoute(
                  builder: (BuildContext context) => TripsScreen()));



          });
      update();

    }
    else{
      isLoading=  false  ;
      showOkDialog(context: Get.context
      !,
          message: 'try_again'.tr,
          isCancelBtn: false,
          onOkClick: () {
          });
      update();
    }

  }
  Future<void> insertRequest({ required String uri }) async {
     isLoading  = true  ;
     update() ;
    String url =AppConstants.baseUrl+uri;
    print(url) ;
    var request =  http.MultipartRequest("POST",   Uri.parse(url));

    request.fields['request_type_id'] =vacationTypeTemp!.Id!;
    request.fields['details'] =detailsController.text;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    request.fields['employ_id'] = user.id!;
    request.fields['company_id'] = user.companyId!;
    if(vacationTypeTemp!.Id  == "572222") {
      if(currentLocation != null){
      request.fields['lat'] = currentLocation!.latitude.toString();
      request.fields['lng'] = currentLocation!.longitude.toString(); }
      else{
        showOkDialog(context: Get.context!    ,message: "you_have_to_allow".tr, isCancelBtn: false  ) ;
         isLoading  = false  ;
          return ;

      }

    }
    print(request.fields);
    print(stream);
    print(length);
    List< Map<String, dynamic>> itemsMap = [];

    for (int i  = 0 ; i <vacationTypeTemp!. options!.length ; i ++) {
      TextEditingController  controller  = vacationTypeTemp!. options![i]["controller"] ;

      // Map<String, dynamic> map  =
      //   {
      //     "options_id" :vacationTypeTemp!. options![i]["options_id"],
      //     "update_options_id": vacationTypeTemp!. options![i]["update_options_id"],
      //     "value_type":  vacationTypeTemp!. options![i]["value_type"] ,
      //    "var_name":  controller.text ,
      //   };
      // itemsMap.add(map) ;


      request.fields["options[$i][options_id]"] =
      vacationTypeTemp!.options![i]["options_id"];
      request.fields["options[$i][update_options_id]"] =
      vacationTypeTemp!.options![i]["update_options_id"];
      request.fields["options[$i][value_type]"] =
      vacationTypeTemp!.options![i]["value_type"];
       if(uri==AppConstants.editProfile){
      request.fields["options[$i][var_name]"] = controller.text.isEmpty?vacationTypeTemp!.options![i]["value"]:controller.text;
       }
       else{
      request.fields["options[$i][var_name]"] = controller.text; }
    }
    // String itemsJson = jsonEncode(itemsMap);
    // request.fields["options"] = itemsJson;
    if(filesList.isNotEmpty){
     // var multipartFile ;
      print( filesList.length);

      for(int i =0 ; i < filesList.length  ; i++) {
        // if(kIsWeb){
        //   multipartFile =  http.MultipartFile.fromBytes(filesList[i].key!, filesList[i].fileBytes! ,filename: fileNameController.text);
        //    print(filesList[i].key!) ;
        //
        // }
        var file = filesList[i];

        var multipartFile = http.MultipartFile(
          file.key!,
          file.stream,
          file.length,
          filename: file.fileName, // كل ملف باسمه
        );
print(file.fileName) ;
print(file.stream) ;
print(file.length) ;
print(file.key) ;

        //   }
        request.files.add(multipartFile);

      }



    }
    var response  = await request.send() ;
    print(response.statusCode) ;
    print(request.fields);
    print(request.files);
    var responseBody = await response.stream.bytesToString();
    print("Response Body: $responseBody");

    if (response.statusCode == 200) {
      print("Uploaded!");
      isLoading=  false  ;
      showOkDialog(context: Get.context
      !,
          message: 'added_to_requests_permission'.tr,
          isCancelBtn: false,
          onOkClick: () {
            Navigator.of(Get.context!).pop();
             if(uri==AppConstants.editProfile ){

             }
           else if(  uri == AppConstants.editMandatoryData){

             }
           else{
               Navigator.push(Get.context!, MaterialPageRoute(
                   builder: (BuildContext context) => AllRequests()));
             }


          });
      update();

    }
  else{
      isLoading=  false  ;
      showOkDialog(context: Get.context
      !,
          message: 'try_again'.tr,
          isCancelBtn: false,
          onOkClick: () {
          });
      update();
    }

  }
  VoidCallback? refreshCallback;

  Future<void> insertJustification({ Questions? question  }) async {
    String url =AppConstants.baseUrl+AppConstants.insertJustification;
    print(url) ;
    var request =  http.MultipartRequest("POST",   Uri.parse(url));
    request.fields['employee_reply'] = justificationController.text;
    request.fields['hr_question_type'] = question!.type!;
    request.fields['hr_question_date'] = question.date!;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    request.fields['employ_id'] = user.id!;
    request.fields['att_name'] = fileName.text;
    print(request.fields);
    print(stream);
    print(length);
    if(fileName.text.isNotEmpty){
   /* var multipartFile = http.MultipartFile('files', stream, length,
        filename:fileNameController.text);*/
      var multipartFile ;
      if(kIsWeb){
        multipartFile =  http.MultipartFile.fromBytes('files', fileBytes ,filename: fileName.text);

      }
      else{
        multipartFile = http.MultipartFile('files', stream, length,
            filename:fileName.text);
      }

      request.files.add(multipartFile);

    }

    var streamedResponse = await request.send() ;
    var response = await http.Response.fromStream(streamedResponse);

    print(response.statusCode) ;

    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      print(response) ;
      print("Uploaded!");
      showOkDialog(context: Get.context
      !,message: data["message"] ,isCancelBtn: false ,onOkClick:(){
      //  Navigator.of( Get.context!).pop();
        Navigator.of( Get.context!).pop();
      //  Navigator.push(Get.context!, MaterialPageRoute(builder: (BuildContext context) => MainPermissions()));
refreshCallback?.call() ;
        update() ;
      } );

      //return "success" ;

    }
//return "error" ;

  }
Future<void> insertException({String? date }) async {
    isLoading  = true  ;
    update() ;
  LoginResponsModel user =  await AuthController().getLoginData()  ;

  String url ="${AppConstants.baseUrl}${AppConstants.insertException }?employ_id=${user.id!}";
    print(url) ;
    var request =  http.MultipartRequest("POST",   Uri.parse(url));
    request.fields['employee_reply'] = justificationController.text;
    request.fields['date_from'] = date!;
    //request.fields['employ_id'] = user.id!;
    request.fields['att_name'] = fileName.text;
    print(request.fields);
    print(stream);
    print(length);
    if(fileName.text.isNotEmpty){
   /* var multipartFile = http.MultipartFile('files', stream, length,
        filename:fileNameController.text);*/
      var multipartFile ;
      if(kIsWeb){
        multipartFile =  http.MultipartFile.fromBytes('files', fileBytes ,filename: fileName.text);

      }
      else{
        multipartFile = http.MultipartFile('files', stream, length,
            filename:fileName.text);
      }

      request.files.add(multipartFile);

    }

    var streamedResponse = await request.send() ;
    var response = await http.Response.fromStream(streamedResponse);

    print(response.statusCode) ;

    if (response.statusCode == 200){
       isLoading=false  ;
      var data = jsonDecode(response.body);
      print(response) ;
      print("Uploaded!");
      showOkDialog(context: Get.context
      !,message: data["msg"] ,isCancelBtn: false ,onOkClick:(){
      //  Navigator.of( Get.context!).pop();
        Navigator.of( Get.context!).pop();

        refreshCallback?.call() ;
        update() ;
      } );

      //return "success" ;

    }
//return "error" ;

  }

  List<dynamic> viewdata = [];
  /*loadData() async {
    var data = await getData();
    if (data != 'error') {
      viewdata = (data['data'] as List);
      update();
    }
    print("11111111111111111111111111111111111111111111111111111111222");
    print(data);
  }*/
  bool isImage(String path) {
    final ext = path.toLowerCase();
    return ext.endsWith(".jpg") ||
        ext.endsWith(".jpeg") ||
        ext.endsWith(".png") ||
        ext.endsWith(".gif") ||
        ext.endsWith(".bmp") ||
        ext.endsWith(".webp");
  }
  getDialog(String message ){
    Get.dialog(
      AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("OK".tr),
          ),
        ],
      ),
    );

  }
}

class PermissionTypeModel {
  String name;
  int id;
  PermissionTypeModel({
    required this.name,
    required this.id,
  });
}

class RequestTypeModel {
  String name;
  int id;
  RequestTypeModel({
    required this.name,
    required this.id,
  });

}

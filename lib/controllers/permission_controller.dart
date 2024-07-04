// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';
import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/model/File.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/request_options.dart';
import 'package:betakety_app/model/vacation_type.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:betakety_app/view/screens/Requests/all_requests.dart';
import 'package:betakety_app/view/screens/Requests/main_permissions.dart';
import 'package:betakety_app/view/screens/Requests/vacation_request.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../view/base/custom_snackbar.dart';
import '../model/requests_permissions_model.dart';

class PermissionController extends GetxController {
  // PermissionRepo permissionRepo;

  // PermissionController({
  //   required this.permissionRepo,
  // });

  int _selectedIndex = 0;
  Api api = Api()  ;
  int get selectedIndex => _selectedIndex;
  changeSelected(int x) {
    _selectedIndex = x;
    update();
  }

  List<RequestTypeModel> requestTypeList = [
    RequestTypeModel(name: "late", id: 1),
    RequestTypeModel(name: "leave_before", id: 2),
  ];

  List<PermissionTypeModel> permissionTypeList = [
    PermissionTypeModel(name: "business_trip", id: 1),
    PermissionTypeModel(name: "emergency", id: 2),
  ];
  List<RequestTypeModel> vacationPlaceList = [
    RequestTypeModel(name: "inside", id: 1),
    RequestTypeModel(name: "outside", id: 2),
  ];
  List<VacationType>? vacationTypeList;

  RequestTypeModel? requestTypeTemp;
  PermissionTypeModel? permissionTypeTemp;
  RequestTypeModel? vacationPlaceTemp;
  VacationType? vacationTypeTemp;
  TextEditingController detailsController = TextEditingController();
  TextEditingController vacationPlaceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  TextEditingController timeFromController = TextEditingController();
  TextEditingController timeToController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();
  TextEditingController justificationController = TextEditingController();
  FilePickerResult? addedFile;
  var stream ;
  var length ;
  List<SendFile> filesList  = [] ;
  resetData() {
  detailsController.clear();
  dateController.clear();
  timeFromController.clear();
 timeToController.clear();
 requestTypeTemp = requestTypeList[0];
 permissionTypeTemp = permissionTypeList[0];
 vacationPlaceTemp = vacationPlaceList[0];
 vacationTypeTemp = VacationType(nameEn: "Extended sick leave 16", Id: "279916");
  addedFile = null;
   fileNameController.clear();
  }
  String? filePath  ;
  RequestsPermissionsModel ? permissionsModel  ;

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
  selectSingleFile(TextEditingController  controller  , String key ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      if(kIsWeb){
      fileBytes = result.files.single.bytes;
print(fileBytes);
      controller.text = result.files.single.name;

      }
      else{
         File file = File(result.files.single.path!);

        stream =  http.ByteStream(file.openRead())..cast();
        // get file length
         length = await file.length();
         controller.text = result.files.single.path!;
      }


    } else {
      // User canceled the picker
    }
     filesList.add(SendFile(key: key, stream: stream, length: length)) ;
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
    } else if (vacationPlaceTemp!.id ==2 && vacationPlaceController.text.isEmpty) {
      showCustomSnackBar("${'vacation_place'.tr} ${"is_required".tr}");
    }else if (dateFromController.text.isEmpty) {
      showCustomSnackBar("${'date_from'.tr} ${"is_required".tr}");
    } else if (dateToController.text.isEmpty) {
      showCustomSnackBar("${'date_to'.tr} ${"is_required".tr}");
    }
   else {
insertVacationRequest(uri: AppConstants.insertVacation) ;
    }
  } Future<void> validateRequestsAndShowSnackbar(  List<dynamic>? options) async {
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
  }Future<dynamic> getTypes( String functionName) async {
    vacationTypeList  = []  ;
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    data["company_id"] =user.companyId;
 String url  =  functionName+"?company_id=" +user.companyId!   ;
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
           if (functionName  == AppConstants.vacationTypes){
          VacationType v  =  VacationType.fromJson(jsonArr[i]) ;
          print(v.nameAr)  ;
           vacationTypeList!.add(v);
           }
            else{
             VacationType v  =  VacationType.fromJsonRequests(jsonArr[i]) ;
             print(v.nameAr)  ;
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
  }

/*addRequest  (){
    Api api = Api() ;
    api.postDataWithFile(uri: AppConstants.addPermissionReq, obj: permissionsModel!, path: filePath!);
}*/
  Future<void> postDataWithFile({ required String uri }) async {
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
var response  = await request.send() ;
    print(response.statusCode) ;
    
      if (response.statusCode == 200){
        print(response) ;
        print("Uploaded!");
        showOkDialog(context: Get.context
            !,message: 'added_to_requests_permission'.tr ,isCancelBtn: false ,onOkClick:(){
          Navigator.of( Get.context!).pop();
          Navigator.push(Get.context!, MaterialPageRoute(builder: (BuildContext context) => MainPermissions()));

          update() ;
        } );

        //return "success" ;

      }
//return "error" ;

  }
  Future<void> insertVacationRequest({ required String uri }) async {
    String url =AppConstants.baseUrl+uri;
    print(url) ;
    var request =  http.MultipartRequest("POST",   Uri.parse(url));
    request.fields['vacation_typee'] =vacationTypeTemp!.Id!;
    request.fields['vacation_place'] = vacationPlaceTemp!.name;
    request.fields['details'] =detailsController.text;
    request.fields['where_travel'] =vacationPlaceController.text;
    request.fields['start_date_vacation'] = dateFromController.text;
    request.fields['end_date_vacation'] = dateToController.text;
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
    var response  = await request.send() ;
    print(response.statusCode) ;

    if (response.statusCode == 200) {
      print(response);
      print("Uploaded!");
      showOkDialog(context: Get.context
      !,
          message: 'added_to_requests_permission'.tr,
          isCancelBtn: false,
          onOkClick: () {
            Navigator.of(Get.context!).pop();
            Navigator.push(Get.context!, MaterialPageRoute(
                builder: (BuildContext context) => VacationRequest()));

            update();
          });
    }}

  Future<void> insertRequest({ required String uri }) async {
    String url =AppConstants.baseUrl+uri;
    print(url) ;
    var request =  http.MultipartRequest("POST",   Uri.parse(url));

    request.fields['request_type_id'] =vacationTypeTemp!.Id!;
    request.fields['details'] =detailsController.text;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    request.fields['employ_id'] = user.id!;
    request.fields['company_id'] = user.companyId!;
    print(request.fields);
    print(stream);
    print(length);
    List< Map<String, dynamic>> itemsMap = [];

    for (int i  = 0 ; i <vacationTypeTemp!. options!.length ; i ++) {
      TextEditingController  controller  = vacationTypeTemp!. options![i]["controller"] ;

      Map<String, dynamic> map  =
        {
          "options_id" :vacationTypeTemp!. options![i]["options_id"],
          "update_options_id": vacationTypeTemp!. options![i]["update_options_id"],
          "value_type":  vacationTypeTemp!. options![i]["value_type"] ,
          "var_name":  controller.text,
        };
      itemsMap.add(map) ;


    }
    String itemsJson = jsonEncode(itemsMap);
    request.fields["options"] = itemsJson;
    if(fileNameController.text.isNotEmpty){
      var multipartFile ;
      for(int i =0 ; i < filesList.length  ; i++) {
        if(kIsWeb){
          multipartFile =  http.MultipartFile.fromBytes(filesList[i].key!, filesList[i].fileBytes! ,filename: fileNameController.text);

        }
        else{
          multipartFile = http.MultipartFile(filesList[i].key!, filesList[i].stream!, filesList[i].length!,
              filename:fileNameController.text);
        }
        request.files.add(multipartFile);

      }



    }
    var response  = await request.send() ;
    print(response.statusCode) ;
    print(request.fields);
    print(request.files);

    if (response.statusCode == 200) {
      print(response);
      print("Uploaded!");
      showOkDialog(context: Get.context
      !,
          message: 'added_to_requests_permission'.tr,
          isCancelBtn: false,
          onOkClick: () {
            Navigator.of(Get.context!).pop();
            Navigator.push(Get.context!, MaterialPageRoute(
                builder: (BuildContext context) => AllRequests()));

            update();
          });
    }}
      Future<void> insertJustification({ required String hr_question_id ,required  String hr_question_date }) async {
    String url =AppConstants.baseUrl+AppConstants.insertJustification;
    print(url) ;
    var request =  http.MultipartRequest("POST",   Uri.parse(url));
    request.fields['employee_reply'] = justificationController.text;
    request.fields['hr_question_id'] = hr_question_id;
    request.fields['hr_question_date'] = hr_question_date;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    request.fields['employ_id'] = user.id!;
    print(request.fields);
    print(stream);
    print(length);
    if(fileNameController.text.isNotEmpty){
   /* var multipartFile = http.MultipartFile('files', stream, length,
        filename:fileNameController.text);*/
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

    var response  = await request.send() ;
    print(response.statusCode) ;

    if (response.statusCode == 200){
      print(response) ;
      print("Uploaded!");
      showOkDialog(context: Get.context
      !,message: 'added_to_requests_permission'.tr ,isCancelBtn: false ,onOkClick:(){
      //  Navigator.of( Get.context!).pop();
        Navigator.of( Get.context!).pop();
      //  Navigator.push(Get.context!, MaterialPageRoute(builder: (BuildContext context) => MainPermissions()));

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

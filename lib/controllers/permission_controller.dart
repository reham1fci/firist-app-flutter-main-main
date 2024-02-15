// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:betakety_app/api/Api.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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

  RequestTypeModel? requestTypeTemp;
  PermissionTypeModel? permissionTypeTemp;
  TextEditingController detailsController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeFromController = TextEditingController();
  TextEditingController timeToController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();
  // FilePickerResult? addedFile;
  var stream ;
  var length ;
  // resetData() {
  //   detailsController.clear();
  //   dateController.clear();
  //   t?imeFromController.clear();
  //   timeToController.clear();
  //   requestTypeTemp = requestTypeList[0];
  //   permissionTypeTemp = permissionTypeList[0];
  //   addedFile = null;
  //   fileNameController.clear();
  // }//
  String? filePath  ;
  RequestsPermissionsModel ? permissionsModel  ;

   selectFile() async {
    int selectFiles = 3;
   FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
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
  selectSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
       stream =  http.ByteStream(file.openRead())..cast();
      // get file length
       length = await file.length();
      fileNameController.text = result.files.single.path!;

    } else {
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

  void validateFieldsAndShowSnackbar() {
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
  }

  Future<dynamic> getPermissionsRequests() async {
    // data['the_reason'] = theReason
    final Map<String, dynamic> data = <String, dynamic>{};
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    data["employ_id"] =user.id;
 String url  =  AppConstants.showPermissionReq+"?"+"employ_id=" +user.id!   ;
 print(url) ;
 try {
    var response  = await  api.getData(url: url)  ;

      if (response.statusCode == 200) {
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
    //  data['request_per_stat'] = requestPerStat;
    //data['updateDate_Time'] = updateDateTime;
    //  data['update_user_id'] = updateUserId;
    // data['the_reason'] = theReason;
    LoginResponsModel user =  await AuthController().getLoginData()  ;
    request.fields['employ_id'] = user.id!;
    print(request.fields);
    print(stream);
    print(length);
    var multipartFile = http.MultipartFile('files', stream, length,
        filename:fileNameController.text);
    request.files.add(multipartFile);
var response  = await request.send() ;
    print(response.statusCode) ;
    
      if (response.statusCode == 200){
        print(response) ;
        print("Uploaded!");
      }


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

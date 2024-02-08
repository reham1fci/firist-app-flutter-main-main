import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import '../../util/constant.dart';
import '../../view/base/custom_text_field.dart';
import '../../view/base/custom_button.dart';
import '../../view/base/custom_field_with_title.dart';
//import '../../controllers/permission_controller.dart';
import '../../util/dimensions.dart';
import '../../util/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart' as http_parser;

class AddRequestPerMohranSaddamm extends StatefulWidget {
  const AddRequestPerMohranSaddamm({super.key});

  @override
  State<AddRequestPerMohranSaddamm> createState() =>
      _AddRequestPerMohranState();
}

/*class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool? readOnly;
  // Add the validator parameter

  CustomTextField({
    required this.hintText,
    required this.inputType,
    this.controller,
    this.onChanged,
    this.onTap,
    this.validator,
    this.maxLines,
    this.readOnly,
    // Add the validator parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
      keyboardType: inputType,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
    );
  }
}*/

class _AddRequestPerMohranState extends State<AddRequestPerMohranSaddamm> {
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _from_timeController = TextEditingController();
  final TextEditingController _to_timeController = TextEditingController();
  final TextEditingController _fileController = TextEditingController();
  final _detailsFormKey = GlobalKey<FormState>(); // Add this line
  final _formKey = GlobalKey<FormState>();
  String? validationError;
  get onChanged => null;
  get onTap => null;

  File? _selectedFile;
  // Add more controllers for additional fields
  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  List<Map<String, dynamic>> options_r_type = [
    {'option': 'ضرف طارئ', 'value': 'emergency'},
    {'option': 'رحلة عمل', 'value': 'business_trip'},
  ];
  List<Map<String, dynamic>> options_type = [
    {'option': 'التاخر عن الدوام', 'value': 'Late'},
    {'option': 'المغادرة قبل انتهاء الدوام', 'value': 'leave_before'},
  ];
  late Map<String, dynamic> selectedOption_r_type;
  late Map<String, dynamic> selectedOption_type; // Define selectedOption

  String id = '';
  String name = '';
  String email = '';
  String photo = '';
  @override
  void initState() {
    super.initState();
    getLoginData();
    selectedOption_type = options_type[0];
    selectedOption_r_type =
        options_r_type[0]; // Initialize with the first option
  }

  void getLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? responseData = prefs.getString('response_data');
    if (responseData != null) {
      Map<String, dynamic> responseJson = json.decode(responseData);
      setState(() {
        id = responseJson['id'];
        name = responseJson['name'];
        email = responseJson['email'];
        photo = responseJson['photo'];
      });
    }
  }

  @override
  void dispose() {
    _detailsController.dispose();
    _dateController.dispose();
    _from_timeController.dispose();
    _to_timeController.dispose();
    _fileController.dispose();
    // Dispose additional controllers
    super.dispose();
  }

  Future<void> _insertData() async {
    var url =
        'https://marsalogistics.com/new/hr_marsa_system/ar/api_hr_apps/insert_request_permission1_api.php';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['employ_id'] = id;
    request.fields['request_type'] = selectedOption_type['value'].toString();
    request.fields['request_per_type'] =
        selectedOption_r_type['value'].toString();
    request.fields['request_per_details'] = _detailsController.text;
    request.fields['request_per_date'] = _dateController.text;
    request.fields['request_per_time_from'] = _from_timeController.text;
    request.fields['request_per_time_to'] = _to_timeController.text;
    // Add more fields as needed

    if (_selectedFile != null) {
      var fileStream =
          http.ByteStream(Stream.castFrom(_selectedFile!.openRead()));
      var length = await _selectedFile!.length();
      var multipartFile = http.MultipartFile(
        'file',
        fileStream,
        length,
        filename: _selectedFile!.path.split('/').last,
        contentType: http_parser.MediaType('application', 'octet-stream'),
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      // var responseBody = json.decode(response.body);
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      if (jsonResponse['success']) {
        print('Data inserted successfully!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              jsonResponse['msg'],
              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        _detailsController.clear();
        _dateController.clear();
        _from_timeController.clear();
        _to_timeController.clear();
      } else {
        print('Failed to insert data. Error: ${jsonResponse['msg']}');
      }
    } else {
      print('Failed to insert data. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      // appBar: AppBar(
      //   title: Text("إضافة طلب إذن"),
      // ),

      appBar: AppBar(
        iconTheme: const IconThemeData(color: kTitleColor),
        centerTitle: true,
        title: Text(
          'add_request_permission'.tr,
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  CustomFieldWithTitle(
                    width: Get.width / 2,
                    title: "type".tr,
                    customTextField: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<Map<String, dynamic>>(
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Text('type'.tr),
                        ),
                        value: selectedOption_r_type,
                        items: options_r_type
                            .map<DropdownMenuItem<Map<String, dynamic>>>(
                                (option) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: option,
                            child: Text(option['option']),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedOption_r_type = newValue!;
                          });
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                  CustomFieldWithTitle(
                    width: Get.width / 2,
                    title: "request_type".tr,
                    customTextField: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<Map<String, dynamic>>(
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Text('request_type'.tr),
                        ),
                        value: selectedOption_type,
                        items: options_type
                            .map<DropdownMenuItem<Map<String, dynamic>>>(
                                (option) {
                          return DropdownMenuItem<Map<String, dynamic>>(
                            value: option,
                            child: Text(option['option']),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedOption_type = newValue!;
                          });
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
              CustomFieldWithTitle(
                title: "details".tr,
                customTextField: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: CustomTextField(
                      maxLines: 2,
                      hintText: 'details'.tr,
                      inputType: TextInputType.text,
                      controller: _detailsController,
                      onChanged: onChanged,
                      onTap: onTap,
                      // validator: (value) {
                      //   if (value?.isEmpty ?? true) {
                      //     return 'Please enter details';
                      //   }
                      //   return null;
                      // },
                    )),
              ),
              CustomFieldWithTitle(
                height: 50,
                title: "date".tr,
                customTextField: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: CustomTextField(
                      onTap: () async {
                        DateTime currentDate = DateTime.now();
                        final DateTime firstDate = currentDate;
                        final DateTime lastDate =
                            currentDate.add(const Duration(days: 60));
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: currentDate,
                          firstDate: firstDate,
                          lastDate: lastDate,
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _dateController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });
                        }
                      },
                      readOnly: true,
                      hintText: 'date'.tr,
                      inputType: TextInputType.text,
                      controller: _dateController,
                      // validator: (value) {
                      //   if (value?.isEmpty ?? true) {
                      //     return 'Please enter date';
                      //   }
                      //   return null;
                      // },
                    )),
              ),
              Row(
                children: [
                  CustomFieldWithTitle(
                    height: 50,
                    width: Get.width / 2,
                    title: "from_time".tr,
                    customTextField: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: CustomTextField(
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                _from_timeController.text =
                                    "${pickedTime.hour >= 0 && pickedTime.hour < 10 ? "0${pickedTime.hour}" : pickedTime.hour}:${pickedTime.minute}:00";
                              });
                            }
                          },
                          readOnly: true,
                          hintText: 'from_time'.tr,
                          inputType: TextInputType.text,
                          controller: _from_timeController,
                        )),
                  ),
                  CustomFieldWithTitle(
                    height: 50,
                    width: Get.width / 2,
                    title: "to_time".tr,
                    customTextField: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: CustomTextField(
                          onTap: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                _to_timeController.text =
                                    "${pickedTime.hour >= 0 && pickedTime.hour < 10 ? "0${pickedTime.hour}" : pickedTime.hour}:${pickedTime.minute}:00";
                              });
                            }
                          },
                          readOnly: true,
                          hintText: 'to_time'.tr,
                          inputType: TextInputType.text,
                          controller: _to_timeController,
                        )),
                  ),
                ],
              ),

              //====================================
              CustomFieldWithTitle(
                requiredField: false,
                title: "file_add".tr,
                customTextField: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: CustomTextField(
                    onTap: () {
                      //pController.selectFile();
                    },
                    maxLines: 2,
                    readOnly: true,
                    hintText: 'file_add'.tr,
                    inputType: TextInputType.text,
                    // controller: pController.fileNameController,
                  ),
                ),
              ),
              //===============================================

              // CustomFieldWithTitle(
              //   title: 'file'.tr,
              //   customTextField: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       ElevatedButton(
              //         onPressed: _selectFile,
              //         child: Text('Select Fileee'),
              //       ),
              //       if (_selectedFile != null)
              //         Padding(
              //           padding: const EdgeInsets.only(top: 8.0),
              //           child: Text(_selectedFile!.path),
              //         ),
              //     ],
              //   ),
              // ),

              //=============/saddam=file=================================

              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: CustomButton(
                  buttonText: "save".tr,
                  onPressed: () {
                    //pController.validateFieldsAndShowSnackbar();
                    if (_formKey.currentState!.validate()) {
                      _insertData();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

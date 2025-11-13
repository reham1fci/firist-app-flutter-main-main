import 'package:betakety_app/view/base/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../util/constant.dart';
import '../../base/custom_text_field.dart';
import '../../base/custom_button.dart';
import '../../base/custom_field_with_title.dart';
import '../../../controllers/permission_controller.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';
import 'widget/hours_statics.dart';

class AddRequestPermission extends StatefulWidget {
  const AddRequestPermission({super.key});

  @override
  State<AddRequestPermission> createState() => _AddRequestPermissionState();
}

class _AddRequestPermissionState extends State<AddRequestPermission> {
   var  hourObject  ;
  @override
  void initState() {
    Get.find<PermissionController>().resetData();
     getHoursCount()   ;
    super.initState();
  }
   getHoursCount() async {
   hourObject =   await   Get.find<PermissionController>().getHoursStatistic();
    setState(() {

    });

   }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PermissionController>(builder: (pController) {
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
          child: Column(
            children: [
           hourObject != null ? HoursStatics(allowed: hourObject["number_hours_allowed_month"].toString() , remaining: hourObject["number_hours_remaining"].toString(),required: hourObject["number_hours_required_month"].toString(),) :SizedBox(),
              Row(
                children: [
                  CustomFieldWithTitle(
                    requiredField: true,
                    width: Get.width / 2,
                    title: "type".tr,
                    customTextField: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<PermissionTypeModel>(
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Text('type'.tr),
                        ),
                        value: pController.permissionTypeTemp,
                        items: pController.permissionTypeList.map((value) {
                          return DropdownMenuItem<PermissionTypeModel>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9),
                              child: Text(value.name.tr),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          pController.permissionTypeTemp = value;
                          pController.dateController.clear();
                          pController.timeToController.clear();
                          pController.timeFromController.clear();
                          pController.minutesController.clear();
                          pController.update();
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                  CustomFieldWithTitle(
                    requiredField: true,
                    width: Get.width / 2,
                    title: "request_type".tr,
                    customTextField: Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<RequestTypeModel>(
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Text('request_type'.tr),
                        ),
                        value: pController.requestTypeTemp,
                        items: pController.requestTypeList.map((value) {
                          return DropdownMenuItem<RequestTypeModel>(
                            value: value,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9),
                              child: Text(
                                value.name.tr,
                                maxLines: 1,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          pController.requestTypeTemp = value;
                          pController.dateController.clear();
                          pController.timeToController.clear();
                          pController.timeFromController.clear();
                          pController.minutesController.clear();
                          pController.update();
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),

              CustomFieldWithTitle(
                height: 50,
                requiredField: true,
                title: "date".tr,
                customTextField: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: CustomTextField(
                      onTap: () async {
                        DateTime currentDate = DateTime.now();
                        DateTime firstDate = DateTime(
                          currentDate.month == 1 ? currentDate.year - 1 : currentDate.year,
                          currentDate.month == 1 ? 12 : currentDate.month - 1,
                          currentDate.day,
                        );
                        final DateTime lastDate =
                            currentDate.add(const Duration(days: 60));
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: currentDate,
                          firstDate: firstDate,
                          lastDate: lastDate,
                        );
                        if (pickedDate != null) {
                          setState(() async {
                            pController.dateController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                             // call api
                            showLoadingDialog(context);
                            await    pController.getTime() ;

                          });
                        }
                      },
                      readOnly: true,
                      hintText: 'date'.tr,
                      inputType: TextInputType.text,
                      controller: pController.dateController,
                    )),
              ),
              Row(
                children: [
                  CustomFieldWithTitle(
                    height: 50,
                    requiredField: true,
                    width: Get.width / 3,
                    title: "from_time".tr,
                    customTextField: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: CustomTextField(
                          // onTap: () async {
                          //   final TimeOfDay? pickedTime = await showTimePicker(
                          //     context: context,
                          //     initialTime: TimeOfDay.now(),
                          //   );
                          //   if (pickedTime != null) {
                          //     setState(() {
                          //       pController.timeFromController.text =
                          //           "${pickedTime.hour >= 0 && pickedTime.hour < 10 ? "0${pickedTime.hour}" : pickedTime.hour}:${pickedTime.minute}:00";
                          //     });
                          //   }
                          // },
                          readOnly: true,
                          hintText: 'from_time'.tr,
                          inputType: TextInputType.text,
                          controller: pController.timeFromController,
                        )),
                  ),
                  CustomFieldWithTitle(
                    height: 50,
                    requiredField: true,
                    width: Get.width / 3,
                    title: "to_time".tr,
                    customTextField: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: CustomTextField(
                          // onTap: () async {
                          //   final TimeOfDay? pickedTime = await showTimePicker(
                          //     context: context,
                          //     initialTime: TimeOfDay.now(),
                          //   );
                          //   if (pickedTime != null) {
                          //     setState(() {
                          //       pController.timeToController.text =
                          //           "${pickedTime.hour >= 0 && pickedTime.hour < 10 ? "0${pickedTime.hour}" : pickedTime.hour}:${pickedTime.minute}:00";
                          //     });
                          //   }
                          // },
                          readOnly: true,
                          hintText: 'to_time'.tr,
                          inputType: TextInputType.text,
                          controller: pController.timeToController,
                        )),
                  ), CustomFieldWithTitle(
                    height: 50,
                    requiredField: true,
                    width: Get.width / 3,
                    title: "minutes".tr,
                    customTextField: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: CustomTextField(
                          // onTap: () async {
                          //   final TimeOfDay? pickedTime = await showTimePicker(
                          //     context: context,
                          //     initialTime: TimeOfDay.now(),
                          //   );
                          //   if (pickedTime != null) {
                          //     setState(() {
                          //       pController.timeToController.text =
                          //           "${pickedTime.hour >= 0 && pickedTime.hour < 10 ? "0${pickedTime.hour}" : pickedTime.hour}:${pickedTime.minute}:00";
                          //     });
                          //   }
                          // },
                          readOnly: true,
                          hintText: 'minutes'.tr,
                          inputType: TextInputType.text,
                          controller: pController.minutesController,
                        )),
                  ),
                ],
              ),
              CustomFieldWithTitle(
                requiredField: true,
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
                      controller: pController.detailsController,
                    )),
              ),
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
                      pController.selectSingleFile(pController.fileNameController , "files");
                    },
                    maxLines: 2,
                    readOnly: true,
                    hintText: 'file_add'.tr,
                    inputType: TextInputType.text,
                    controller: pController.fileNameController,
                  ),
                ),
              ),
          pController.isLoading? const Center(child: CircularProgressIndicator(),) :
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: CustomButton(
                  buttonText: "save".tr,
                  onPressed: () {
                    pController.validateFieldsAndShowSnackbar();
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

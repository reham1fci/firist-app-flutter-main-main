import 'package:betakety_app/model/vacation_type.dart';
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

class AddVacationRequest extends StatefulWidget {
  const AddVacationRequest({super.key});

  @override
  State<AddVacationRequest> createState() => AddVacationRequestState();
}

class AddVacationRequestState extends State<AddVacationRequest> {
  @override
  void initState() {
    Get.find<PermissionController>().resetData();
    super.initState();
    Get.find<PermissionController>().getVacationTypes();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PermissionController>(builder: (pController) {
      return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kTitleColor),
          centerTitle: true,
          title: Text(
            'add_vacation'.tr,
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
              child: DropdownButton<VacationType>(
                hint: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Text('type'.tr),
                ),
                value: pController.vacationTypeTemp,
                items: pController.vacationTypeList!.map((value) {
                  return DropdownMenuItem<VacationType>(
                    value: value,
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 9),
                      child: Text(value.nameEn!.tr),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  pController.vacationTypeTemp = value;
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
                    title: 'vacation_place'.tr,
                    customTextField: Container(
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<RequestTypeModel>(
                        hint: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9),
                          child: Text('vacation_place'.tr),
                        ),
                        value: pController.vacationPlaceTemp,
                        items: pController.vacationPlaceList.map((value) {
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
                          pController.vacationPlaceTemp = value;
                          pController.update();
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
              pController.vacationPlaceTemp!.id== 2?
              CustomFieldWithTitle(
                requiredField: true,
                title: "vacation_place".tr,
                customTextField: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: CustomTextField(
                      maxLines: 2,
                      hintText: 'vacation_place'.tr,
                      inputType: TextInputType.text,
                      controller: pController.vacationPlaceController,
                    )),
              ):SizedBox() ,
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
              Row(
                children: [
                  CustomFieldWithTitle(
                    width: Get.width / 2,
                    height: 50,
                    requiredField: true,
                    title: "date_from".tr,
                    customTextField: Container(
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: CustomTextField(
                          onTap: () async {
                            DateTime currentDate = DateTime.now();
                            final DateTime firstDate = DateTime(2023);

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
                                pController.dateFromController.text =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                              });
                            }
                          },
                          readOnly: true,
                          hintText: 'date_from'.tr,
                          inputType: TextInputType.text,
                          controller: pController.dateFromController,
                        )),
                  ),
                  CustomFieldWithTitle(
                    width: Get.width / 2,
                    height: 50,
                    requiredField: true,
                    title: "date_to".tr,
                    customTextField: Container(
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: CustomTextField(
                          onTap: () async {
                            DateTime currentDate = DateTime.now();
                            final DateTime firstDate = DateTime(2023);
                            final DateTime lastDate =
                            currentDate.add(const Duration(days: 30));
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: currentDate,
                              firstDate: firstDate,
                              lastDate: lastDate,
                            );
                            if (pickedDate != null) {
                              setState(() {
                                pController.dateToController.text =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                              });
                            }
                          },
                          readOnly: true,
                          hintText: 'date_to'.tr,
                          inputType: TextInputType.text,
                          controller: pController.dateToController,
                        )),
                  ),
                ],
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
                      pController.selectSingleFile();
                    },
                    maxLines: 2,
                    readOnly: true,
                    hintText: 'file_add'.tr,
                    inputType: TextInputType.text,
                    controller: pController.fileNameController,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: CustomButton(
                  buttonText: "save".tr,
                  onPressed: () {
                    pController.validateVacationAndShowSnackbar();
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

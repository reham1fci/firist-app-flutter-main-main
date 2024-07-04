import 'package:betakety_app/model/vacation_type.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/view/screens/Requests/widget/add_request_item.dart';
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

class AddRequest extends StatefulWidget {
  const AddRequest({super.key});

  @override
  State<AddRequest> createState() => AddRequestState();
}

class AddRequestState extends State<AddRequest> {
  @override
  void initState() {
    Get.find<PermissionController>().resetData();
    super.initState();
    Get.find<PermissionController>().getTypes(AppConstants.getRequestTypes);
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
            'add_request'.tr,
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
                  CustomFieldWithTitle(
                    requiredField: true,

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
                              child: Text(value.nameAr!),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                         // pController.vacationTypeTemp!.options!.clear() ;
                          pController.vacationTypeTemp = value;
                          pController.update();
                        },
                        isExpanded: true,
                        underline: const SizedBox(),
                      ),
                    ),
                  ),
              pController.  vacationTypeList!.isNotEmpty? ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AddRequestItem( index :index ,filteredData:pController.vacationTypeTemp!.options! ) ;
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: pController.vacationTypeTemp!.options!.length):SizedBox(),
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
                      pController.selectSingleFile(pController.fileNameController  , "files");
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
                    pController.validateRequestsAndShowSnackbar(pController.vacationTypeTemp!.options! );
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

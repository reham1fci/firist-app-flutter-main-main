import 'package:betakety_app/controllers/attendance_controller.dart';
import 'package:betakety_app/controllers/delivery_projects_controller.dart';
import 'package:betakety_app/model/day_item.dart';
import 'package:betakety_app/model/project.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:betakety_app/view/base/no_thing_to_show.dart';
import 'package:betakety_app/view/screens/agent_orders/widgets/day_orders_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgentDailyOrderOrderScreen extends StatefulWidget {
  const AgentDailyOrderOrderScreen({super.key});

  @override
  State<AgentDailyOrderOrderScreen> createState() => _AgentDailyOrderOrderScreenState();
}

class _AgentDailyOrderOrderScreenState extends State<AgentDailyOrderOrderScreen> {
  final List<DayItem> days = const [];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<DeliveryProjectController>().resetData();

  }

    // DayItem(
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DeliveryProjectController>(builder: (cController) {
      return Scaffold(
          appBar: AppBar(
            title: Text('daily_confirmation'.tr),
            centerTitle: true,
          ),
          body:
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                            Border.all(color: Theme
                                .of(context)
                                .primaryColor),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: CustomTextField(
                            onTap: () async {
                              DateTime currentDate = DateTime.now();
                              final DateTime firstDate = DateTime(2025);

                              final DateTime lastDate =
                              currentDate.add(const Duration(days: 360));
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: currentDate,
                                firstDate: firstDate,
                                lastDate: lastDate,
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  cController.dateFromController.text =
                                      DateFormat('yyyy-MM-dd').format(
                                          pickedDate);
                                });
                              }
                            },
                            readOnly: true,
                            hintText: 'date_from'.tr,
                            inputType: TextInputType.text,
                            controller: cController.dateFromController,
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
                            Border.all(color: Theme
                                .of(context)
                                .primaryColor),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: CustomTextField(
                            onTap: () async {
                              DateTime currentDate = DateTime.now();
                              final DateTime firstDate = DateTime(2025);
                              final DateTime lastDate =
                              currentDate.add(const Duration(days: 360));
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: currentDate,
                                firstDate: firstDate,
                                lastDate: lastDate,
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  cController.dateToController.text =
                                      DateFormat('yyyy-MM-dd').format(
                                          pickedDate);
                                });
                              }
                            },
                            readOnly: true,
                            hintText: 'date_to'.tr,
                            inputType: TextInputType.text,
                            controller: cController.dateToController,
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(
                      Dimensions.PADDING_SIZE_LARGE),
                  child: CustomButton(
                    buttonText: "load_data".tr,
                    onPressed: () {
                      cController.validateFieldsAndShowSnackbar();
                    },
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                cController.loader ? SizedBox():  cController.totalProject != null ? DayOrdersItem(day:  cController.totalProject! , isTotalProject: true,):SizedBox(),
                const Divider(
                  thickness: 1.0,
                  color: kGreyTextColor,
                ),
                cController.loader ? const CircularProgressIndicator() :
                cController.dailyProjects.isNotEmpty ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount:  cController.dailyProjects.length,
                        itemBuilder: (context, index) {
                          return DayOrdersItem(day:  cController.dailyProjects[index] , isTotalProject: false,);
                        },
                      ),
                    )) : const NoThingToShow(),

              ])
      );
    }
    );
  }
}

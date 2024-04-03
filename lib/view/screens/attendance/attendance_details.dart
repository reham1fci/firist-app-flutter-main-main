import 'package:betakety_app/controllers/attendance_controller.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:betakety_app/view/base/no_thing_to_show.dart';
import 'package:betakety_app/view/screens/attendance/widgets/attendance_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceDetails extends StatefulWidget{
  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {

List<dynamic> filteredData = [] ;
String shift ="empty";
loadData() async {
  shift = await    Get.find<AttendanceController>().getShiftData();

  setState(() {
    shift = shift ;
  });

}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData() ;
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(builder: (cController)
    {
      // TODO: implement build
      return Scaffold(

          backgroundColor: Theme
              .of(context)
              .cardColor,
          // appBar: AppBar(
          //   title: Text("إضافة طلب إذن"),
          // ),

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
            //color: Color.fromARGB(255, 239, 239, 243),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(shift) ,
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
                    const Divider(
                      thickness: 1.0,
                      color: kGreyTextColor,
                    ),
                    cController.loader ? const CircularProgressIndicator() :
                    cController.result ? Expanded(
                      child:Padding(
                        padding: EdgeInsets.only(left: 8 , right: 8),
                        child:  ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return AttendanceItem(index, cController.posts);
                          },
                          itemCount: cController.posts.length),
                    )) : const NoThingToShow(),

                  ])


      );
    }
    );}
}
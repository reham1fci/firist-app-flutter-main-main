import 'package:betakety_app/controllers/account_controller.dart';
import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/salary_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/salary.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:betakety_app/view/base/no_thing_to_show.dart';
import 'package:betakety_app/view/screens/salary_details/widgets/salary_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';


import 'dart:convert';
import 'package:http/http.dart' as http;

class salary_details_view extends StatefulWidget {
  const salary_details_view({Key? key}) : super(key: key);

  @override
  State<salary_details_view> createState() => _salary_details_State();
}

class _salary_details_State extends State<salary_details_view> {

  bool isEmployee  = false;



  @override
  void initState() {

    super.initState();
    checkLoginType()  ;

  }
  checkLoginType()async{

    LoginResponsModel user =  await AuthController().getLoginData()  ;
    if(user.loginType=="office_employee"){
      setState(() {
        isEmployee = true;
      });

    }
  }
  /*List<dynamic> viewdata = [];
  _loadData() async {
    //var data = await getPost();
    if (data != 'error') {
      setState(() {
        viewdata = (data['data'] as List);
      });
    }
    print("1111111111111111111111111111111111111111111111111111111111111");
    print(data);
  }*/

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalaryController>(builder: (pController) {
      return Scaffold(

        backgroundColor: Theme.of(context).cardColor,
        // appBar: AppBar(
        //   title: Text("إضافة طلب إذن"),
        // ),

        appBar: AppBar(
          iconTheme: const IconThemeData(color: kTitleColor),
          centerTitle: true,
          title: Text(
            'view_salary_details'.tr,
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
          //color: Color.fromARGB(255, 239, 239, 243),
          child: Column(
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
              Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                child: CustomButton(
                  buttonText: "load_data".tr,
                  onPressed: () {
                  pController.validateFieldsAndShowSnackbar();
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
           pController.loader ?  const CircularProgressIndicator() :
           pController. result?   Container(
                // width: context.width(),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                        Text(
                          'salary'.tr,
                          style: kTextStyle,
                        ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SalaryDetails(isEmployee,pController.salary!)
                  ],
                ),
              ):const NoThingToShow(),
              const SizedBox(
                height: 20.0,
              ),
              pController. result?  Container(
                // width: context.width(),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'salary_with_allowances'.tr,
                          //style: titilliumRegular,
                        ),
                        const Spacer(),
                        // RichText(
                        //   // text: TextSpan(
                        //   //   children: [
                        //   //     TextSpan(
                        //   //       text: '30 May, 2021 ',
                        //   //       style: kTextStyle.copyWith(
                        //   //         color: kGreyTextColor,
                        //   //       ),
                        //   //     ),
                        //   //   ],
                        //   // ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'basic_salary'.tr,
                                style: titilliumRegular.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Insurance_discount'.tr,
                                style: titilliumRegular.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Total_salary'.tr,
                                style: titilliumRegular.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.0,
                          color: kGreyTextColor,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                pController.salary!.salaryAllowances!,
                                style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                               pController.salary!.insuranceDiscount!,
                                style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
  isEmployee? pController.salary!.salaryAfterInsurance!:   pController.salary!.netSalary!,
                                style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ):SizedBox(),
           /*   const SizedBox(
                height: 20.0,
              ),
            Container(
                // width: context.width(),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Basic Pay222',
                          style: kTextStyle,
                        ),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '30 May, 2023 ',
                                style: kTextStyle.copyWith(
                                  color: kGreyTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Loan',
                                style: kTextStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Extra Bonus',
                                style: kTextStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Total',
                                style: kTextStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 1.0,
                          color: kGreyTextColor,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '\$0.00',
                                style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '\$10.00',
                                style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '\$20.00',
                                style:
                                    kTextStyle.copyWith(color: kGreyTextColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),*/
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      );
    });
  }
}

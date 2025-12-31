import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/view/screens/Requests/all_requests.dart';
import 'package:betakety_app/view/screens/Requests/widget/requests_type_item.dart';
import 'package:betakety_app/view/screens/agent_orders/agent_daily_order_screen.dart';
import 'package:betakety_app/view/screens/agent_orders/monthly_evaluation_screen.dart';
import 'package:betakety_app/view/screens/shipments/shipments_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/styles.dart';
import 'package:betakety_app/util/app_constants.dart' ;

//import 'Navigation Bar/navigation_list.dart';

class TargetType extends StatefulWidget {
  const TargetType({Key? key}) : super(key: key);

  @override
  TargetTypeState createState() => TargetTypeState();
}

class TargetTypeState extends State<TargetType> {
   String? employeeType ;
   final response = {
     "employeeId": "981867",
     "employeeNameAr": "نشوان طه علي الادريسي",
     "employeeNameEn": "Nashwan Taha Ali Al-Idrisi",
     "identityNo": "2315315909",
     "projectName": "مشروع المطاعم",
     "startDate": "01-01-2024",
     "dailyTarget": "250",
     "confirmedDays": "30",
     "unconfirmedDays": "0",
     "offDays": "4",
     "attendanceDays": "28",
     "baseSalary": "2900",
     "dailySalary": "96.67",
     "confirmedSalary": "2900",
     "finalSalary": "2797.62"
   };
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
getUserData() ;
   }
    getUserData() async {
      LoginResponsModel user = await AuthController().getLoginData();
      setState(() {
        employeeType  = user.employeeType  ;

      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
    iconTheme: const IconThemeData(color: kTitleColor),
    centerTitle: true,
    title: Text(
    'target'.tr,
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
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: Get.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  color: Colors.white),
              child:
              Column(
                children: [
                  const SizedBox(height: 20.0),
                  RequestsTypeItem(title:
                  'daily_confirmation'.tr,
                    onTap: (){
                      Get.to(() => AgentDailyOrderOrderScreen());
                    },),
                     RequestsTypeItem(title:
                      'monthly_evaluation'.tr,
                        onTap: (){
                          Get.to(() => MonthlyEvaluationScreen(data: response));                        },)



                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}

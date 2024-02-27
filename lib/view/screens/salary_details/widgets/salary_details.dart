import 'package:betakety_app/model/salary.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/view/screens/salary_details/widgets/row_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SalaryDetails extends StatelessWidget{
  bool isEmployee ;
  Salary salary ;

  SalaryDetails(this.isEmployee , this.salary);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  SingleChildScrollView( child:Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          RowItem(name: "salary_allowances".tr,value: salary.salaryAllowances,) ,
          RowItem(name: "salf_khasm".tr,value: salary.debtDiscount,) ,
          RowItem(name: "ohad_khasm".tr,value: salary.coustdyDiscount,) ,]),
        const SizedBox(
          height: 20.0,
        ),
        isEmployee ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RowItem(name: "discount_hours".tr,value: salary.hourDiscount,) ,
            RowItem(name: "discount_attendance".tr,value: salary.attendanceDiscount,) ,
           RowItem(name: "net_salary".tr,value: salary.netSalary,) ,
          ],
        ):
            Column(children: [
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RowItem(name: "date_commencement".tr,value: salary.startDate,) ,
                  RowItem(name: "count_days".tr,value: salary.countDays,) ,
                RowItem(name: "total_salary".tr,value: salary.totalSalary,) ,
    ]),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RowItem(name: "net_salary".tr,value: salary.netSalary,) ,
                  RowItem(name: "count_days2".tr,value: salary.countDays2,) ,
                RowItem(name: "required_target".tr,value: salary.requiredTarget,) ,
                ],
              ) ,
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RowItem(name: "target_restaurants".tr,value: salary.restaurantsTarget,) ,
                  RowItem(name: "pakage_target".tr,value: salary.packageTarget,) ,
                 RowItem(name: "target_investigator".tr,value: salary.investTarget,) ,

                ],
              ) ,
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RowItem(name: "nesba_mohkak".tr,value: salary.completeRate,) ,
                  RowItem(name: "salary_mostahk".tr,value: salary.salaryDue,) ,
                  RowItem(name: "salary_hafez".tr,value: salary.incentive,) ,

                ],
              ) ,

              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RowItem(name: "chefz_target".tr,value: salary.chefzTarget,) ,
                  RowItem(name: "jahez_target".tr,value: salary.jahezTarget,) ,
                  //RowItem(name: "hanger_target".tr,value: salary.hangerTarget,) ,

                ]
              ) , Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RowItem(name: "days_target".tr,value: salary.daysTarget,) ,

                ]
              ) ,
            ],)

      ])
      )

    ;
  }

}
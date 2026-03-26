import 'package:betakety_app/controllers/delivery_projects_controller.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/project.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/no_thing_to_show.dart';
import 'package:betakety_app/view/screens/agent_orders/widgets/monthly_evaluation_card.dart';
import 'package:betakety_app/view/screens/agent_orders/widgets/table_cell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/dimensions.dart';
import 'widgets/card_row.dart';

class MonthlyEvaluationScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const MonthlyEvaluationScreen({super.key, required this.data});

  @override
  State<MonthlyEvaluationScreen> createState() => _MonthlyEvaluationScreenState();
}

class _MonthlyEvaluationScreenState extends State<MonthlyEvaluationScreen> {
  final List<String> months = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
  ];
  String? path ;

  final List<int> years = List.generate(
      2028 - 2016 + 1, (index) => 2016 + index);

String selectedMonth = "1";
String selectedYear = "2025";
  LoginResponsModel?     employee  ;
  Project?     project  ;
  bool loading = false  ;
  var data;
  var attendanceData;
  var salaryData;
  var targetData;
  var exceptionData;
  var  periodData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text("monthly_evaluation".tr, style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                monthView(
                  "month",
                  selectedMonth,
                  months,
                      (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
                ),
                monthView(
                  "year",
                  selectedYear,
                  years.map((e) => e.toString()).toList(),
                      (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                ),

            ],),
            Padding(
              padding: const EdgeInsets.all(
                  Dimensions.PADDING_SIZE_LARGE),
              child: CustomButton(
                buttonText: "load_data".tr,
                onPressed: ()  async {
                   setState(() {
                     loading = true  ;
                   });
                   print(selectedYear) ;
                   print(selectedMonth) ;
                   data= await Get.find<DeliveryProjectController>().getMonthlyData(selectedMonth, selectedYear) ;
                   var employeeData = data["employee_info"] ;
                   var projectData = data["project_info"] ;
                   attendanceData = data["attendance_info"] ;
                    salaryData = data["salary_info"] ;
                    targetData = data["target_info"] ;
                   exceptionData = data["exception_info"] ;
                   periodData = data["period_info"] ;
                   print(periodData.toString()) ;
                    setState(()  {

                      employee = LoginResponsModel.employeeInfo(employeeData) ;
                      project = Project.fromJson2(projectData) ;
                      loading = false  ;
                    });


           print(data.toString()) ;
                },
              ),
            ),
      Get.find<DeliveryProjectController>().loader?const Center(child: CircularProgressIndicator(),):
      data!=null?Expanded(child: SingleChildScrollView(
        //  padding: const EdgeInsets.all(12),
          child: Column(
            children: [
            MonthlyEvaluationCard(
              title:"employee_data",
              children: [
                CardRow("employee_id", employee!.id.toString()),
                CardRow("arabic_name", employee!.nameAr!),
                CardRow("english_name", employee!.nameEn!),
                CardRow("identity_no",employee!.idenetityId),
              ],
            ),

            MonthlyEvaluationCard(
              title: "project_data",
              children: [
                CardRow("project_name", project!.nameAr),
                CardRow("start_date", project!.startDate),
                CardRow("project_target",project!.projectTarget),
                CardRow("employee_target",project!.employeeTarget),
              ],
            ),

            MonthlyEvaluationCard(
              title: "attendance",
              children: [
                CardRow("confirmed_days",attendanceData["confirmed_days"]),
                CardRow("unconfirmed_days",attendanceData["unconfirmed_days"]),
                CardRow("attendance_days",attendanceData["presence_days"]),
                CardRow("off_days", attendanceData["off_days"]),
                CardRow("net_presence_days", attendanceData["net_presence_days"]),
                CardRow("net_salary_days",attendanceData["net_salary_days"]),
              ],
            ),

            MonthlyEvaluationCard(
              title: "salary",
              children: [
                CardRow("total_salary", salaryData['total_salary']),
                CardRow("daily_salary", salaryData['daily_salary']),
                CardRow("confirmed_salary", salaryData['confirmed_salary']),
                CardRow("deserved_salary", salaryData['salary_deserved']),

              ],
            ),
              MonthlyEvaluationCard(
                title: "targets",
                children: [
                //   CardRow("target_days", targetData['target_days']),
                //   CardRow("project_target", targetData['target_required']),
                //   CardRow("employee_target", targetData['target_achieved']),
                // //  CardRow("target_percentage", targetData['target_percentage']),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CardRow("target_required", targetData['target_required']),
                            CardRow("target_achieved", targetData['target_achieved']),
                            CardRow("target_days", targetData['target_days']),
                          ],
                        ),
                      ),
                      targetCircleChart( targetData['target_percentage'].toDouble()),
                    ],
                  ),

                ],
              ),
              MonthlyEvaluationCard(
                title: "absence",
                children: [
                  CardRow(
                    "calculated_absence_days",
                    data['absence_info']['calculated_absence_days'],
                  ),
                ],
              ),
              MonthlyEvaluationCard(
                title: "exceptions",
                children: [
                  _exceptionsSummary(exceptionData),
                  const SizedBox(height: 12),
                  _exceptionsTable(exceptionData['exception_details']),
                  //CardRow("total_exception_days", exceptionData['total_exception_days']),
                 // CardRow("pending_exceptions", exceptionData['pending_exceptions']),
                 // CardRow("approved_exceptions", exceptionData['approved_exceptions']),
                 // CardRow("rejected_exceptions", exceptionData['rejected_exceptions']),
                ],
              ),
              MonthlyEvaluationCard(
                title: "period"
                ,
                children: [
                  CardRow("year", periodData['year']),
                  CardRow("month", periodData['month']),
                  CardRow("month_days", periodData['month_days']),
                  CardRow(
                    "",
                    periodData['is_monthly_confirmed'] ? "monthly_confirmed".tr : "monthly_unconfirmed".tr
                  ),
                ],
              ),
              if ((periodData['unconfirmed_dates'] as List).isNotEmpty)
                MonthlyEvaluationCard(
                  title: "unconfirmed_dates",
                  children: (periodData['unconfirmed_dates'] as List)
                      .map(
                        (date) => CardRow(
                      "date",
                      date,
                    ),
                  )
                      .toList(),
                ),


            ],
        ),
      )):NoThingToShow(),
        ]))
    );
  }
  Widget _exceptionsTable(List list) {
    if (list.isEmpty) {
      return Center(
        child: Text(""),
      );
    }

    return Column(
      children: [
        _tableHeader(),
        const Divider(),
        ...List.generate(list.length, (index) {
          final item = list[index];
          return _tableRow(
            index + 1,
            item['date'],
            item['type'],
            item['status'],
            item['reason'],
          );
        }),
      ],
    );
  }
  Widget _tableHeader() {
    return Row(
      children:  [
        TableCell2(text: "#", flex: 1, isHeader: true,),
        TableCell2(text: "date", flex: 3, isHeader: true),
        TableCell2(text: "type", flex: 3, isHeader: true, ),
        TableCell2(text: "status", flex: 3, isHeader: true),
        TableCell2(text: "reason", flex: 4, isHeader: true),
      ],
    );
  }
  Widget _tableRow(
      int index,
      String date,
      String type,
      String status,
      String reason,
      ) {
    return Row(
      children: [
        TableCell2(text: index.toString(), flex: 1),
        TableCell2(text: date, flex: 3),
        TableCell2(text: type, flex: 3),
        TableCell2(text: status, flex: 3),
        TableCell2(text: reason, flex: 4),
      ],
    );
  }

  Widget _exceptionsSummary(Map data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _summaryItem("approved_exceptions", data['approved_exceptions']),
        _summaryItem("rejected_exceptions", data['rejected_exceptions']),
        _summaryItem("pending_exceptions", data['pending_exceptions']),
      ],
    );
  }

  Widget _summaryItem(String title, dynamic value) {
    return Column(
      children: [
        Text(value.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(title.tr, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget monthView(
      String title,
      String selectedValue,
      List<String> list,
      Function(String) onChangedValue,
      ) {
    return CustomFieldWithTitle(
      requiredField: true,
      title: title.tr,
      customTextField: Container(
        width: MediaQuery.of(context).size.width / 2.4,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: DropdownButton<String>(
          value: selectedValue.isEmpty ? null : selectedValue,
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(title.tr),
          ),
          isExpanded: true,
          underline: const SizedBox(),
          items: list.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: (value) => onChangedValue(value!),
        ),
      ),
    );
  }
  Widget targetCircleChart(double percentage) {
    return SizedBox(
       width: 120,
      height: 120,
      child: Column(
        //alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percentage / 100,
            strokeWidth: 10,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(
              Colors.green,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${percentage.toStringAsFixed(2)}%",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "target_percentage".tr,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }


}
import 'package:betakety_app/controllers/localization_controller.dart';
import 'package:betakety_app/model/project.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectItem extends StatelessWidget {
  final Project project;
   ProjectItem({required this.project, super.key});
  bool loader = false;
  Locale? myLocale  ;
  Color _colorForName(String name) {
    // تقدر تغير الألوان حسب الاسم
    if (name.contains('هنجر')) return Colors.orange;
    if (name.contains('جاهز')) return Colors.red;
    if (name.contains('شفز')) return Colors.purple;
    if (name.contains('طرود')) return Colors.blue.shade900;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorForName(project.projectName!);
    myLocale= Get.find<LocalizationController>().locale;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10), child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
            myLocale!.countryCode=="en"? project.projectName! : project.nameAr!,
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w600,color: color ),
            ),
          ),

   //       SizedBox(width: 8,),
          SizedBox(
            width: 80,
            child: Text(project.orderCount == 0 ? '-' : project.orderCount.toString(), textAlign: TextAlign.center),
          ),
          SizedBox(width: 8,),

          // سعر التوصيل
          SizedBox(
            width: 80,
            child: Text(
              project.totalPrice! == 0 ? '0' : project.totalPrice.toString(),
              textAlign: TextAlign.center,
            ),
          ),

          // عدد الطلبات


          // اسم المشروع (ممتد لليمين)
          SizedBox(
            width: 70,
            height: 30,
            child: CustomButton(
              buttonColor:  Color.fromARGB(
                  255, 204, 210, 215),
              buttonText: "details".tr,
              textColor: Colors.black,
              isClear: true,
              onPressed: () {
                // هنا تروحي لصفحة التفاصيل
              },
            ),
          ),
        ],
      ),

        const SizedBox(height: 6),

        // ---- السطر الإضافي (زيادة - خصم - بونص) ----
        Row(
          children: [
            SizedBox(width: 80,),
            _infoTag("${"credit2".tr}↑", project.credit!, Colors.green),
            const SizedBox(width: 10),
            _infoTag("${"debit".tr}↓", project.debit!, Colors.red),
            const SizedBox(width: 10),
            _infoTag("${"bonus".tr}⭐", project.bonus!, Colors.orange),
          ],
        ) ,

        ],
      ),
    );
  }
  Widget _infoTag(String label, String value, Color iconColor) {
    return Row(
      children: [
        Icon(Icons.circle, size: 6, color: iconColor),
        const SizedBox(width: 4),
        Text(
          "$label: $value",
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:betakety_app/model/vacation.dart';
import 'package:betakety_app/view/base/color_resources.dart';
import 'package:get/get.dart';

class VacationPopup extends StatelessWidget {
  final Vacation vacation;
  String message   ;

   VacationPopup({
    super.key,
    required this.vacation,
   required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 Header
            Row(
              children: [
                const Icon(Icons.beach_access,
                    color: ColorResources.primaryColor),
                const SizedBox(width: 8),
                 Text(
                  "vacation_details".tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),

            const SizedBox(height: 12),
            Text(message) ,
            SizedBox(height: 8),
            _sectionTitle("عدد الأيام المطلوبة"),
            _infoCard("${vacation.daysRequested} يوم"),

            const SizedBox(height: 12),

            _sectionTitle("تقسيم الأيام"),
            Row(
              children: [
                _smallCard("paid".tr, vacation.paidDays),
                _smallCard("unpaid".tr, vacation.unPaidDays),
                _smallCard("total".tr, vacation.totalDays),
              ],
            ),

            const SizedBox(height: 12),

            _sectionTitle("الرصيد"),
            Row(
              children: [
                _smallCard("paid_balance".tr, vacation.paidBalance),
                _smallCard("unpaid".tr, vacation.unPaidBalance),
                _smallCard("total".tr, vacation.totalBalance),
              ],
            ),

            const SizedBox(height: 12),

            _sectionTitle("travel_ticket".tr),
            _infoRow(vacation.travelTicketText ?? "-"),

            const SizedBox(height: 8),
            _sectionTitle("restart_work".tr),
            _infoRow(vacation.restartWork == true ? "yes".tr : "no".tr),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorResources.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child:  Text("close".tr ,style:  TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Helpers
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: ColorResources.primaryColor,
        ),
      ),
    );
  }

  Widget _infoCard(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: _boxDecoration(),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _smallCard(String title, dynamic value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(10),
        decoration: _boxDecoration(),
        child: Column(
          children: [
            Text(
              value?.toString() ?? "-",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: _boxDecoration(),
      child: Text(text),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}

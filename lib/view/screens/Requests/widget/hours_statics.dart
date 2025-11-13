
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HoursStatics extends StatelessWidget{
   String remaining  ;
   String required  ;
   String allowed  ;
   HoursStatics({super.key , required this.remaining , required this.required , required this.allowed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("hours_allow".tr, allowed),
          _buildStatItem("hours_required".tr, required),
          _buildStatItem("hours_remaining".tr, remaining),
        ],
      ),
    ) ;


  }
  Widget _buildStatItem(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
        SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
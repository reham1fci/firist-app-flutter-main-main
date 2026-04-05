import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardItem extends StatelessWidget {
   String? icon;
   String? title;
   String? count;
   RewardItem({this.icon,this.title,this.count});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
    //  padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xfff8f8f8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [

          Container(
            //padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xfffdecec),
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Image.asset(
              icon!,
              height: 50,
             // fit:title== "wait"?BoxFit.contain :BoxFit.cover,
              width: double.infinity,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title!.tr,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,

            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 4),

          Text(
            count!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }  }
  

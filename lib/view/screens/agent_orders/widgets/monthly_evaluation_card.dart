
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyEvaluationCard  extends StatelessWidget{
  final String title ;
  final List<Widget> children ;
  const MonthlyEvaluationCard({required this.title, required this.children, super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.only(bottom: 14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.tr,
                  style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold , color: Theme.of(context).primaryColor)),
              const Divider(),
              ...children,
            ],
          ),
        ),
      );
  }
  
}
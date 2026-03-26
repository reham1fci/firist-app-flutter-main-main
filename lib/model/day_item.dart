import 'package:betakety_app/model/project.dart';
import 'package:get/get.dart';

class DayItem {
   String? dateLabel;
   String? total;
   List<Project>? projects;
    bool? confirmed  ;
    String? exceptionAr  ;
    String? exceptionEn  ;
   DayItem({ this.dateLabel,  this.projects ,this.total , this.confirmed , this.exceptionAr, this.exceptionEn});
  factory DayItem.fromJson(Map<String, dynamic> json) {
    var dataArr =  json["projects"] as List;
     print(json["confirmation_status"]) ;
     print(json["exception_status"]) ;
    return DayItem(
        dateLabel: json["date"] ,
        exceptionAr: (json["exception_status_ar"] ?? "").toString(),
        exceptionEn: (json["exception_status"] ?? "").toString(),
        confirmed:json["confirmation_status"] == "confirmed" ? true : false ,
        total: json["day_total_price"].toString() ,
     projects:dataArr.map((e) => Project.fromJson(e)).toList());
   }  factory DayItem.fromJsonTotal(Map<String, dynamic> json) {
    var dataArr =  json["projects"] as List;
    return DayItem(total: json["total_delivery_amount_t"].toString() ,
     dateLabel: "total_project".tr,
     projects:dataArr.map((e) => Project.fromJson(e)).toList());
   }
}

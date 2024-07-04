import 'package:betakety_app/model/request_options.dart';

class VacationType{
  String? nameAr ;
  String? nameEn ;
  String? Id ;
  List<dynamic>? options  ;

  VacationType({this.nameAr, this.nameEn, this.Id , this.options});

  factory VacationType.fromJson(Map<String, dynamic> json){
    return VacationType (
        nameAr: json["vacation_name_ar"] ,
        nameEn: json["vacation_name_en"],
        Id: json["vacations_type_id"] ,

    ); }
  factory VacationType.fromJsonRequests(Map<String, dynamic> json){
    return VacationType (
        nameAr: json["type_name_ar"] ,
        nameEn: json["type_name_en"],
        Id: json["request_type_id"] ,
      options: json["option"] as List


    );

  }



}
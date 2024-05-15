class VacationType{
  String? nameAr ;
  String? nameEn ;
  String? vacationId ;

  VacationType({this.nameAr, this.nameEn, this.vacationId});

  factory VacationType.fromJson(Map<String, dynamic> json){
    return VacationType (
        nameAr: json["vacation_name_ar"] ,
        nameEn: json["vacation_name_en"],
        vacationId: json["vacations_type_id"] ,

    ); }

}
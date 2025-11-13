

import '../util/app_constants.dart';

class Questions {
  String? date;
  String?  type  ;
  String? status  ;
  String? reply  ;
  String? attendance  ;
  String? withdrawal  ;
  String? attachment  ;

  Questions({this.date, this.type, this.status,this.reply  , this.attendance  , this.withdrawal , this.attachment});
  factory Questions.fromJson(Map<String, dynamic> json ,){
    return Questions (
      date: json["hr_question_date"] ,
      type: json["hr_question_type"],
      attendance: json["hodor_time"],
      withdrawal: json["ensraf_time"],
      status: json["question_stat"]??AppConstants.pending,
      reply: json["employee_reply"],
      attachment: json["attach_link"],
    ); }
}


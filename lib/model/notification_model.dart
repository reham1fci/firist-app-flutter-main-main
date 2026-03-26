import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/app_constants.dart';

class NotificationModel {
  final int id;
  final String title;
  final String body;
  String? type; //

  final String iconAsset;
  final DateTime date;
  bool? isSeen;


  NotificationModel({
    this.type,
    required this.id,
    required this.title,
    required this.body,
    required  this.iconAsset,
    this.isSeen = false,
    required this.date,
  });

  NotificationModel copyWith({int? id, String? title, String? body, DateTime? date}) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      date: date ?? this.date,
      iconAsset: "assets/image/hr_logo.png",
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'date': date.toIso8601String(),
  };

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    SharedPreferences sharedPreferences = Get.find();
    String languageCode =
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'ar';
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type:languageCode=="en" ? json['notification_type_en'] : json['notification_type_ar'],
      isSeen: json['status']== "read"?true:false,
      date: DateTime.parse(json['sent_at'],
      ), iconAsset: "assets/image/hr_logo.png",
    );
  }
}

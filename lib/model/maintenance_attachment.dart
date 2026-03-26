class MaintenanceAttachment  {

  String? name  ;
  String? link  ;
  String? type  ;

  MaintenanceAttachment({required this.name, required this.link, required this.type});


  factory MaintenanceAttachment.fromJson(Map<String, dynamic> json) {
     return MaintenanceAttachment(
    link : json['link'],
    type : json['type'],
    name : json['name'],
     );
  }
}
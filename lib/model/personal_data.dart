class PersonalData{
  String? name ;
  String? status ;
  String? type ;
  String? dataType ;

  PersonalData({this.name, this.status, this.type , this.dataType});
  PersonalData.fromJson(Map<String, dynamic> json) {
    name = json['description'];
    status = json['status'];
    type = json['type'];
    dataType= json['data_type'];
  }
}
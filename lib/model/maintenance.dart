class Maintenance {
  double? lat  ;
  double? lng  ;
  double? cost  ;
  String? details  ;

  Maintenance({this.lat, this.lng , this.cost , this.details});
  Map<String, dynamic> maintenanceToJson(String userId ) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = userId;
    data['lat'] = lat;
    data['lng'] = lng;
    data['amount'] = cost;
    data['details'] = details;
    return data;
  }


}
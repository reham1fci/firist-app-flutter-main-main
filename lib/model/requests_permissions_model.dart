class RequestsPermissionsModel {
  bool? success;
  String? requestPerType;
  String? requestId;
  String? requestType;
  String? requestPerDetails;
  String? requestPerDate;
  String? requestPerTimeFrom;
  String? requestPerTimeTo;
  String? requestPerStat;
  String? updateDateTime;
  String? updateUserId;
  String? theReason;
  String? addUserId;
  String? createdDateTime;
  List<AttatchementModel>? attatchement;

  RequestsPermissionsModel(
      {this.success,
      this.requestId,
      this.requestPerType,
      this.requestType,
      this.requestPerDetails,
      this.requestPerDate,
      this.requestPerTimeFrom,
      this.requestPerTimeTo,
      this.requestPerStat,
      this.updateDateTime,
      this.updateUserId,
      this.theReason,
      this.addUserId,
      this.createdDateTime,
      this.attatchement});

  RequestsPermissionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    requestId = json['request_id'];
    requestPerType = json['request_per_type'];
    requestType = json['request_type'];
    requestPerDetails = json['request_per_details'];
    requestPerDate = json['request_per_date'];
    requestPerTimeFrom = json['request_per_time_from'];
    requestPerTimeTo = json['request_per_time_to'];
    requestPerStat = json['request_per_stat'];
    updateDateTime = json['updateDate_Time'];
    updateUserId = json['update_user_id'];
    theReason = json['the_reason'];
    addUserId = json['add_user_id'];
    createdDateTime = json['createdDate_Time'];
    if (json['attatchement'] != null) {
      attatchement = <AttatchementModel>[];
      json['attatchement'].forEach((v) {
        attatchement!.add(AttatchementModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['requestId'] = requestId;
    data['request_per_type'] = requestPerType;
    data['request_type'] = requestType;
    data['request_per_details'] = requestPerDetails;
    data['request_per_date'] = requestPerDate;
    data['request_per_time_from'] = requestPerTimeFrom;
    data['request_per_time_to'] = requestPerTimeTo;
    data['request_per_stat'] = requestPerStat;
    data['updateDate_Time'] = updateDateTime;
    data['update_user_id'] = updateUserId;
    data['the_reason'] = theReason;
    data['add_user_id'] = addUserId;
    data['createdDate_Time'] = createdDateTime;
    if (attatchement != null) {
      data['attatchement'] = attatchement!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttatchementModel {
  String? attachLink;
  String? attachId;
  String? attName;

  AttatchementModel({this.attachLink, this.attachId, this.attName});

  AttatchementModel.fromJson(Map<String, dynamic> json) {
    attachLink = "hgf";
    //json['attach_link'];
    attachId = json['attach_id'];
    attName = json['att_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attach_link'] = attachLink;
    data['attach_id'] = attachId;
    data['att_name'] = attName;
    return data;
  }
}

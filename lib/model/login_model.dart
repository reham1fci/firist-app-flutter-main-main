class LoginReqModel {
  String? username;
  String? password;
  String? name;

  LoginReqModel({this.username, this.password, this.name = "sadam"});

  LoginReqModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    //data['name'] = name;
    return data;
  }
}

class LoginResponsModel {
  bool? success;
  String? message;
  String? id;
  String? name;
  String? email;
  String? mobilenumber;
  String? photo;
  String? nameen;
  String? companynamear;
  String? companynameen;
  String? deptname;
  String? deptnameen;
  String? jobname;
  String? jobnameen;

  LoginResponsModel(
      {this.success,
      this.message,
      this.id,
      this.name,
      this.email,
      this.mobilenumber,
      this.photo,
      this.nameen,
      this.companynamear,
      this.companynameen,
      this.deptname,
      this.deptnameen,
      this.jobname,
      this.jobnameen});

  LoginResponsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobilenumber = json['mobilenumber'];
    photo = json['photo'];
    nameen = json['nameen'];
    companynamear = json['companynamear'];
    companynameen = json['companynameen'];
    deptname = json['deptname'];
    deptnameen = json['deptnameen'];
    jobname = json['jobname'];
    jobnameen = json['jobnameen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobilenumber'] = mobilenumber;
    data['photo'] = photo;
    data['nameen'] = nameen;
    data['companynamear'] = companynamear;
    data['companynameen'] = companynameen;
    data['deptname'] = deptname;
    data['deptnameen'] = deptnameen;
    data['jobname'] = jobname;
    data['jobnameen'] = jobnameen;
    return data;
  }
}


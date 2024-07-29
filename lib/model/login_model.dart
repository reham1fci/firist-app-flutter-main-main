class LoginReqModel {
  String? username;
  String? password;
  String? name;
  String? mobileMac ;

  LoginReqModel({this.username, this.password, this.name ,this.mobileMac});

  LoginReqModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['mac_address'] = mobileMac;
    return data;
  }
}

class LoginResponsModel {
  bool? success;
  String? message;
  String? id;
  String? name;
  String? userName;
  String? nameAr;
  String? nameEn;
  String? email;
  String? password;
  String? mobilenumber;
  String? photo;
  String? nameen;
  String? companynamear;
  String? companynameen;
  String? deptname;
  String? deptnameen;
  String? jobname;
  String? loginType;
  String? jobnameen;
  String? mobileMac;
  String? passwordFingerprint;
  String? companyLat ;
  String? companyLng ;
  String? companyId ;
  String? appleDelete ;

  LoginResponsModel(
      {this.success,
      this.message,
      this.id,
      this.name,
        this.password ,
        this.nameAr,
        this.nameEn,
        this.userName ,
      this.email,
      this.mobilenumber,
      this.photo,
      this.nameen,
      this.companynamear,
      this.companynameen,
      this.deptname,
      this.deptnameen,
      this.jobname,
        this.mobileMac ,
        this.companyLat ,
        this.companyLng,
        this.companyId,
        this.appleDelete  ,
        this.passwordFingerprint ,
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
    loginType = json['office_employ'];
    mobileMac = json['mac_address'];
    companyLng = json['company_lng'];
    companyLat = json['company_lat'];
    companyId= json['company_id'];
    passwordFingerprint= json['password_q'];
    appleDelete= json['apple_delete'];
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
    data['office_employ'] = loginType;
    data['company_lat'] = companyLat;
    data['company_lng'] = companyLng;
    data['mac_address'] = mobileMac;
    data['company_id'] = companyId;
    data['password_q'] = passwordFingerprint;
    data['apple_delete'] = appleDelete;
    return data;
  }
  Map<String, dynamic> signUpToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['employ_name_en'] = nameEn;
    data['employ_name_ar'] = nameAr;
    data['employ_email'] = email;
    data['mobile_number'] = mobilenumber;
    data['password'] =password ;
    data['username'] = userName;

    return data;
  }
}


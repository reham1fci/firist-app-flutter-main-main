class RequestOption {
  String? nameAr;

  String? nameEn;

  String? id;

  String? required;

  String? type;

  RequestOption({this.nameAr, this.nameEn, this.id, this.required, this.type});

  factory RequestOption.fromJson(Map<String, dynamic> json){
    return RequestOption(
      nameAr: json["option_name_ar"],
      nameEn: json["option_name_en"],
      id: json["update_options_id"],
      required: json["required_type"],
      type: json["value_type"],

    );
  }
}
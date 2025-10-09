
import 'dart:ui';

import 'package:intl/intl.dart';

class Shipment {

  String? image;
  String? requestType;
  String? requestTypeKey;
  String? date;
  String? details;
  double? price;
  String? city;
  String? fromCity;
  String? toCity;
  String? toPort;
  String? fromPort;
  String? port;
  String? policy;
  String? refNum;
  String? requestState;
  String? requestId;
  String? id;
  String? quoteStat;
  Color? textColor;
  String? stop;
  String? stateTxt;
  String? company;
  String? changeState;
  String? state;
  List<Updates>? updatesList  ;

  List<Attachment>? attachmentsLinks;

  List<PriceOffer>? priceOfferList;

  int? total;
  int? active;

  int? processing;

  int? cancel;

  Shipment(
  {this.image,
  this.requestType,
  this.fromCity,
  this.requestTypeKey,
  this.priceOfferList,
  this.fromPort,
  this.date,
  this.details,
  this.price,
  this.company,
  this.city,
  this.requestState,
  this.textColor,
  this.id,
  this.quoteStat,
  this.updatesList,
  this.requestId,
  this.stop,
  this.port,
  this.toPort,
  this.toCity,
  this.refNum,
  this.policy,
  this.attachmentsLinks,
  this.cancel,
  this.processing,
  this.active,
  this.changeState ,this.stateTxt ,
  this.total});

  factory Shipment.fromJson(Map<String, dynamic> json , {String? languageCode}){
  String dateTimeString =  json["createdDate_Time"] ;

  // Parse the string to DateTime
  DateTime dateTime = DateTime.parse(dateTimeString);
  List<Updates>? updatesListTemp  =  [] ;

  // Format to extract the date part
  String dateOnly = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  if (json['updates'] != null) {
  json['updates'].forEach((v) {


  updatesListTemp.add(Updates.fromJson(v));
  }); }
  return Shipment (

  requestType: languageCode=="ar"?json["request_type_ar"] : json["request_type"],
  requestTypeKey: json["request_type"],
  requestId: json["request_id"],
  requestState: json["request_stat"] ,
  details: json["request_details"] ,
  date:dateOnly,
  city: json["city_id"],
  fromCity:languageCode=="ar"?json["city_name_from_ar"] : json["city_name_from_en"],
  fromPort:languageCode=="ar"?json["port_name_from_ar"] :  json["port_name_from_en"],
  toPort:languageCode=="ar"?json["port_name_to_ar"] : json["port_name_to_en"],
  toCity:languageCode=="ar"?json["city_name_to_ar"] :  json["city_name_to_en"],
  policy:json["Policy_number"],
  stop: json["stop"],
  stateTxt: json["stat_req"],
  updatesList: updatesListTemp
  );

  }
  factory Shipment.fromJsonDetails(Map<String, dynamic> json){
  List<Updates>? updatesListTemp  =  [] ;
  List<PriceOffer>? priceOffersList = [];
  List<Attachment>? attachments = [];

  if (json['updates'] != null) {
  json['updates'].forEach((v) {


  updatesListTemp.add(Updates.fromJson(v));
  }); }
  if (json['quote_chat'] != null) {
  json['quote_chat'].forEach((v) {
  priceOffersList.add(PriceOffer.fromJson(v));
  });
  }

  if (json['request_attachement'] != null) {
  json['request_attachement'].forEach((v) {
  // Check if the 'file_attachement' exists and is not null or empty
  var fileAttachment = v["file_attachement"];
  if (fileAttachment != null && fileAttachment.isNotEmpty) {
  attachments.add(Attachment.fromJson(v));
  }
  });
  }

  return Shipment (
  requestType: json["request_type"] ,
  requestId: json["request_id"],
  requestState: json["request_stat"] ,
  details: json["request_details"] ,
  date: json["createdDate_Time"] ,
  city: json["city_id"],
  stop: json["stop"],
  changeState: json["change_stat"] ,
  updatesList: updatesListTemp ,
  attachmentsLinks: attachments,
  priceOfferList: priceOffersList);
  }
  Map<String, dynamic> toJson({bool reject = false, String? rejectReason}) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = id;
  if (reject) {
  data['details'] = rejectReason;
  } else {
  data['request_id'] = requestId;
  }
  return data;
  }

  Map<String, dynamic> shipmentToJson(String userId , String mangerId ,   List<String> fileNameList) {
  final Map<String, dynamic> data = <String, dynamic>{};

  data['user_id_top_manager'] = mangerId;
  data['id'] = userId;
  data['shipment_type'] = requestType;
  data['Policy_number'] = policy;
  data['reference_number'] = refNum;
  data['city_id'] = city;
  // data['company_id'] = company;
  data['customer_id'] = company;
  data['port_id'] = port;
  data['city_id_to'] = toCity;
  data['port_id_to'] =toPort ;
  data['request_details'] = details;
  for (int i = 0; i < fileNameList.length; i++) {
  data['file_name[$i]'] = fileNameList[i];
  }
  return data;
  }


  Map<String, dynamic> transportToJson(String userId , String mangerId ,  List<String> fileNameList) {
  final Map<String, dynamic> data = <String, dynamic>{};

  data['user_id_top_manager'] = mangerId;
  data['id'] = userId;
  data['reference_number'] = refNum;
  data['city_id'] = city;
  data['city_id_to'] = toCity;
  data['request_details'] = details;
  for (int i = 0; i < fileNameList.length; i++) {
  data['file_name[$i]'] = fileNameList[i];
  }
  return data;
  }

  Map<String, dynamic> addPriceOfferToJson(
  String mangerId, List<String> fileNameList) {
  final Map<String, dynamic> data = <String, dynamic>{};

  data['user_id_top_manager'] = mangerId;
  data['request_type'] = requestType;
  data['id'] = company;
  data['request_details'] = details;
  //data['file_name'] = fileNameList;
  for (int i = 0; i < fileNameList.length; i++) {
  data['file_name[$i]'] = fileNameList[i];
  }
  return data;
  }


  Map<String, dynamic> dgrToJson(String userId , String mangerId , List<String> fileNameList) {
  final Map<String, dynamic> data = <String, dynamic>{};

  data['user_id_top_manager'] = mangerId;
  data['id'] = userId;
  data['Policy_number'] = policy;
  data['city_id'] = city;
  data['port_id'] = port;
  data['request_details'] = details;
  for (int i = 0; i < fileNameList.length; i++) {
  data['file_name[$i]'] = fileNameList[i];
  }
  return data;
  }

  Map<String, dynamic> clearanceToJson(String userId , String mangerId ,  List<String> fileNameList) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['user_id_top_manager'] = mangerId;
  data['id'] = userId;
  data['Policy_number'] = policy;
  data['city_id'] = city;
  data['port_id'] = port;
  data['request_details'] = details;
  for (int i = 0; i < fileNameList.length; i++) {
  data['file_name[$i]'] = fileNameList[i];
  }
  return data;
  }


  }

  class PriceOffer {
  String? requestId;
  String? id;
  String? quoteStat;
  String? messages;
  double? price;
  List<Attachment>? files;

  String? date;

  PriceOffer(
  {this.requestId,
  this.id,
  this.quoteStat,
  this.messages,
  this.price,
  this.files,
  this.date});

  factory PriceOffer.fromJson(Map<String, dynamic> json) {
  List<Attachment>? attachments = [];

  if (json['files'] != null) {
  json['files'].forEach((v) {
  attachments.add(Attachment.fromJson2(v));
  // Check if the 'file_attachement' exists and is not null or empty
  });
  }

  return PriceOffer(
  messages: json["message"],
  requestId: json["request_id"],
  id: json["id"],
  quoteStat: json["quote_stat"],
  price: double.parse(json["price"]),
  date: json["createdDate_Time"],
  files: attachments);
  }
  }
  class Updates {
  String? date  ;
  String? time  ;
  String? createdDate  ;
  String? name  ;
  String? nameEn  ;
  String? details  ;
  String? detailsEn  ;

  List<OptionUpdates>? optionUpdatesList  ;

  Updates({this.date, this.name, this.details , this.createdDate , this.time , this.optionUpdatesList , this.nameEn , this.detailsEn});

  factory Updates.fromJson(Map<String, dynamic> json){
  DateTime dateTime = DateTime.parse(json["createdDate_Time"]);

  // Format the date separately
  String date = DateFormat('yyyy-MM-dd').format(dateTime);

  // Format the time separately
  String time = DateFormat('HH:mm:ss').format(dateTime);
  List<OptionUpdates> listTemp  = [];
  if (json['updates_option'] != null) {
  json['updates_option'].forEach((v) {
  listTemp.add(OptionUpdates.fromJson(v));
  }); }

  return Updates (
  createdDate: json["createdDate_Time"] ,
  name: json["step_name_ar"],
  nameEn: json["step_name_en"],
  details: json["update_details"] ,
  detailsEn: json["update_details"] ,
  date: date ,
  time: time ,
  optionUpdatesList: listTemp

  );

  }

  }
  class OptionUpdates{
  String? optionName  ;
  String? optionId  ;
  String? optionType  ;
  String? optionValue;

  OptionUpdates({
  this.optionName, this.optionId, this.optionType, this.optionValue});

  factory OptionUpdates.fromJson(Map<String, dynamic> json){
  return OptionUpdates (
  optionId: json["update_id"] ,
  optionName: json["option_name_ar"],
  optionType: json["variable_type"] ,
  optionValue: json["steps_values"]  ,
  );
  }
  }

  class Attachment {
  String? attachmentName;

  String? attachmentLink;

  Attachment({this.attachmentName, this.attachmentLink});

  factory Attachment.fromJson(Map<String, dynamic> json) {
  return Attachment(
  attachmentLink: json["file_attachement"],
  attachmentName: json["file_name"],
  );
  }

  factory Attachment.fromJson2(Map<String, dynamic> json) {
  return Attachment(
  attachmentLink: json["link"],
  attachmentName: json["name"],
  );
  }
  }

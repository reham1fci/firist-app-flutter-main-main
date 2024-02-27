class Account {
String? accountNum ;
String? companyId;
String? debit  ;
String? credit ;
String? balance  ;
String? type  ;
String? date  ;
String? details  ;
String? definition  ;



Account({this.accountNum, this.companyId, this.debit, this.credit,
      this.balance, this.type , this.date ,this.definition , this.details});

factory Account.fromJson(Map<String, dynamic> json){
return Account(
  accountNum: json["account_number"] ,
  balance:json["rasedd"],
  companyId: json["company_id"] ,
  type: json["type"] ,
  credit: json["daenn"] ,
  debit: json["madenn"]
);

}
factory Account.fromJsonDetails(Map<String, dynamic> json){
return Account(
  details: json["details"] ,
  definition:json["definition"],
  date:json["document_date"],
  credit: json["daen"] ,
  debit: json["maden"]
);

}
}








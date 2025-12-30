class Project {
   String? projectName;
   String? nameAr;
   String? orderCount;
   String? projectTarget;
   String? employeeTarget;
   String? startDate;

   String? totalPrice;
   String? debit;
   String? credit;
   String? bonus;

   Project({this.projectName, this.orderCount, this.totalPrice, this.debit,
      this.credit, this.bonus  , this.nameAr , this.projectTarget , this.employeeTarget, this.startDate});



   factory Project.fromJson(Map<String, dynamic> json) {
      return Project(
         projectName: json["name"],
         nameAr: json["name_ar"],
         orderCount: json["orders_count"].toString(),
         totalPrice: json["total_price"].toString(),
         debit: json["debit"].toString(),
         credit: json["credit"].toString(),
         bonus: json["bonus"].toString(),
      );
   }
    factory Project.fromJson2(Map<String, dynamic> json) {
       return
           Project(nameAr: json["project_name"] , projectTarget: json["project_target"].toString() ,
            startDate: json["start_date"].toString() ,
               employeeTarget: json["employee_target"].toString()
           );
    }
}
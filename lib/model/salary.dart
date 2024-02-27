class Salary{
  String? salaryAllowances;
  String? startDate;
  String? countDays;
  String?totalSalary;
  String?daysTarget;
  String?countDays2;
  String? requiredTarget;
  String?chefzTarget;
  String?jahezTarget;
  String?hangerTarget;
  String?restaurantsTarget;
  String? packageTarget;
  String?investTarget;
  String?debtDiscount;
  String?coustdyDiscount;
  String?incentive;
  String?netSalary;
  String? hourDiscount;
  String? attendanceDiscount;
  String? insuranceDiscount;
  String? salaryAfterInsurance;
  String? completeRate ;
  String? salaryDue ;

  Salary({
      this.salaryAllowances,
      this.startDate,
      this.countDays,
      this.totalSalary,
      this.daysTarget,
      this.countDays2,
      this.requiredTarget,
      this.chefzTarget,
      this.jahezTarget,
      this.hangerTarget,
      this.restaurantsTarget,
      this.packageTarget,
      this.investTarget,
      this.debtDiscount,
      this.coustdyDiscount,
      this.incentive,
      this.netSalary,
      this.hourDiscount,
      this.attendanceDiscount,
      this.insuranceDiscount,
    this.completeRate , this.salaryDue ,
      this.salaryAfterInsurance});


  factory Salary.fromJsonEmployee(Map<String, dynamic> json){
    return Salary (
        salaryAllowances: json["salary_with_allowances"] ,
        attendanceDiscount: json["amount_of_discount_from_attendance"],
        coustdyDiscount: json["ohad_khasm"] ,
        insuranceDiscount: json["insurance_discount"] ,
        netSalary: json["rest_sallary"] ,
        salaryAfterInsurance: json["salary_after_deducting_insurance"],
        debtDiscount: json["salf_khasm"],
        hourDiscount: json["total_discount_hours"]
    ); }

  @override
  String toString() {
    return 'Salary{salaryAllowances: $salaryAllowances, startDate: $startDate, countDays: $countDays, totalSalary: $totalSalary, daysTarget: $daysTarget, countDays2: $countDays2, requiredTarget: $requiredTarget, chefzTarget: $chefzTarget, jahezTarget: $jahezTarget, hangerTarget: $hangerTarget, restaurantsTarget: $restaurantsTarget, packageTarget: $packageTarget, investTarget: $investTarget, debtDiscount: $debtDiscount, coustdyDiscount: $coustdyDiscount, incentive: $incentive, netSalary: $netSalary, hourDiscount: $hourDiscount, attendanceDiscount: $attendanceDiscount, insuranceDiscount: $insuranceDiscount, salaryAfterInsurance: $salaryAfterInsurance, completeRate: $completeRate, salaryDue: $salaryDue}';
  }

  factory Salary.fromJson(Map<String, dynamic> json){
    return Salary (
        salaryAllowances: json["salary_with_allowances"] ,
        countDays: json["count_the_days"],
        countDays2: json["count_the_days2"],
        coustdyDiscount: json["ohad_khasm"] ,
        insuranceDiscount:"0.0" ,
        netSalary: json["safy_all"] ,
        salaryAfterInsurance: json["salary_with_allowances"],
        debtDiscount: json["salf_khasm"],
        startDate: json["date_commencement"],
        totalSalary: json["total_salary"],
        daysTarget: json["days_excluded_from_target"],
      requiredTarget: json["required_target"],
        chefzTarget: json["chefz_target"],
        hangerTarget: json["hanger_target"],
        jahezTarget: json["jahez_target"],
        restaurantsTarget: json["target_restaurants"],
        packageTarget: json["pakage_target"],
        investTarget: json["target_investigator"],
        completeRate: json["nesba_mohkak"],
        salaryDue: json["salary_mostahk"],
        incentive: json["salary_hafez"],


    );



  }

}
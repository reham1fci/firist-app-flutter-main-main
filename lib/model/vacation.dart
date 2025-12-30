class Vacation {
  int? daysRequested;

  int? paidDays;
  int? unPaidDays;
  int? totalDays;

  double? paidBalance;
  double? unPaidBalance;
  double? totalBalance;

  String? travelTicketText;

  bool? restartWork; // true = نعم ، false = لا

  Vacation({
    this.daysRequested,
    this.paidDays,
    this.unPaidDays,
    this.totalDays,
    this.paidBalance,
    this.unPaidBalance,
    this.totalBalance,
    this.travelTicketText,
    this.restartWork,
  });

  factory Vacation.fromJson(Map<String, dynamic> json) {
    return Vacation(
      // عدد الأيام المطلوبة
      daysRequested: json['vacation_request']?['days_requested'],

      // تقسيم الأيام
      paidDays: json['requested_days_split']?['requested_paid_days'],
      unPaidDays: json['requested_days_split']?['requested_unpaid_days'],
      totalDays: json['requested_days_split']?['requested_total_days'],

      // الرصيد
      paidBalance: (json['balances']?['paid_balance'])?.toDouble(),
      unPaidBalance: (json['balances']?['unpaid_balance'])?.toDouble(),
      totalBalance: (json['balances']?['total_balance'])?.toDouble(),

      // تذكرة السفر (زي ما هي)
      travelTicketText:
      json['travel_ticket']?['travel_ticket_text'],

      // مباشرة العمل
      restartWork:
      json['restart_work']?['restart_work_check'] ==
          'yes_restart_work',
    );
  }
}

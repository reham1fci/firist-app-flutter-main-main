class PendingCheck {
  final int countRequests;
  final int countForms;
  final int totalAll;
  final String message;
  final List<String> requestIds;
  final List<String> formIds;

  PendingCheck({
    required this.countRequests,
    required this.countForms,
    required this.totalAll,
    required this.requestIds,
    required this.formIds,
    required this.message,

  });

  factory PendingCheck.fromJson(Map<String, dynamic> json) {
    return PendingCheck(
      countRequests: json['count_requests'],
      message: json['message'],
      countForms: json['count_forms'],
      totalAll: json['total_all'],
      requestIds: List<String>.from(json['request_ids']),
      formIds: List<String>.from(json['form_ids']),
    );
  }
}


class AppConstants {
  static const String appName = 'HR Marsa';
  static const double appVersion = 2.2;
  static const String baseUrl = "https://marsalogistics.com/new/hr_marsa_system/ar/api_hr_apps";
  static const String loginUri = '/Login_Api.php';
  static const String addPermissionReq = '/insert_request_permission_api.php';
  static const String showPermissionReq = '/show_request_permission_api.php';
  static const String showAskingReq = '/Show_Issues_api.php';
  static const String insertJustification = '/Justification_api.php';
  static const String attendanceDetails = '/view_hodor_inseraf_api.php';
  static const String getShift = '/view_shift_api.php';
  static const String getAccountBalance = '/account_statement_api.php';
  static const String getAccountStatementDetails = '/account_statement_details_api.php';
  static const String employeeSalary = '/Employ_Salary_api.php';
  static const String attendanceFingerPrint = '/add_hoder_ensraf_api.php';
  static const String bestEmployee = '/show_order_employee_depend_on_process_api.php';
  static const String  vacationTypes= '/Show_Vacation_Type_api.php';
  static const String  insertVacation= '/Insert_Vacaton_Request_api.php';
  static const String  getVacation= '/Show_Vacation_Rquest_api.php';
  static const String  getRequestTypes= '/hr_request_type_api.php';
  static const String  getAllRequests= '/Show_All_Request_api.php';
  static const String  AddAllRequests= '/hr_add_all_request_api.php';

  //MESSAGING
  static const String conversationListUri = '/api/v1/customer/message/list';
  static const String searchConversationListUri = '/api/v1/customer/message/search-list';
  static const String messageListUri = '/api/v1/customer/message/details';
  static const String sendMessageUri = '/api/v1/customer/message/send';

  // Shared Key
  static const String theme = '6ammart_theme';
  static const String token = '6ammart_token';
  static const String countryCode = '6ammart_country_code';
  static const String languageCode = '6ammart_language_code';
  static const String cartList = '6ammart_cart_list';
  static const String userPassword = '6ammart_user_password';
  static const String userAddress = '6ammart_user_address';
  static const String userNumber = '6ammart_user_number';
  static const String userCountryCode = '6ammart_user_country_code';
  static const String notification = '6ammart_notification';
  static const String searchHistory = '6ammart_search_history';
  static const String intro = '6ammart_intro';
  static const String notificationCount = '6ammart_notification_count';
  static const String dmTipIndex = '6ammart_dm_tip_index';
  static const String earnPoint = '6ammart_earn_point';
  static const String acceptCookies = '6ammart_accept_cookies';

  static const String topic = 'all_zone_customer';
  static const String zoneId = 'zoneId';
  static const String operationAreaId = 'operationAreaId';
  static const String moduleId = 'moduleId';
  static const String cacheModuleId = 'cacheModuleId';
  static const String localizationKey = 'X-localization';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String cookiesManagement = 'cookies_management';


  ///Refer & Earn work flow list..
  static const dataList = ['Invite your friends & businesses', 'They register eFood with special offer', 'You made your earning !'];

  /// Delivery Tips
  static List<String> tips = ['not_now' ,'15', '10', '20', '40', 'custom'];
  static List<String> deliveryInstructionList = [
    'Deliver to front door',
    'Deliver to the reception desk',
    'Avoid Calling Phone',
    'Come with no sound',
  ];

 

  /// order status..
  static const String pending = 'pending';
  static const String accepted = 'accepted';
  static const String processing = 'processing';
  static const String confirmed = 'confirmed';
  static const String handover = 'handover';
  static const String pickedUp = 'picked_up';

  ///user type..
  static const String user = 'user';
  static const String customer = 'customer';
  static const String admin = 'admin';
  static const String deliveryMan = 'delivery_man';
  static const String vendor = 'vendor';

}

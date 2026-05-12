
import 'package:betakety_app/controllers/language_controller.dart';
import 'package:betakety_app/util/images.dart';

class AppConstants {
  static const String appName = 'HR Marsa';
  static const double appVersion = 2.2;
  static const String company_name = 'Marsa Company';
  static const String hr_system = 'HR System';
  static const String baseUrl = "https://marsalogistics.com/new/hr_marsa_system/ar/api_hr_apps";
  static const String notificationBaseUrl = "https://www.marsalogistics.com/new/hr_marsa_system/ar/app_setting/api";
  static const String loginUri = '/Login_Api.php';
  static const String signupUrl= '/insert_user_api.php';
  static const String setArrival= '/driver_arrival_api.php';
  static const String objectionReason= '/api_deduction_request_objection.php';
  static const String acceptDeduction= '/api_approve_deduction_request.php';
  static const String addPermissionReq = '/insert_request_permission_api.php';
  static const String addMaintenanceReq = '/Maintenance_request_api.php';
  static const String showPermissionReq = '/show_request_permission_api.php';
  static const String hoursCount = '/api_time_permission_view_count.php';
  static const String getTime = '/api_time_permission_view.php';
  static const String checkUserLocation = '/check_user_location.php';
  static const String showAskingReq = '/Show_Issues_api.php';
  static const String showAskingPendingReq = '/Show_Issues_api_pending.php';
  static const String getAccountBalance = '/account_statement_api.php';
  static const String getAccountStatementDetails = '/account_statement_details_api.php';
   static const String insertJustification = '/insert_Issues_api.php';
  static const String attendanceDetails = '/view_hodor_inseraf_api.php';
  static const String loginFingerPrint = '/add_hoder_api.php';
  static const String fakeLocation = '/fack_location.php';
  static const String getGpsSettings = '/get_gps_settings.php';
  static const String levelOptions = '/Get_Level_Options_api.php';
  static const String logoutFingerPrint = '/add_ensraf_api.php';
  static const String getShift = '/view_shift_api.php';
  static const String showNotification  = '/view_notifications_api.php';
  static const String  vacationTypes= '/Show_Vacation_Type_api.php';
  static const String  empData= '/hr_request_type_update_emp_data_api.php';
  static const String  editProfile= '/hr_add_all_requestt_api_update_emp_data.php';
  static const String  showMandatoryData= '/hr_request_type_update_emp_data_api_req.php';
  static const String  editMandatoryData= '/hr_add_all_requestt_api_update_emp_data_required.php';
  static const String  insertVacation= '/Insert_Vacaton_Request_api_gz.php';
  static const String  getVacation= '/Show_Vacation_Rquest_api.php';
  static const String  getVacationData= '/get_vacation_info.php';
  static const String  forgetPassword= '/api_password_send_otp.php';
  static const String  saveNotificationToken= '/save-fcm-token.php';
  static const String  deactivateToken= '/deactivate-fcm-token.php';
  static const String  resetPassword= '/api_password_reset.php';
  static const String  getRequestTypes= '/hr_request_type_api.php';
  static const String  getRequestApiList= '/api_list.php';
  static const String  getAllRequests= '/Show_All_Request_api.php';
  static const String  showTripRequest= '/Show_Request_Trips_api.php';
  static const String  maintenanceRequest= '/show_Maintenance_request_api.php';
  static const String  showDeductionRequest= '/Show_discount_Rquest_api.php';
  static const String  showShipmentsDriver= '/show_request_limit_new_api_receiving_driver.php';
  static const String  details= '/hr_app_show_request_details.php';
  static const String  showShipments= '/show_request_limit_new_api_receiving_custom_broker.php';
  static const String  receivedShipment= '/api_insert_shipment_received_customs_broker.php';
  static const String  receivedDriverShipment= '/api_insert_shipment_received_driver.php';
  static const String  notFinishedShipment= '/api_insert_shipment_not_finished_customs_broker.php';
  static const String  AddAllRequests= '/hr_add_all_requestt_api.php';
  static const String  processingTrip= '/Process_Trip_Request_api.php';
  static const String  confirmDailyProject= '/Daily_Target_Confirmation_API.php';
  static const String  insertException= '/request_delivery_exception_api.php';
  static const String  requiredFiles= '/show_required_files_employ_api.php';
  static const String  employeeRewards= '/api_employee_bonuses_summary2.php';
  static const String employeeSalary = '/Employ_Salary_api.php';
  static const String dailyProject = '/confirmation_driver_projects_api_daily.php';
  static const String monthlyEvaluation = '/api_monthly_evaluation_deliveryy_gz.php';
  static const String attendanceFingerPrint = '/add_hoder_ensraf_api.php';
  static const String deleteAccount = '/delete_user_api.php';
  static const String bestEmployee = '/show_order_employee_depend_on_process_api.php';
  static const String bannerUri = '/api/v1/banners';
  static const String storeItemUri = '/api/v1/items/latest';
  static const String popularItemUri = '/api/v1/items/popular';
  static const String reviewedItemUri = '/api/v1/items/most-reviewed';
  static const String searchItemUri = '/api/v1/items/details/';
  static const String subCategoryUri = '/api/v1/categories/childes/';
  static const String categoryItemUri = '/api/v1/categories/items/';
  static const String categoryStoreUri = '/api/v1/categories/stores/';
  static const String configUri = '/api/v1/config';
  static const String trackUri = '/api/v1/customer/order/track?order_id=';
  static const String messageUri = '/api/v1/customer/message/get';
  static const String forgetPasswordUri = '/api/v1/auth/forgot-password';
  static const String verifyTokenUri = '/api/v1/auth/verify-token';
  static const String resetPasswordUri = '/api/v1/auth/reset-password';
  static const String verifyPhoneUri = '/api/v1/auth/verify-phone';
  static const String checkEmailUri = '/api/v1/auth/check-email';
  static const String verifyEmailUri = '/api/v1/auth/verify-email';
  static const String registerUri = '/api/v1/auth/sign-up';
  static const String tokenUri = '/api/v1/customer/cm-firebase-token';
  static const String placeOrderUri = '/api/v1/customer/order/place';
  static const String placePrescriptionOrderUri = '/api/v1/customer/order/prescription/place';
  static const String addressListUri = '/api/v1/customer/address/list';
  static const String zoneUri = '/api/v1/config/get-zone-id';
  static const String removeAddressUri = '/api/v1/customer/address/delete?address_id=';
  static const String addAddressUri = '/api/v1/customer/address/add';
  static const String updateAddressUri = '/api/v1/customer/address/update/';
  static const String setMenuUri = '/api/v1/items/set-menu';
  static const String customerInfoUri = '/api/v1/customer/info';
  static const String couponUri = '/api/v1/coupon/list';
  static const String couponApplyUri = '/api/v1/coupon/apply?code=';
  static const String runningOrderListUri = '/api/v1/customer/order/running-orders';
  static const String historyOrderListUri = '/api/v1/customer/order/list';
  static const String orderCancelUri = '/api/v1/customer/order/cancel';
  static const String codSwitchUri = '/api/v1/customer/order/payment-method';
  static const String orderDetailsUri = '/api/v1/customer/order/details?order_id=';
  static const String wishListGetUri = '/api/v1/customer/wish-list';
  static const String addWishListUri = '/api/v1/customer/wish-list/add?';
  static const String removeWishListUri = '/api/v1/customer/wish-list/remove?';
  static const String notificationUri = '/api/v1/customer/notifications';
  static const String updateProfileUri = '/api/v1/customer/update-profile';
  static const String searchUri = '/api/v1/';
  static const String reviewUri = '/api/v1/items/reviews/submit';
  static const String itemDetailsUri = '/api/v1/items/details/';
  static const String lastLocationUri = '/api/v1/delivery-man/last-location?order_id=';
  static const String deliveryManReviewUri = '/api/v1/delivery-man/reviews/submit';
  static const String storeUri = '/api/v1/stores/get-stores';
  static const String popularStoreUri = '/api/v1/stores/popular';
  static const String latestStoreUri = '/api/v1/stores/latest';
  static const String storeDetailsUri = '/api/v1/stores/details/';
  static const String basicCampaignUri = '/api/v1/campaigns/basic';
  static const String itemCampaignUri = '/api/v1/campaigns/item';
  static const String basicCampaignDetailsUri = '/api/v1/campaigns/basic-campaign-details?basic_campaign_id=';
  static const String interestUri = '/api/v1/customer/update-interest';
  static const String suggestedItemUri = '/api/v1/customer/suggested-items';
  static const String storeReviewUri = '/api/v1/stores/reviews';
  static const String distanceMatrixUri = '/api/v1/config/distance-api';
  static const String searchLocationUri = '/api/v1/config/place-api-autocomplete';
  static const String placeDetailsUri = '/api/v1/config/place-api-details';
  static const String geocodeUri = '/api/v1/config/geocode-api';
  static const String socialLoginUri = '/api/v1/auth/social-login';
  static const String socialRegisterUri = '/api/v1/auth/social-register';
  static const String updateZoneUri = '/api/v1/customer/update-zone';
  static const String moduleUri = '/api/v1/module';
  static const String parcelCategoryUri = '/api/v1/parcel-category';
  static const String aboutUsUri = '/about-us';
  static const String privacyPolicyUri = '/privacy-policy';
  static const String termsAndConditionUri = '/terms-and-conditions';
  static const String cancellationUri = '/cancelation';
  static const String refundUri = '/refund';
  static const String shippingPolicyUri = '/shipping-policy';
  static const String subscriptionUri = '/api/v1/newsletter/subscribe';
  static const String customerRemoveUri = '/api/v1/customer/remove-account';
  static const String walletTransactionUri = '/api/v1/customer/wallet/transactions';
  static const String loyaltyTransactionUri = '/api/v1/customer/loyalty-point/transactions';
  static const String loyaltyPointTransferUri = '/api/v1/customer/loyalty-point/point-transfer';
  static const String zoneListUri = '/api/v1/zone/list';
  static const String storeRegisterUri = '/api/v1/auth/vendor/register';
  static const String dmRegisterUri = '/api/v1/auth/delivery-man/store';
  static const String refundReasonUri = '/api/v1/customer/order/refund-reasons';
  static const String refundRequestUri = '/api/v1/customer/order/refund-request';
  static const String directionUri = '/api/v1/config/direction-api';
  static const String vehicleListUri = '/api/v1/vehicles/list';
  static const String taxiCouponUri = '/api/v1/coupon/list/taxi';
  static const String taxiBannerUri = '/api/v1/banners/taxi';
  static const String topRatedVehiclesListUri = '/api/v1/vehicles/top-rated/list';
  static const String bandListUri = '/api/v1/vehicles/brand/list';
  static const String taxiCouponApplyUri = '/api/v1/coupon/apply/taxi?code=';
  static const String tripPlaceUri = '/api/v1/trip/place';
  static const String runningTripUri = '/api/v1/trip/list';
  static const String vehicleChargeUri = '/api/v1/vehicle/extra_charge';
  static const String vehiclesUri = '/api/v1/get-vehicles';
  static const String storeRecommendedItemUri = '/api/v1/items/recommended';
  static const String orderCancellationUri = '/api/v1/customer/order/cancellation-reasons';
  static const String cartStoreSuggestedItemsUri = '/api/v1/items/suggested';
  static const String landingPageUri = '/api/v1/flutter-landing-page';

  //MESSAGING
  static const String conversationListUri = '/api/v1/customer/message/list';
  static const String searchConversationListUri = '/api/v1/customer/message/search-list';
  static const String messageListUri = '/api/v1/customer/message/details';
  static const String sendMessageUri = '/api/v1/customer/message/send';
  static const String waiting = 'waiting';
  static const String processing = 'processing';
  static const String finished = 'finished';
  static const String all = 'all';

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

  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.saudi,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
    LanguageModel(
        imageUrl: Images.united_kingdom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
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

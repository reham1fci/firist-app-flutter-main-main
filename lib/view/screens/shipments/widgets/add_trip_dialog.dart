import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/trip_controller.dart';
import '../../../../util/constant.dart';
import '../../../../util/styles.dart';

class AddTripDialog extends StatefulWidget {
  const AddTripDialog({Key? key}) : super(key: key);

  @override
  State<AddTripDialog> createState() => _AddTripDialogState();
}

class _AddTripDialogState extends State<AddTripDialog> {
  final TextEditingController _detailsController = TextEditingController();

  dynamic _selectedFromCity;
  dynamic _selectedToCity;

  late final TripController _tripController;

  static final List<Map<String, String>> _fallbackCitiesList = [
    {'city_id': '1', 'city_name': 'الرياض', 'city_name_en': 'Riyadh'},
    {'city_id': '2', 'city_name': 'جدة', 'city_name_en': 'Jeddah'},
    {'city_id': '3', 'city_name': 'الدمام', 'city_name_en': 'Dammam'},
    {'city_id': '4', 'city_name': 'مكة المكرمة', 'city_name_en': 'Mecca'},
    {'city_id': '5', 'city_name': 'المدينة المنورة', 'city_name_en': 'Medina'},
    {'city_id': '6', 'city_name': 'الخبر', 'city_name_en': 'Khobar'},
    {'city_id': '7', 'city_name': 'الأحساء', 'city_name_en': 'Al Ahsa'},
    {'city_id': '8', 'city_name': 'القصيم', 'city_name_en': 'Qassim'},
    {'city_id': '9', 'city_name': 'تبوك', 'city_name_en': 'Tabuk'},
    {'city_id': '10', 'city_name': 'أبها', 'city_name_en': 'Abha'},
    {'city_id': '11', 'city_name': 'خميس مشيط', 'city_name_en': 'Khamis Mushait'},
    {'city_id': '12', 'city_name': 'جازان', 'city_name_en': 'Jizan'},
    {'city_id': '13', 'city_name': 'نجران', 'city_name_en': 'Najran'},
    {'city_id': '14', 'city_name': 'حائل', 'city_name_en': 'Hail'},
    {'city_id': '15', 'city_name': 'ينبع', 'city_name_en': 'Yanbu'},
    {'city_id': '16', 'city_name': 'الطائف', 'city_name_en': 'Taif'},
    {'city_id': '17', 'city_name': 'الجبيل', 'city_name_en': 'Jubail'},
  ];

  @override
  void initState() {
    super.initState();
    _tripController = Get.isRegistered<TripController>()
        ? Get.find<TripController>()
        : Get.put(TripController());
    _tripController.getCities();
  }

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  String _getCityDisplayName(dynamic city) {
    if (city == null) return '';
    if (city is String) return city.trim();
    if (city is Map) {
      bool isAr = Get.locale?.languageCode == 'ar';
      if (isAr) {
        String val = (city['city_name'] ??
                city['city_name_ar'] ??
                city['name_ar'] ??
                city['title_ar'] ??
                city['name'] ??
                '')
            .toString()
            .trim();
        if (val.isNotEmpty) return val;
      }
      String valEn = (city['city_name_en'] ??
              city['name_en'] ??
              city['title_en'] ??
              city['city_name'] ??
              city['name'] ??
              '')
          .toString()
          .trim();
      if (valEn.isNotEmpty) return valEn;
      if (city.values.isNotEmpty) return city.values.first.toString().trim();
    }
    return city.toString().trim();
  }

  String _getCityId(dynamic city) {
    if (city == null) return '';
    if (city is Map) {
      return (city['city_id'] ?? city['id'] ?? _getCityDisplayName(city)).toString().trim();
    }
    return city.toString().trim();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: GetBuilder<TripController>(
            builder: (tripCtrl) {
              List<dynamic> activeCities = tripCtrl.citiesList.isNotEmpty
                  ? tripCtrl.citiesList
                  : _fallbackCitiesList;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'add_trip'.tr,
                      style: fontSizeBold.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // From City Dropdown
                  Text(
                    '${'from'.tr} ${'city'.tr}',
                    style: fontSizeMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: kBorderColorTextField),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: tripCtrl.isLoadingCities && activeCities.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : DropdownButton<dynamic>(
                              isExpanded: true,
                              hint: Text(
                                '${'from'.tr} ${'city'.tr}',
                                style: fontSizeRegular.copyWith(color: kGreyTextColor),
                              ),
                              value: _selectedFromCity,
                              items: activeCities.map((city) {
                                return DropdownMenuItem<dynamic>(
                                  value: city,
                                  child: Text(
                                    _getCityDisplayName(city),
                                    style: fontSizeRegular,
                                  ),
                                );
                              }).toList(),
                              onChanged: tripCtrl.isLoading
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedFromCity = value;
                                      });
                                    },
                            ),
                    ),
                  ),
                  const SizedBox(height: 14.0),

                  // To City Dropdown
                  Text(
                    '${'to'.tr} ${'city'.tr}',
                    style: fontSizeMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: kBorderColorTextField),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: tripCtrl.isLoadingCities && activeCities.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : DropdownButton<dynamic>(
                              isExpanded: true,
                              hint: Text(
                                '${'to'.tr} ${'city'.tr}',
                                style: fontSizeRegular.copyWith(color: kGreyTextColor),
                              ),
                              value: _selectedToCity,
                              items: activeCities.map((city) {
                                return DropdownMenuItem<dynamic>(
                                  value: city,
                                  child: Text(
                                    _getCityDisplayName(city),
                                    style: fontSizeRegular,
                                  ),
                                );
                              }).toList(),
                              onChanged: tripCtrl.isLoading
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedToCity = value;
                                      });
                                    },
                            ),
                    ),
                  ),
                  const SizedBox(height: 14.0),

                  // Details Edit Text
                  Text(
                    'details'.tr,
                    style: fontSizeMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6.0),
                  TextField(
                    controller: _detailsController,
                    enabled: !tripCtrl.isLoading,
                    maxLines: 3,
                    style: fontSizeRegular,
                    decoration: InputDecoration(
                      hintText: 'details'.tr,
                      hintStyle: fontSizeRegular.copyWith(color: kGreyTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: kBorderColorTextField),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: kBorderColorTextField),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: kMainColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Action Buttons: Add and Cancel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: tripCtrl.isLoading
                            ? null
                            : () {
                                Navigator.of(context).pop();
                              },
                        child: Text(
                          'CANCEL'.tr,
                          style: fontSizeMedium.copyWith(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kMainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                        ),
                        onPressed: tripCtrl.isLoading
                            ? null
                            : () async {
                                String fromCityVal = _selectedFromCity != null
                                    ? _getCityId(_selectedFromCity)
                                    : '';
                                String toCityVal = _selectedToCity != null
                                    ? _getCityId(_selectedToCity)
                                    : '';
                                String detailsVal = _detailsController.text;

                                await _tripController.addTrip(
                                  fromCity: fromCityVal,
                                  toCity: toCityVal,
                                  details: detailsVal,
                                );
                              },
                        child: tripCtrl.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'add'.tr,
                                style: fontSizeMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void showAddTripDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddTripDialog();
    },
  );
}

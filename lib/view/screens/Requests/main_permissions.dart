import 'package:betakety_app/permission/add_request_permission.dart';
import 'package:betakety_app/permission/permission_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../card_style/body_measurement.dart';
import '../../card_style/body_measurementt.dart';
import '../../controllers/permission_controller.dart';
import '../../util/constant.dart';
import '../../util/styles.dart';
import 'add_request_per.dart';
import 'view_request_per.dart';

class MainPermissions extends StatefulWidget {
  const MainPermissions({Key? key}) : super(key: key);

  @override
  _MainPermissionsState createState() => _MainPermissionsState();
}

class _MainPermissionsState extends State<MainPermissions> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        // backgroundColor: kFirstColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kTitleColor),
          centerTitle: true,
          title: Text(
            'permission_requests'.tr,
            style: fontSizeMedium,
          ),
          actions: const [
            SizedBox(
              width: 5.0,
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 2.0,
          bottom: TabBar(
            onTap: (value) {
              Get.find<PermissionController>().changeSelected(value);
            },
            labelColor: kTitleColor,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                //icon: Icon(Icons.cloud_outlined),
                text: 'pending'.tr,
              ),
              Tab(
                //icon: Icon(Icons.brightness_5_sharp),
                text: 'processing'.tr,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10.0),
            // const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F5F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              child: AppTextField(
                textFieldType: TextFieldType.NAME,
                decoration: const InputDecoration(
                  suffixIcon: Icon(
                    Icons.search,
                    color: kTitleColor,
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xFFF7F5F2),
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'Search',
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  // Center(
                  //   child: Text("It's cloudy here"),
                  // ),
                  BodyMeasurementView2(),
                  BodyMeasurementView2(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Get.to(AddRequestPermission());
          },
        ),
      ),
    );
  }
}

import 'package:betakety_app/view/screens/Requests/add_request.dart';
import 'package:betakety_app/view/screens/Requests/add_request_permission.dart';
import 'package:betakety_app/view/screens/Requests/add_vaction_request.dart';
import 'package:betakety_app/view/screens/Requests/all_requests_body.dart';
import 'package:betakety_app/view/screens/Requests/asking_body.dart';
import 'package:betakety_app/view/screens/Requests/vaction_request_body.dart';
import 'package:betakety_app/view/screens/shipments/widgets/trips_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../controllers/permission_controller.dart';
import '../../../util/constant.dart';
import '../../../util/styles.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  AllRequestsState createState() => AllRequestsState();
}

class AllRequestsState extends State<TripsScreen> {
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
            'trips'.tr,
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

            Expanded(
              child: TabBarView(
                children: [
                  // Center(
                  //   child: Text("It's cloudy here"),
                  // ),
                  TripsBody(selectIndex: 0 ),
                  TripsBody(selectIndex: 1 ),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //     child: const Icon(
        //       Icons.add,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {
        //       //   Get.to(AddRequestPermission());
        //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AddRequest()));
        //     }
        // ),
      ),
    );
  }
}

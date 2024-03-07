import 'package:betakety_app/view/screens/Requests/main_permissions.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:maan_ui/Screens/Widgets/Animation/animation_list.dart';
// import 'package:maan_ui/Screens/Widgets/Button/button_list.dart';
// import 'package:maan_ui/Screens/Widgets/Data%20Table/data_table_list.dart';
// import 'package:maan_ui/Screens/Widgets/Form%20Component/form_component_list.dart';
// import 'package:maan_ui/Screens/Widgets/Layouts/layouts_list.dart';
// import 'package:maan_ui/Screens/Widgets/TabBar/tab_bar_list.dart';
// import 'package:maan_ui/Screens/Widgets/app_top_bar.dart';
// import 'package:maan_ui/Screens/Widgets/input_selection_list.dart';
// import 'package:maan_ui/Screens/Widgets/search_bar.dart' as sb;
// import 'package:maan_ui/Screens/Widgets/text_widgets.dart';

import '../../../../card_style/body_measurement.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../requests/permissions_requests/view_request_per2.dart';
import '../../../../util/styles.dart';

//import 'Navigation Bar/navigation_list.dart';

class WidgetList extends StatefulWidget {
  const WidgetList({Key? key}) : super(key: key);

  @override
  _WidgetListState createState() => _WidgetListState();
}

class _WidgetListState extends State<WidgetList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
    iconTheme: const IconThemeData(color: kTitleColor),
    centerTitle: true,
    title: Text(
    'requests'.tr,
    style: fontSizeMedium,
    ),
    actions: const [
    SizedBox(
    width: 5.0,
    ),
    ],
    backgroundColor: Colors.white,
    elevation: 2.0,
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: Get.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color.fromARGB(255, 220, 217, 217),
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.to(MainPermissions());
                          //const AppTopBar().launch(context);
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25.0,
                          child: Center(
                            child: Image.asset('images/apptopbar.png'),
                          ),
                        ),
                        title: Text(
                          'permission_requests'.tr,
                          style: fontSizeMedium,
                        ),
                        trailing: const CircleAvatar(
                          backgroundColor: kFirstFullColor,
                          radius: 15.0,
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

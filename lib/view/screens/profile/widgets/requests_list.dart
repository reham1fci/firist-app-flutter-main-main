import 'package:betakety_app/controllers/auth_controller.dart';
import 'package:betakety_app/controllers/localization_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/model/personal_data.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/screens/profile/widgets/ProfileOptions.dart';
import 'package:betakety_app/view/screens/profile/widgets/add_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';


class RequestsList extends StatefulWidget {
  int? selectIndex ;

  RequestsList({super.key , this.selectIndex });


  @override
  State<RequestsList> createState() => RequestState();
}

class RequestState extends State<RequestsList>  {
  // final AnimationController? animationController;
  bool loader = false;
  Locale? myLocale  ;
  List<PersonalData> personalDataList = [] ;

  @override
  void initState() {
    super.initState();
    _loadData();

  }
  _loadData() async {
    setState(() {
      loader = true  ;
    });
 personalDataList  = await Get.find<AuthController>().getRequiredData();
 setState(() {
   loader = false  ;

 });
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor:Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kTitleColor),
            centerTitle: true,
            title: Text(
              'requests_list'.tr,
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
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loader
              ? Center(child: CircularProgressIndicator() )
              : Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return  ProfileOptions(
                    title: personalDataList[index].name!,
                    image: 'assets/image/edit_icon_red.png',
                    pressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddRequest(data: personalDataList[index],)));
                    },
                    background:  lightgGreyBack,
                  );
                },

                itemCount: personalDataList.length),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ));
    });
  }
}

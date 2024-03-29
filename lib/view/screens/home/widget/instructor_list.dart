import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
//import 'package:maan_ui/Screens/Full%20Template/MaanLMS/Screens/Notification/notification_screen.dart';
import 'package:nb_utils/nb_utils.dart';
//import 'Model/instructor_model.dart';
import '../../../../util/constant.dart';
import '../../../../model/instructor_model.dart';

class InstructorList extends StatefulWidget {
  List<InstructorItem>instructors  ;

   InstructorList({Key? key , required this.instructors}) : super(key: key);

  @override
  _InstructorListState createState() => _InstructorListState();
}

class _InstructorListState extends State<InstructorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kTitleColor),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Best Employees',
          style: kTextStyle.copyWith(color: kTitleColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                // const NotificationScreen().launch(context);
              },
              child: const Icon(FontAwesomeIcons.magnifyingGlass),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1.3,
                crossAxisCount: 2,
                children: List.generate(
                  widget.instructors.length,
                  (index) => InstructorCard(
                    instructorList: widget.instructors[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InstructorCard extends StatelessWidget {
  const InstructorCard({
    Key? key,
    required this.instructorList,
  }) : super(key: key);

  final InstructorItem instructorList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        instructorList.instructorSex == "female"?
        Image.asset("images/lms/instructor7.png"):
        Image.asset("images/lms/instructor8.png") ,
        Positioned(
          right: 15.0,
          top: 25.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                instructorList.instructorName!.length>10?instructorList.instructorName!.substring(0 , 15) : instructorList.instructorName!,
          style: kTextStyle.copyWith(
                    color: kTitleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
              Text(

               instructorList.instructorCategory!,
                style:
                    kTextStyle.copyWith(color: kGreyTextColor, fontSize: 10.0),
              ),
              Row(
                children: [
                  Text(
                    instructorList.instructorStudents!,
                    style: kTextStyle.copyWith(
    color: kGreyTextColor, fontSize: 10.0),
    ),
                    /*kTextStyle.copyWith(
                        color: kTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),*/
                  Text(
                    'process'.tr,
                    style: kTextStyle.copyWith(
                        color: kGreyTextColor, fontSize: 10.0),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    " ",
                    style: kTextStyle.copyWith(
                        color: kTitleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                  Text(
                    ' ',
                    style: kTextStyle.copyWith(
                        color: kGreyTextColor, fontSize: 10.0),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                   "5.5",
                    style:
                        kTextStyle.copyWith(color: kMainColor, fontSize: 12.0),
                  ),
                  const Icon(
                    Icons.star_rounded,
                    color: Color(0xFFF5B400),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

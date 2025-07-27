import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/color_resources.dart';
import 'package:betakety_app/view/base/gradient_color_helper.dart';
import 'package:flutter/material.dart';




class RequestsTypeItem extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const RequestsTypeItem({
    Key? key,
    required this.title,

    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
        padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    color: lightgGreyBack,
    ), child:
    ListTile(
      onTap: onTap ,
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 25.0,
        child: Center(
          child: Image.asset('images/apptopbar.png' ,color: Colors.red,),
        ),
      ),
      title: Text(
        title,
        style: fontSizeMedium,
      ),
      trailing: const CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 15.0,
        child: Center(
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.red,
            size: 15.0,
          ),
        ),
      ),
    ))  );
  }
}

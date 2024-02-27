import 'package:betakety_app/util/constant.dart';
import 'package:flutter/material.dart';

class RowItem extends StatelessWidget{
   String? name ;

   String? value  ;


   RowItem({this.name, this.value});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: 10.0,
              right: 20.0),
          decoration: BoxDecoration(
            border: const Border(
                top: BorderSide(
                  color: kAlertColor,
                )),
            color: kAlertColor.withOpacity(0.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value!,
                style: kTextStyle.copyWith(
                    color: kAlertColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                name!,
                style: kTextStyle,
              ),
            ],
          ),
        ),
      ),
    )  ;
  }

}
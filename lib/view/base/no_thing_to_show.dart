import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoThingToShow extends StatelessWidget{
  const NoThingToShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   SizedBox(
      width: double.infinity,
      height: 100,
      child:
     Center(
      child:   Column( children: <Widget>[
        //  Image.asset('images/nothing.png', fit: BoxFit.contain),
        Text( "no_data_found".tr)
      ], mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,),
    ) , ) ;
  }
  }

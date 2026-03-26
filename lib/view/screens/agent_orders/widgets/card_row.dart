import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardRow  extends StatelessWidget {
   final String keyValue;
 final   dynamic value ;
   CardRow( this.keyValue,  this.value , );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return

   Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(keyValue.tr, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(value.toString()),
      ],
    ),
  );
}

  }

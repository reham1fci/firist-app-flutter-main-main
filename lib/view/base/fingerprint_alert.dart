
import 'package:flutter/material.dart';

   showFingerPrintDialog({required BuildContext context    ,
    Function? onOkClick })  {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
      //    backgroundColor:Colors.transparent,

          //  title: Text(title!),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                 // color: Colors.white,
                  child:  Center(child:Text("scan your fingerprint")),

                ),
                Container(
padding: EdgeInsets.all(30),
                  child: IconButton(onPressed:(){onOkClick!();}, icon:Icon( Icons.fingerprint , size: 50,)),
                )
              ],
            ),
          ),
        /*  actions: [
            IconButton(onPressed:onOkClick(), icon:Icon( Icons.fingerprint)),
          ],*/
        );
      },
    );
  }



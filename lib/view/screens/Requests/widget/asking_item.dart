import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:betakety_app/view/screens/Requests/widget/attach_view.dart';
import 'package:betakety_app/view/screens/Requests/widget/justification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AskingItem extends StatelessWidget{
  int index ;
  List<dynamic>  filteredData ;

  AskingItem(this.index, this.filteredData);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return
     Padding(
       padding: const EdgeInsets.only(
           left: 24, right: 24, top: 8, bottom: 10),
       child: Container(
       decoration: BoxDecoration(
       color: CustomAppTheme.white,
       borderRadius: const BorderRadius.only(
           topLeft: Radius.circular(8.0),
           bottomLeft: Radius.circular(8.0),
           bottomRight: Radius.circular(8.0),
           topRight: Radius.circular(68.0)),
       boxShadow: <BoxShadow>[
         BoxShadow(
             color:
             CustomAppTheme.grey.withOpacity(0.2),
             offset: const Offset(1.1, 1.1),
             blurRadius: 10.0),
       ],
     ),
    child:
     Padding(
     padding: const EdgeInsets.only(
    top: 16, left: 16, right: 24),child:Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
        CrossAxisAlignment.start,
    children: <Widget>[


      Padding(
        padding: const EdgeInsets.only(
            left: 4, bottom: 8, top: 16),
        child: Text(
          filteredData[index]["question_type"],
          textAlign: TextAlign.center,
          style: const TextStyle(
            //  fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: -0.1,
              color: CustomAppTheme.darkText),
        ),
      ),
      Row(
        mainAxisAlignment:
        MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.access_time,
            color: CustomAppTheme.grey
                .withOpacity(0.5),
            size: 16,
          ),
          Padding(
            padding:
            const EdgeInsets.only(
                left: 4.0),
            child: Text(
              textDirection:
              TextDirection.ltr,
              "${filteredData[index]['hr_question_date'].toString().tr} ",
              textAlign:
              TextAlign.center,
              style: TextStyle(
                fontFamily:
                CustomAppTheme
                    .fontName,
                fontWeight:
                FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.0,
                color: CustomAppTheme
                    .grey
                    .withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          filteredData[index] ["question_stat"]=="waiting_employee_response"? ElevatedButton(
            onPressed: () {
showJustificationDialog(context:context ,hr_question_id: filteredData[index]["hr_question_id"] ,hr_question_date: filteredData[index]["hr_question_date"]) ;
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
              Color.fromARGB(
                  255, 204, 210, 215),
              // Background color
              // onPrimary: Color.fromARGB(255,
              //     23, 23, 23), // Text color
              padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5), // Padding
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                    10), // Border radius
              ),
            ),
            child: Text(
              'justification'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.5,
                color: Color(0xFF744ACC),
              ),
            ),
          ):SizedBox(),
          ElevatedButton(
            onPressed: () {
              // Add the function to execute when the button is pressed
              String attach_url  = filteredData[index]['attach_link'] ;
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                  AttachView(attach_url)));

            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
              Color.fromARGB(
                  255, 204, 210, 215),
              // Background color
              // onPrimary: Color.fromARGB(255,
              //     23, 23, 23), // Text color
              padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5), // Padding
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                    10), // Border radius
              ),
            ),
            child: Text(
              'attachments'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: 0.5,
                color: Color(0xFF744ACC),
              ),
            ),
          ),
        ],
      ) ,
      Padding(
        padding: const EdgeInsets.only(
            left: 24, right: 24, top: 2, bottom: 2),
        child: Container(
          height: 2,
          decoration: const BoxDecoration(
            color: CustomAppTheme.background,
            borderRadius: BorderRadius.all(
                Radius.circular(4.0)),
          ),
        ),
      ),
      Text(filteredData[index]['employee_reply']) ,
      Padding(
        padding: const EdgeInsets.only(
            left: 4, bottom: 8),
        child: Text(
          "${filteredData[index]['question_stat'].toString().tr} ",
          textAlign: TextAlign.center,
          style:  TextStyle(
            // fontFamily:FitnessAppTheme.fontName,
            fontWeight: FontWeight.w200,
            fontSize: 16,
            color:  filteredData[index]['question_stat'] =="Absence_was_rejected" ?Colors.red : const Color.fromARGB(
                255, 206, 217, 6) ,
          ),
        ),
         ),

  ]))
    ));

    }

}
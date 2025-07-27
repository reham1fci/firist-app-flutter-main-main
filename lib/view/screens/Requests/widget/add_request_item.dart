import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';

class AddRequestItem extends StatefulWidget {
  int index ;
  List<dynamic>  filteredData ;


  AddRequestItem({super.key, required this.index, required this.filteredData});

  @override
  State<AddRequestItem> createState() => _AddRequestItemState();
}

class _AddRequestItemState extends State<AddRequestItem> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  /*  for (int i  = 0 ; i < widget.filteredData.length ; i ++) {
      /// String key  = "controller"   +i .toString() ;
      ///
      if( widget.filteredData[i]["controller"]==null){
      TextEditingController controller = TextEditingController();
      widget.filteredData[i]["controller"] = controller;}
    }
    print(widget.filteredData)  ;
    print("test")  ;*/


}

  @override
  Widget build(BuildContext context) {
    String type  = widget.filteredData[widget.index]["value_type"] ;
    String typeName  = widget.filteredData[widget.index]["option_name_ar"] ;

    // TODO: implement build
    return GetBuilder<PermissionController>(builder: (pController) {

      return
     type== "text"
        ? CustomFieldWithTitle(
            requiredField: true,
            title: typeName,
            customTextField: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: CustomTextField(
                  maxLines: 2,
                  hintText: typeName,
                  inputType: TextInputType.text,
                  controller: widget.filteredData[widget.index]["controller"] ,
                )),
          )
      :type== "number"
        ? CustomFieldWithTitle(
            requiredField: true,
            title: typeName,
            customTextField: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: CustomTextField(
                  maxLines: 2,
                  hintText: typeName,
                  inputType: TextInputType.number,
                  controller: widget.filteredData[widget.index]["controller"] ,
                )),
          )
        : type ==  "file"
        ?  CustomFieldWithTitle(
        requiredField: false,
        title: typeName,
        customTextField: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: CustomTextField(
            onTap: () {
             pController.selectSingleFile(widget.filteredData[widget.index]["controller"] ,"" );
            },
            maxLines: 2,
            readOnly: true,
            hintText: typeName,
            inputType: TextInputType.text,
          controller: widget.filteredData[widget.index]["controller"] ,
          ),
        ),
      ):
      type ==  "date" ?
     CustomFieldWithTitle(
       height: 50,
       requiredField: true,
       title: "date".tr,
       customTextField: Container(
           decoration: BoxDecoration(
             border:
             Border.all(color: Theme.of(context).primaryColor),
             borderRadius: BorderRadius.circular(4.0),
           ),
           child: CustomTextField(
             onTap: () async {
               DateTime currentDate = DateTime.now();
               final DateTime firstDate = DateTime(2023);
               final DateTime lastDate =
               currentDate.add(const Duration(days: 30));
               final DateTime? pickedDate = await showDatePicker(
                 context: context,
                 initialDate: currentDate,
                 firstDate: firstDate,
                 lastDate: lastDate,
               );
               if (pickedDate != null) {
                 setState(() {
                   widget.filteredData[widget.index]["controller"] .text =
                       DateFormat('yyyy-MM-dd').format(pickedDate);
                 });
               }
             },
             readOnly: true,
             hintText: 'date_to'.tr,
             inputType: TextInputType.text,
             controller: widget.filteredData[widget.index]["controller"] ,
           )),
     ):
    const SizedBox();

  });
}}

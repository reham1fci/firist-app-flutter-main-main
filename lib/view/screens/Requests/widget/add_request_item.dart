import 'dart:io';

import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/model/vacation_type.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../../util/app_constants.dart';

class AddRequestItem extends StatefulWidget {
  int index ;
  String? fromScreen ;
  List<dynamic>  filteredData ;


   AddRequestItem({super.key, required this.index, required this.filteredData , this.fromScreen});

  @override
  State<AddRequestItem> createState() => _AddRequestItemState();
}

class _AddRequestItemState extends State<AddRequestItem> {
  final List<String> months = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
  ];
  String? path ;

  final List<int> years = List.generate(
      2028 - 2016 + 1, (index) => 2016 + index);

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
    String type = widget.filteredData[widget.index]["value_type"];
    String typeName = widget.filteredData[widget.index]["option_name_ar"];
    String apiFunctionName = widget.filteredData[widget
        .index]["value_type_checkif"];
    print(apiFunctionName);
    if (type == "api_list") {
      Get.find<PermissionController>().getApiList(apiFunctionName);
    }
    for (var item in widget.filteredData) {
      item["controller"] ??= TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    String type = widget.filteredData[widget.index]["value_type"];
    String value = widget.filteredData[widget.index]["value"] == null
        ? ""
        : widget.filteredData[widget.index]["value"];
    String typeName = widget.filteredData[widget.index]["option_name_ar"];
    String id = widget.filteredData[widget.index]["options_id"];
    String apiFunctionName = widget.filteredData[widget
        .index]["value_type_checkif"];

    // TODO: implement build
    return GetBuilder<PermissionController>(builder: (pController) {
      return
        type == "text"
            ? CustomFieldWithTitle(
          requiredField: true,
          title: typeName,
          customTextField: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme
                    .of(context)
                    .primaryColor),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: CustomTextField(
                maxLines: 2,
                hintText: value,
                inputType: TextInputType.text,
                controller: widget.filteredData[widget.index]["controller"],
              )),
        )
            : type == "number" || type == "money"
            ? CustomFieldWithTitle(
          requiredField: true,
          title: typeName,
          customTextField: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme
                    .of(context)
                    .primaryColor),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: CustomTextField(
                maxLines: 2,
                hintText: typeName,
                inputType: TextInputType.number,
                controller: widget.filteredData[widget.index]["controller"],
              )),
        )
            : type == "file"?
            addFile(widget.filteredData[widget.index]["controller"]
                , pController ,typeName , id)
      //   CustomFieldWithTitle(
      //   requiredField: false,
      //   title: typeName,
      //   customTextField: Container(
      //     decoration: BoxDecoration(
      //       border: Border.all(color: Theme.of(context).primaryColor),
      //       borderRadius: BorderRadius.circular(4.0),
      //     ),
      //     child: CustomTextField(
      //       onTap: () {
      //        pController.selectSingleFile(widget.filteredData[widget.index]["controller"] ,"options_files[]" );
      //       },
      //       maxLines: 2,
      //       readOnly: true,
      //       hintText: typeName,
      //       inputType: TextInputType.text,
      //     controller: widget.filteredData[widget.index]["controller"] ,
      //     ),
      //   ),
      // ):
    :  type == "date" ?
      CustomFieldWithTitle(
        height: 50,
        requiredField: true,
        title: "date".tr,
        customTextField: Container(
            decoration: BoxDecoration(
              border:
              Border.all(color: Theme
                  .of(context)
                  .primaryColor),
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
                    widget.filteredData[widget.index]["controller"].text =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                  });
                }
              },
              readOnly: true,
              hintText: 'date_to'.tr,
              inputType: TextInputType.text,
              controller: widget.filteredData[widget.index]["controller"],
            )),
      ) :
      type == "date_month" ? getMonthList(pController, typeName) :
      type == "date_year" ? geYearList(pController, typeName) :
      type == "api_list" && apiFunctionName == "select_multi_employee" ?
      getMultiSelect(apiFunctionName, pController, typeName) :

      type == "api_list" ?
      getList(apiFunctionName, pController, typeName) :
      const SizedBox();
    });
  }

  getList(String functionName, PermissionController pController,
      String typeName) {
    return pController.apiList!.isEmpty
        ? CircularProgressIndicator()
        : CustomFieldWithTitle(
      requiredField: true,

      title: typeName,
      customTextField: Container(
        decoration: BoxDecoration(
          border:
          Border.all(color: Theme
              .of(context)
              .primaryColor),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: DropdownButton<VacationType>(
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(pController.apiItemTemp == null ? typeName : pController
                .apiItemTemp!.nameAr!),
          ),
          //value:pController.apiItemTemp,
          items: pController.apiList!.map((value) {
            return DropdownMenuItem<VacationType>(
              value: value,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 9),
                child: Text(value.nameAr!),
              ),
            );
          }).toList(),
          onChanged: (value) {
            // pController.vacationTypeTemp!.options!.clear() ;
            setState(() {
              widget.filteredData[widget.index]["controller"].text = value!.Id;
            });

            pController.apiItemTemp = value;
            pController.update();
          },
          isExpanded: true,
          underline: const SizedBox(),
        ),
      ),
    );
  }

  Widget getMonthList(PermissionController pController, String typeName) {
    widget.filteredData[widget.index]["controller"].text =
        pController.monthTemp;
    return CustomFieldWithTitle(
      requiredField: true,

      title: typeName,
      customTextField: Container(
        decoration: BoxDecoration(
          border:
          Border.all(color: Theme
              .of(context)
              .primaryColor),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: DropdownButton<String>(
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(typeName),
          ),
          value: pController.monthTemp,
          items: months.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 9),
                child: Text(value),
              ),
            );
          }).toList(),
          onChanged: (value) {
            // pController.vacationTypeTemp!.options!.clear() ;
            setState(() {
              widget.filteredData[widget.index]["controller"].text = value!;
            });

            pController.monthTemp = value!;
            pController.update();
          },
          isExpanded: true,
          underline: const SizedBox(),
        ),
      ),
    );
  }

  Widget geYearList(PermissionController pController, String typeName) {
    widget.filteredData[widget.index]["controller"].text =
        pController.selectedYear.toString();

    return CustomFieldWithTitle(
      requiredField: true,

      title: typeName,
      customTextField: Container(
        decoration: BoxDecoration(
          border:
          Border.all(color: Theme
              .of(context)
              .primaryColor),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: DropdownButton<int>(
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(typeName),
          ),
          value: pController.selectedYear,
          items: years.map((value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 9),
                child: Text(value.toString()),
              ),
            );
          }).toList(),
          onChanged: (value) {
            // pController.vacationTypeTemp!.options!.clear() ;
            // setState(() {
            //   widget.filteredData[widget.index]["controller"] .text = value! ;
            //
            // });
            pController.selectedYear = value!;
            widget.filteredData[widget.index]["controller"].text =
                value.toString();
            pController.update();
          },
          isExpanded: true,
          underline: const SizedBox(),
        ),
      ),
    );
  }

  getMultiSelect(String functionName, PermissionController pController,
      String typeName) {
    return pController.apiList!.isEmpty
        ? const CircularProgressIndicator()
        : CustomFieldWithTitle(
      requiredField: true,
      title: typeName,
      customTextField: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme
              .of(context)
              .primaryColor),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<VacationType>(
            isExpanded: true,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9),
              child: pController.selectedItems.isEmpty
                  ? Text(typeName) // لو مفيش اختيار لسه
                  : Text(
                pController.selectedItems.map((e) => e.nameAr).join(", "),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            items: pController.apiList!.map((item) {
              return DropdownMenuItem<VacationType>(
                value: item,
                enabled: false,
                // مهم علشان يفضل التشيك شغال وميمشيش الاختيار الواحد
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = pController.selectedItems.contains(item);
                    return
                      Row(
                        children: [
                          Checkbox(
                            value: isSelected,
                            onChanged: (checked) {
                              if (checked == true) {
                                pController.selectedItems.add(item);
                                pController.selectedIds.add(item.Id!);
                              } else {
                                pController.selectedItems.remove(item);
                                pController.selectedIds.remove(item.Id!);
                              }
                              menuSetState(() {});
                              setState(() {
                                widget.filteredData[widget.index]["controller"]
                                    .text = pController.selectedIds.join(",");
                              });
                            },
                          ),
                          Text(item.nameAr!),
                        ],
                      );
                  },
                ),
              );
            }).toList(),
            onChanged: (_) {},
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 10),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addFile( TextEditingController controller  , PermissionController pController , String title ,String id ) {
    return
      Column(children: [
        //Text( index==0? "identity_front".tr: index == 1 ?"identity_back".tr :"medical_image".tr,),

        //   Text(index==0? "front image ": index == 1 ?"back image" :"Medical image") ,

        controller.text.isEmpty
            ? Padding(padding: EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () async {
                 if( widget.fromScreen !=null && widget.fromScreen == "profile"){
                   path = await pController.selectSingleFile(
                       controller, "options_files["+id+"]" );
                   print("path" + path!);
                 }
                 else{
                   path = await pController.selectSingleFile(
                       controller, "options_files[]" );
                   print("path" + path!);
                 }

                setState(() {

                });
              },
              child: Container(
                //padding: const EdgeInsets.only(left: 10 , right: 10),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                height: MediaQuery
                    .of(context)
                    .size
                    .width / 4.3,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(Icons.attach_file,
                    //     size: 32, color: Theme.of(context).primaryColor),
                    Image.asset(
                      "assets/image/add_attach.png", // المسار بتاع الأيقونة
                      width: 50,
                      height: 50,
                      color: Theme
                          .of(context)
                          .primaryColor, // لو عايزة تديها نفس اللون
                    ),
                    const SizedBox(height: 8),
                    Text(title,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ))
            : Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                      child: pController.isImage(path!)
                          ? Image.file(
                        File(path!),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width / 4.3,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width / 4.3,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.insert_drive_file,
                                size: 40, color: Theme
                                    .of(context)
                                    .primaryColor),
                            const SizedBox(height: 6),
                            // Text(
                            //   pController.fileNameController.text,
                            //   style: const TextStyle(
                            //       fontSize: 14, fontWeight: FontWeight.w500),
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Text(
                //   pController.fileNameController.text,
                //   style: const TextStyle(
                //       fontSize: 14, fontWeight: FontWeight.w500),
                //   overflow: TextOverflow.ellipsis,
                // ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  setState(() {
                    path = null;
                   // pController.fileNameController.clear();
                    controller.clear();
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        )
        ,


      ]);
  }
}
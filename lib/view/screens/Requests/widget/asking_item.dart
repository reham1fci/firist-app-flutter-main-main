import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/screens/Requests/widget/attach_view.dart';
import 'package:betakety_app/view/screens/Requests/widget/insert_justification_view.dart';
import 'package:betakety_app/view/screens/shipments/widgets/attachment_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:betakety_app/model/Questions.dart';
import 'package:betakety_app/util/custom_app_theme.dart';
import 'package:betakety_app/util/app_constants.dart';

class AskingItem extends StatelessWidget {
  final int index;
  final List<dynamic> filteredData;
  const AskingItem(this.index, this.filteredData, {super.key});
  @override
  Widget build(BuildContext context) {
    final Questions item = filteredData[index];

    final bool isPending = item.status == AppConstants.pending;
    final bool isRejected = item.status == "Absence_was_rejected";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: CustomAppTheme.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: CustomAppTheme.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
          border: Border.all(
            color: isRejected
                ? Colors.redAccent.withOpacity(0.3)
                : Colors.blueGrey.withOpacity(0.1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row — Title & Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      item.type!.tr ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        item.date ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// Divider
              Divider(
                thickness: 1,
                height: 16,
                color: Colors.grey.shade200,
              ),

              /// Status Row
              Row(
                children: [
                  const Icon(Icons.info_outline, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    '${'Status'.tr}: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                    item.status ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isRejected
                          ? Colors.red
                          : (isPending
                          ? Colors.orange
                          : Colors.green),
                    ),
                  ),
                ],
              ),   item.reply != null?  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.grey),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: '${'reply'.tr}: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: item.reply!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          textDirection: TextDirection.rtl, // ← مهم للنص العربي
                        ),
                      ),
                    ),
                  ]):SizedBox(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         const Icon(Icons.access_time, size: 16, color: Colors.grey),
              //         const SizedBox(width: 4),
              //         Text(
              //           '${'attendance'.tr}: ',
              //           style: TextStyle(
              //             fontSize: 13,
              //             color: Colors.grey.shade600,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         Text(
              //           item.attendance ?? '',
              //           style: TextStyle(
              //             fontSize: 13,
              //             color: Colors.grey.shade600,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ],
              //     ),
              //     Row(
              //       children: [
              //         const Icon(Icons.access_time, size: 16, color: Colors.grey),
              //         const SizedBox(width: 4),
              //         Text(
              //           '${'withdrawal'.tr}: ',
              //           style: TextStyle(
              //             fontSize: 13,
              //             color: Colors.grey.shade600,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         Text(
              //           item.withdrawal ?? '',
              //           style: TextStyle(
              //             fontSize: 13,
              //             color: Colors.grey.shade600,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              const SizedBox(height: 14),

              /// Action Buttons
              Row(
                children: [
                  if (isPending)

               Expanded(child:  Column(
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${'attendance'.tr}: ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            item.attendance ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                  Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${'withdrawal'.tr}: ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            item.withdrawal ?? '',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                    ),
                    ],
                  )),
Column(
  children: [

                  if (isPending)
                    CustomButton(buttonText: 'justification'.tr , width: 90,height: 40, onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => InsertJustificationView(questions: item)))      ;
                       },

                    ),
                  if(!isPending)
                  CustomButton(buttonText: 'attachments'.tr , width: 90,height: 40,onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AttahmentViewScreen( url: item.attachment,)))      ;


                  },
                  ),
  ]
)
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //     // showJustificationDialog(...)
                    //   },
                    //   icon: const Icon(Icons.edit_note, size: 18),
                    //   label: Text('justification'.tr),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor:
                    //     Theme.of(context).colorScheme.secondaryContainer,
                    //     foregroundColor:
                    //     Theme.of(context).colorScheme.primary,
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 12, vertical: 6),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //   ),
                    // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

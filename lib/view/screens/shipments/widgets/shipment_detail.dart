import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/resizer/fetch_pixels.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:betakety_app/view/base/custom_button.dart';
import 'package:betakety_app/view/screens/shipments/widgets/attachment_view_screen.dart';
import 'package:betakety_app/view/screens/shipments/widgets/shipment_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../model/shipment.dart';
import 'update_item_widget.dart';


class ShipmentDetails extends StatefulWidget {
   //String? id  ;
   Shipment? shipmentItem ;
   ShipmentDetails({Key? key , this .shipmentItem , }) : super(key: key);

  @override
  State<ShipmentDetails> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<ShipmentDetails> {
  bool isDropdownVisible = false;
  String selectedValue = 'Select an option';

  List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  void toggleDropdown() {
    setState(() {
      isDropdownVisible = !isDropdownVisible;
    });}
  @override
  void initState() {
  //  Get.find<ShipmentController>().shipmentDetails.clear();


    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      Get.find<ShipmentController>().getDetails(widget.shipmentItem!.requestId! ,);

    });

    }


  String? name;
  String? date;
  String? rating;
  String? owner;
  double? price;
  Color? color;

  @override
  Widget build(BuildContext context) {
    name = " ";
    date = " ";
    rating =  " ";
    owner =  " ";
    price =  0.0;

    FetchPixels(context);
    return WillPopScope(
        child:


        Scaffold(
          resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromARGB(255, 252, 252, 252),
            appBar: AppBar(
              iconTheme:  IconThemeData(color: kTitleColor),
              centerTitle: true,
              title: Text(
                'shipment_details'.tr,
                style: fontSizeMedium,
              ),
              actions: const [
                SizedBox(
                  width: 5.0,
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 2.0,
            ),
          body:
          GetBuilder<ShipmentController>(builder: (shipmentController) {
            return SafeArea(
        child: Column(
       //   mainAxisSize: MainAxisSize.min,

          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),



            getVerSpace(FetchPixels.getPixelHeight(30)),
            shipmentController.isLoading?const Expanded(child:  Center(child: CircularProgressIndicator()) ):

            Flexible(
            fit: FlexFit.loose,
            child:
                ListView(
                  primary: true,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 getPaddingWidget(
                        EdgeInsets.symmetric(
                            horizontal: FetchPixels.getPixelWidth(20)),

                        ShipmentItem(widget.shipmentItem! ,0 )
                    ),
                    getPaddingWidget(
                      EdgeInsets.symmetric(
                          horizontal: FetchPixels.getPixelWidth(20)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getVerSpace(FetchPixels.getPixelHeight(30)),
                          /* getCustomFont(
                                  "Finding Pro Cleaner", 20, Colors.black, 1,
                                  fontWeight: FontWeight.w800),
                              getVerSpace(FetchPixels.getPixelHeight(10)),
                              getMultilineCustomFont(
                                  "An cleaner will be assigned 60 minutes before booking time.",
                                  16,
                                  Colors.black,
                                  fontWeight: FontWeight.w400,
                                  txtHeight: FetchPixels.getPixelHeight(1.3)),
                              getVerSpace(FetchPixels.getPixelHeight(16)),*/
                          // getButtonWithIcon(context, Colors.white,
                          //     "details".tr, Colors.black ,
                          //
                          //         (){}, 18,
                          //     weight: FontWeight.w600,
                          //     buttonHeight: FetchPixels.getPixelHeight(60),
                          //     borderRadius: BorderRadius.circular(
                          //         FetchPixels.getPixelHeight(12)),
                          //     boxShadow: [
                          //       const BoxShadow(
                          //           color: Colors.black12,
                          //           blurRadius: 10,
                          //           offset: Offset(0.0, 4.0)),
                          //     ],
                          //   ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
                              "details".tr ,
                              style:  TextStyle(fontSize: 18, color: Colors.black87 ,fontWeight: FontWeight.bold),
                            ),
                          ),
                    //      CustomButton(buttonText:  "details".tr, onPressed: (){} ,buttonColor: kFourthColor,textColor: Colors.black, isClear: true ,),

                          getVerSpace(FetchPixels.getPixelHeight(10)),
                          Padding(padding: EdgeInsets.all(16) , child:    Text(shipmentController.shipmentDetails.isNotEmpty? shipmentController.shipmentDetails[0].details!:"")) ,
                          //
                          // getButtonWithIcon(context, Colors.white,
                          //     "attachment".tr, Colors.black ,
                          //
                          //     (){}, 18,
                          //     weight: FontWeight.w600,
                          //     buttonHeight: FetchPixels.getPixelHeight(60),
                          //     borderRadius: BorderRadius.circular(
                          //         FetchPixels.getPixelHeight(12)),
                          //     boxShadow: [
                          //       const BoxShadow(
                          //           color: Colors.black12,
                          //           blurRadius: 10,
                          //           offset: Offset(0.0, 4.0)),
                          //     ],
                          //     prefixIcon: false,
                          //     prefixImage:"attachment.svg" ,
                          //     sufixIcon: false,
                          //     suffixImage: "down_arrow.svg"),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Text(
            "attachments".tr ,
                              style:  TextStyle(fontSize: 18, color: Colors.black87 ,fontWeight: FontWeight.bold),                            ),
                          ),

                    //      CustomButton(buttonText:   "attachment".tr , onPressed: (){} ,buttonColor: Colors.white,textColor: Colors.black,),

                          getVerSpace(FetchPixels.getPixelHeight(30)),

shipmentController.shipmentDetails.isNotEmpty?
                          Column(
            children: shipmentController.shipmentDetails[0].attachmentsLinks!.map((option) {
            return    InkWell(

              onTap: () {
            setState(() {
          selectedValue = option.attachmentName!;
           print(option);
          //  isDropdownVisible = false;
             // Get.to(() => AttahmentViewScreen(option.attachmentLink)) ;
             // Get.to(() => AttahmentViewScreen(option.attachmentLink)) ;
          print(option.attachmentLink);
          Get.to(() => AttahmentViewScreen(name: option.attachmentName , url: option.attachmentLink,)) ;
       //   AttahmentViewScreen(option.attachmentLink) ;
            });
            },
            child:

            Container (
            padding: const EdgeInsets.all(16.0),
            child:Row
              (
            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text("file "'${shipmentController.shipmentDetails[0].attachmentsLinks!.indexOf(option)+1}', style: TextStyle(fontSize: 16)),
                Text(option.attachmentName??'', style: TextStyle(fontSize: 16)),
                 Spacer() ,
                 Icon(Icons.arrow_forward_ios_sharp , size: 15,)
              ],
            )

            ),
            );
            }).toList(),
            ):SizedBox() ,


                          getVerSpace(FetchPixels.getPixelHeight(30)),
                         /* getCustomFont(
                              "About Your Service", 20, Colors.black, 1,
                              fontWeight: FontWeight.w800),
                          getVerSpace(FetchPixels.getPixelHeight(10)),*/
                      Column(mainAxisSize: MainAxisSize.min,children: [
                            // getButtonWithIcon(context, Colors.white,
                            //     "updates".tr, Colors.black, () {
                            //       // go to updates list
                            //       //    Get.to(UpdatesScreen(shipmentController.shipmentDetails[0].updatesList!)) ;
                            //     }, 18,
                            //     weight: FontWeight.w800,
                            //     buttonHeight: FetchPixels.getPixelHeight(72),
                            //     borderRadius: BorderRadius.circular(
                            //         FetchPixels.getPixelHeight(12)),
                            //     boxShadow: [
                            //       const BoxShadow(
                            //           color: Colors.black12,
                            //           blurRadius: 10,
                            //           offset: Offset(0.0, 4.0)),
                            //     ],
                            //  ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            "updates".tr ,
                            style:  TextStyle(fontSize: 18, color: Colors.black87 ,fontWeight: FontWeight.bold),                          ),
                        ),

                          //  CustomButton(buttonText:  "updates".tr , onPressed: (){} ,buttonColor: Colors.white,textColor: Colors.black,),

                            getVerSpace(FetchPixels.getPixelHeight(20)),

                            shipmentController.shipmentDetails.isNotEmpty ?

                            ListView.builder(

                                primary: true,
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
                                itemCount: shipmentController.shipmentDetails[0].updatesList!.length,
                                itemBuilder: (context, index) {
                                  //  ModelBooking modelBooking = widget.shipmentList[index];
                                  return
                                    UpdateItemWidget(shipmentController.shipmentDetails[0].updatesList![index]) ;
                                }):SizedBox() ,

                          ],),


                   //        getVerSpace(FetchPixels.getPixelHeight(20)),
                   //
                   // widget.fromPriceOffer!?Column(mainAxisSize: MainAxisSize.min,children: [ getButtonWithIcon(context, Colors.white,
                   //          "prices_offers".tr, Colors.black, () {
                   //            // go to updates list
                   //            //    Get.to(UpdatesScreen(shipmentController.shipmentDetails[0].updatesList!)) ;
                   //          }, 18,
                   //          weight: FontWeight.w800,
                   //          buttonHeight: FetchPixels.getPixelHeight(72),
                   //          borderRadius: BorderRadius.circular(
                   //              FetchPixels.getPixelHeight(12)),
                   //          boxShadow: [
                   //            const BoxShadow(
                   //                color: Colors.black12,
                   //                blurRadius: 10,
                   //                offset: Offset(0.0, 4.0)),
                   //          ],
                   //          prefixIcon: false,
                   //          prefixImage: "headset.svg",
                   //          sufixIcon: false,
                   //          suffixImage: "arrow_right.svg"),
                   //        getVerSpace(FetchPixels.getPixelHeight(20)),
                   //
                   //   shipmentController.shipmentDetails.isNotEmpty &&
                   //       shipmentController.shipmentDetails[0].attachmentsLinks != null &&
                   //       shipmentController.shipmentDetails[0].attachmentsLinks!.isNotEmpty
                   //       ? priceOfferListView(shipmentController):SizedBox()]):SizedBox(),

                        ],
                      ),
                    )
                  ],
                )
            ) ,

          ],
        ),
             )  ;
    })
        ),
        onWillPop: () async {
          Navigator.of(context).pop();
          return false;
        });
  }
  /*Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(

          headers: <String, String>{'my_header_key': 'my_header_value'} ),
      browserConfiguration: const BrowserConfiguration(showTitle: true , ),

    )) {
      throw Exception('Could not launch $url');
    }
  }*/
  // Widget priceOfferListView(ShipmentController shipmentController) {
  //     return ListView.builder(
  //
  //       primary: true,
  //       shrinkWrap: true,
  //       physics: BouncingScrollPhysics(),
  //       //padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
  //       itemCount: shipmentController.shipmentDetails[0].priceOfferList!.length,
  //       itemBuilder: (context, index) {
  //         PriceOffer priceOffer =shipmentController.shipmentDetails[0].priceOfferList![index];
  //         return
  //           PriceOfferItem(priceOffer , shipmentController.shipmentDetails[0].changeState!) ;
  //
  //       },
  //     );
  //
  // }
}

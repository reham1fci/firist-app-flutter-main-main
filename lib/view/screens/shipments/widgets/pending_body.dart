import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/controllers/localization_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/model/shipment.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/resizer/fetch_pixels.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/screens/Requests/widget/request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'shipment_item.dart';


class PendingBody extends StatefulWidget {
  int? selectIndex ;
  String? type ;

  PendingBody({super.key , this.selectIndex , this.type });


  @override
  State<PendingBody> createState() => PendingBodyState();
}

class PendingBodyState extends State<PendingBody>  {
  // final AnimationController? animationController;
  final ShipmentController controller = Get.put(ShipmentController());
  final FingerPrintController fingerPrintController = Get.put(FingerPrintController());
  TextEditingController searchController = TextEditingController();
  List<Shipment> filteredData = []; // اللي هنعرضه في الليست بعد الفلترة

  ScrollController? _localScrollController;
  bool isFetching = false;
  Locale? myLocale  ;
  Set<int> selectedIndexes = {}; // لتخزين العناصر اللي متعلم عليها
  List <Shipment> data  = [] ;
  List <Shipment> selectData  = [] ;
  bool isLoading  = false  ;
  bool clearSelect = true ;
  @override
  void initState() {
    Get.find<ShipmentController>().pageWaiting = 1  ;
    // Get.find<ShipmentController>().selectedIndexes .clear() ;
    // Get.find<ShipmentController>().selectedShipments.clear()  ;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
    super.initState();
    controller.onRefreshUi = loadData;  // ربط الفانكشن

  }


  int slectedTab = 0;

  loadData() async {

    data = await  Get.find<ShipmentController>().getShipments(widget.type! ,  type: AppConstants.waiting , pageCount:Get.find<ShipmentController>().pageWaiting );
     if (clearSelect) {
    Get.find<ShipmentController>().selectedIndexes .clear() ;
     Get.find<ShipmentController>().selectedShipments.clear()  ;
     }
     else{
       setState(() {
         clearSelect= true ;

       });
     }
    filteredData = List.from(data);

    print("data.length") ;
    print(data.length) ;
    if(isLoading) {
      setState(() {
        isLoading = false  ;

      });
    }



  }
  void loadMore() async {
    print("Reached end of list, loading more...");
    setState(() {
      clearSelect= false ;
    });
    setState(() {
      isFetching = true;
    });
    await loadData().then((_) {
      setState(() {
        isFetching = false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    myLocale= Get.find<LocalizationController>().locale;
    print(myLocale!.languageCode) ;
    return GetBuilder<ShipmentController>(builder: (co) {
      return
      Scaffold(
         body:
             Column(children: [
     // Container( height:  60, child:
               getSearchWidget(

                   context, searchController,
            () {},
      (value) {
      filterSearch(value);
      },
      onSubmit: (submit) {
      filterSearch(submit);
      },),

           Expanded(child:   NotificationListener<ScrollEndNotification>(
                 onNotification: (scrollEnd) {
                   final metrics = scrollEnd.metrics;
                   if (metrics.pixels >= metrics.maxScrollExtent - 100 &&
                       !Get.find<ShipmentController>().isLoading &&
                       Get.find<ShipmentController>().hasMore &&
                       !isFetching) {
                     loadMore();
                   }
                   return true;
                 },
                 child: Container(
                   //   color: backGroundColor,
                   child: (co.isLoading && co.pageWaiting == 1)
                       ? const Center(child: CircularProgressIndicator())
                       : data.isEmpty
                       ? NullListview()
                       : getListView(),
                 ),
               ),)
             ],) ,

          bottomNavigationBar:
         SafeArea(child:  Container(
            width: double.infinity,
           height: 48, // نفس ارتفاع الزرار تقريباً

           margin: const EdgeInsets.all(12),
            child:  isLoading
                ? const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ):ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: ()  {
                receivedShipment(co) ;


                //  bool? isInside = await fingerPrintController.checkLocationReady(from: "shipments");
     //
     //  if (isInside == true ) {
     //   receivedShipment(co  , widget.type == AppConstants.showShipments? AppConstants.receivedShipment :AppConstants.receivedDriverShipment) ;
     //  }
     //  else if(isInside ==false ){
     //    showCustomSnackBar("${'out_company'.tr} ");
     //  }
     // /* else if(widget.type  == AppConstants.showShipmentsDriver ){  //السواقين
     //    receivedShipment(co) ;
     //
     //  }*/
     //   else{
     //
     //  }

      } ,

              child:  Text(
                "received".tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
       ));
    });
  }
  Widget getListView() {
    return GetBuilder<ShipmentController>(builder: (co) {
      return ListView.separated(
        controller: _localScrollController,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelWidth(80),
        ),
        itemCount: filteredData.length + (co.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < filteredData.length) {
            final shipment = filteredData[index];

            final isSelected = selectedIndexes.contains(index);

            return
             Column(
                  children: [
                    ShipmentItem(shipment , index),
                    const Divider(),
                  ],

            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
        separatorBuilder: (context, index) => const Divider(),
      );
    });
  }

  Column NullListview() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(40)),
        Center(child: getCustomFont("no_data_found".tr, 20, Colors.black, 1, fontWeight: FontWeight.w800)),
        getVerSpace(FetchPixels.getPixelHeight(10)),
      ],
    );
  }
   receivedShipment (ShipmentController co , ){
     if(co.selectedIndexes.isNotEmpty) {
       showOkDialog(context: context, message: "confirm_received".tr, isCancelBtn: true
             , onOkClick: () async {
             setState(() {
               isLoading = true ;
             });
             bool? isInside = await fingerPrintController.checkLocationReady(from: "shipments");
             if (isInside == true ) {
                co.receivedShipments(widget.type == AppConstants.showShipments? AppConstants.receivedShipment :AppConstants.receivedDriverShipment,AppConstants.waiting ) ;
             }
             else if(isInside ==false ){
               setState(() {
                 isLoading = false ;

               });
               showCustomSnackBar("${'out_location'.tr} ");
             }
             else if (isInside== null) {
               setState(() {
                 isLoading = false ;

               });
             }
             }) ;
     }
     else{
       showCustomSnackBar("select_shipment".tr) ;
     }
     // if(co.selectedIndexes.isNotEmpty) {
     //   showOkDialog(context: context, message: "confirm_received".tr, isCancelBtn: true
     //       , onOkClick: (){
     //         co.receivedShipments(requestName,AppConstants.waiting ) ;
     //
     //       }) ;
     // }
     // else{
     //   showCustomSnackBar("select_shipment".tr) ;
     // }
   }
  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredData = List.from(data);
      });
    } else {
      setState(() {
        filteredData = data.where((shipment) {
          final searchLower = query.toLowerCase();
          final id = shipment.requestId?.toString().toLowerCase() ?? "";
          final name = shipment.policy?.toLowerCase() ?? "";
          return id.contains(searchLower) || name.contains(searchLower);
        }).toList();
      });
    }
  }

}

import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/controllers/localization_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/model/shipment.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/resizer/fetch_pixels.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:betakety_app/view/base/color_resources.dart';
import 'package:betakety_app/view/base/custom_lert_dialog.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/screens/Requests/widget/request_item.dart';
import 'package:betakety_app/view/screens/home/widget/add_attachments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shipment_item.dart';


class ReceivedBody extends StatefulWidget {
  int? selectIndex ;
  String? type ;

  ReceivedBody({super.key , this.selectIndex  , this.type});


  @override
  State<ReceivedBody> createState() =>ReceivedBodyState();
}

class ReceivedBodyState extends State<ReceivedBody>  {
  // final AnimationController? animationController;
  final ShipmentController controller = Get.put(ShipmentController());
  final FingerPrintController fingerPrintController = Get.put(FingerPrintController());
  TextEditingController searchController = TextEditingController();
  List<Shipment> filteredData = [];
  ScrollController? _localScrollController;
  bool isFetching = false;
  Locale? myLocale  ;
  Set<int> selectedIndexes = {}; // لتخزين العناصر اللي متعلم عليها
  List <Shipment> data  = [] ;
  List <Shipment> selectData  = [] ;
  bool isLoading  = false  ;
  bool clearSelect = true ;

  @override
  void initState() {    super.initState();


  Get.find<ShipmentController>().pageProcessing = 1  ;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _loadData();
  });
  controller.onRefreshUi = _loadData;  // ربط الفانكشن

  }


  int slectedTab = 0;

  _loadData() async {

    data = await  Get.find<ShipmentController>().getShipments(widget.type! ,  type: AppConstants.processing , pageCount:Get.find<ShipmentController>().pageProcessing );
    filteredData = List.from(data);

    print("data.length") ;
    print(data.length) ;
    if (clearSelect) {
      Get
          .find<ShipmentController>()
          .selectedIndexes
          .clear();
      Get
          .find<ShipmentController>()
          .selectedShipments
          .clear();
    }else{
      setState(() {
        clearSelect  = true;
      });
    }
    if(isLoading) {
      setState(() {
        isLoading = false  ;


      });}

  }


  loadMore() async {
    setState(() {
      clearSelect= false ;
    });
    final controller = Get.find<ShipmentController>();
    controller.setFetching(true);
    await _loadData();
    controller.setFetching(false);
  }

  @override
  Widget build(BuildContext context) {
 //   myLocale= Get.find<LocalizationController>().locale;
     return GetBuilder<ShipmentController>(builder: (co) {
      return
        Scaffold(
            body:  Column(children: [
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

       Expanded(child:
       NotificationListener<ScrollEndNotification>(
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
                child: (co.isLoading && co.pageProcessing == 1)
                    ? Center(child: CircularProgressIndicator())
                    : data.isEmpty
                    ? NullListview()
                    : getListView(co),
              ),
            ))]),
            bottomNavigationBar:
            SafeArea(child:

            Row(children: [
            Expanded(child:     Container(
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
       //receivedShipment(co) ;
       //receivedShipment(co) ;
       if (widget.type ==AppConstants.showShipmentsDriver) {
    Get.to(() => AddAttachments())!.then((onValue){

       finishShipment(co:co , requestName  :AppConstants.receivedDriverShipment  , message: "confirm_finished") ;

       });}else {
         finishShipment(co: co,
             requestName:
             AppConstants.receivedShipment ,

             message: "confirm_finished");
       }

       //
       //              bool? isInside  = await fingerPrintController.checkLocationReady(from: "shipments");
       //
       //              if (isInside ==true  && widget.type  == AppConstants.showShipments) {
       //                 finishShipment(co: co , requestName: AppConstants.receivedShipment , message: "confirm_finished") ;
       //              }
       //              else if(isInside ==false  && widget.type  == AppConstants.showShipments) {
       //                showCustomSnackBar("${'out_company'.tr} ");
       //              }
       //           else if(widget.type  == AppConstants.showShipmentsDriver ) { //السواقين
       //                finishShipment(co: co , requestName: AppConstants.receivedDriverShipment , message: "confirm_finished") ;
       //              }
       // else{
       //              }
                  },
                  child:  Text(
                    widget.type == AppConstants.showShipmentsDriver ?
                    "delivered2".tr : "finished".tr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ) ),
              widget.type == AppConstants.showShipments ? // ف حالة المخلصين  لم  يتم الانهخاء
          Expanded(child:       Container(
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
                backgroundColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: ()  {
                //receivedShipment(co) ;

                finishShipment(co:co , requestName  :AppConstants.notFinishedShipment  , message: "confirm_not_finished") ;

     //            bool? isInside  = await fingerPrintController.checkLocationReady(from: "shipments");
     //
     //                if (isInside ==true  && widget.type  == AppConstants.showShipments ) {
     //                  finishShipment(co: co , requestName: AppConstants.notFinishedShipment , message: "confirm_not_finished") ;
     //                }
     //                else if(isInside ==false   && widget.type  == AppConstants.showShipments) {
     //                  showCustomSnackBar("${'out_company'.tr} ");
     //                }
     // else{
     //                }
                  },
                  child:  Text(
                   "not_finished".tr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ) ) :SizedBox()
            ],)


            ));
    });
  }
  Widget getListView(ShipmentController co) {

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

  }

  Widget NullListview() {
    return  Expanded(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(40)),
        Center(child: getCustomFont("no_data_found".tr, 20, Colors.black, 1, fontWeight: FontWeight.w800)),
        getVerSpace(FetchPixels.getPixelHeight(10)),
      ],
    ));
  }
  finishShipment ({ShipmentController? co , String? requestName  , String? message}){
    if(co!.selectedIndexes.isNotEmpty) {
      showOkDialog(context: context, message: message!.tr, isCancelBtn: true
          , onOkClick: () async {
            setState(() {
              isLoading = true ;

            });
          //  co.receivedShipments(requestName!,AppConstants.processing ) ;
            bool? isInside  = await fingerPrintController.checkLocationReady(from: "shipments");

            if (isInside ==true  && widget.type  == AppConstants.showShipments) {

            //  finishShipment(co: co , requestName: AppConstants.receivedShipment , message: "confirm_finished") ;
                co.receivedShipments(requestName!,AppConstants.processing ) ;

            }
            else if(isInside ==false  && widget.type  == AppConstants.showShipments) {
              setState(() {
                isLoading = false ;

              });
              showCustomSnackBar("${'out_location'.tr} ");
            }
            else if(widget.type  == AppConstants.showShipmentsDriver ) {
           //السواقين
          //    finishShipment(co: co , requestName: AppConstants.receivedDriverShipment , message: "confirm_finished") ;
              if(isInside !=null){
              co.driverDeliveredShipment() ;}

               else{
                setState(() {
                  isLoading = false ;

                });
              }

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

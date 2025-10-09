import 'package:betakety_app/controllers/localization_controller.dart';
import 'package:betakety_app/controllers/permission_controller.dart';
import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:betakety_app/model/shipment.dart';
import 'package:betakety_app/util/app_constants.dart';
import 'package:betakety_app/util/resizer/fetch_pixels.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:betakety_app/view/screens/Requests/widget/request_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'shipment_item.dart';


class AllShipmentBody extends StatefulWidget {
  int? selectIndex ;
  String? type ;

  AllShipmentBody({super.key , this.selectIndex   , this.type});


  @override
  State<AllShipmentBody> createState() => AllBodyState();
}

class AllBodyState extends State<AllShipmentBody>  {
  // final AnimationController? animationController;
  ScrollController? _localScrollController;
  bool isFetching = false;
  Locale? myLocale  ;
  Set<int> selectedIndexes = {}; // لتخزين العناصر اللي متعلم عليها
  List <Shipment> data  = [] ;
  List <Shipment> selectData  = [] ;
  TextEditingController searchController = TextEditingController();
  List<Shipment> filteredData = [];
  @override
  void initState() {
    Get.find<ShipmentController>().page = 1  ;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    super.initState();

  }


  int slectedTab = 0;

  _loadData() async {

    data = await  Get.find<ShipmentController>().getShipments(widget.type!  ,  type: AppConstants.all , pageCount:Get.find<ShipmentController>().page );
    filteredData = List.from(data);

    print("data.length") ;
    print(data.length) ;


  }
  void loadMore() async {
    print("Reached end of list, loading more...");
    setState(() {
      isFetching = true;
    });
    await _loadData().then((_) {
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
          child: (co.isLoading && co.page == 1)
              ? Center(child: CircularProgressIndicator())
              : data.isEmpty
              ? NullListview()
              : getListView(),
        ),
      ),
      )]));
    });
  }
  Widget getListView() {
    return GetBuilder<ShipmentController>(builder: (co) {
      return ListView.separated(
        controller: _localScrollController,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
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
                    ShipmentItem(shipment , index ,select: false,),
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
        getCustomFont("no_data_found".tr, 20, Colors.black, 1, fontWeight: FontWeight.w800),
        getVerSpace(FetchPixels.getPixelHeight(10)),
      ],
    );
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

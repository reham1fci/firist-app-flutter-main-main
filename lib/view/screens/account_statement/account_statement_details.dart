import 'dart:convert';

import 'package:betakety_app/controllers/account_controller.dart';
import 'package:betakety_app/model/account.dart';
import 'package:betakety_app/view/screens/home/widget/account_details_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountStatementDetails extends StatefulWidget{
  Account? accountData ;

  AccountStatementDetails(this.accountData);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _State() ;
  }

}
class _State extends State<AccountStatementDetails>{

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData() ;
  }

  bool loader = false;
  List<Account> dataList = [];

  _loadData() async {
    setState(() {
      loader = true;
    });
    var data = await  Get.find<AccountController>().getAccountStatementDetails(widget.accountData!);
    if (data != 'error') {
      setState(() {
          var list = data['data'] as List;
        for (int i = 0 ; i < list.length ; i ++){
          var   jsonObj=list [i];
          Account  w = Account.fromJsonDetails(jsonObj);
          setState(() {
            dataList.add(w);
          });
        }
      });
    }
    print(data);
    setState(() {
      loader = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('details'.tr),),
     body: GetBuilder<AccountController>(builder: (co) {
      return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loader
              ? Center(child: CircularProgressIndicator())
              : Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AccountDetailsItem(dataList ,index) ;
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: dataList.length),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );
    }));
  }


}
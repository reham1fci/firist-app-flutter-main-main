import 'dart:convert';

import 'package:betakety_app/controllers/account_controller.dart';
import 'package:betakety_app/model/account.dart';
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/screens/home/widget/debt_balance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountBalance extends StatefulWidget{
  const AccountBalance({super.key});

  @override
  State<AccountBalance> createState() => _AccountBalanceState();
}

class _AccountBalanceState extends State<AccountBalance> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData() ;
  }
  bool loader = false;

  List<Account> allData = [];
  List<Account> debitData = [];
  List<Account> custodyData = [];

  _loadData() async {
    setState(() {
      loader = true;
    });
    var data = await  Get.find<AccountController>().getAccountStatement();
    if (data != 'error') {
      setState(() {
       var list = jsonDecode(data)  ;
       for (int i = 0 ; i < list.length ; i ++){
         var   jsonObj=list [i];
         Account  w = Account.fromJson(jsonObj);
         setState(() {
           allData.add(w);
           if(w.type == "salf") {
debitData.add(w) ;
           }
           else{
custodyData.add(w) ;
           }
         });
       }
      });
    }
    print("1111111111111111111111111111111111111111111111111111111111111");
    print(data);

    setState(() {
      loader = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (co) {
      return
        loader
            ? Center(child: CircularProgressIndicator())
            :

           SingleChildScrollView(  child:Padding(
            padding: const EdgeInsets.all(15), child:
        Expanded(child:  Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'debit_balance'.tr,
                style: fontSizeMedium.copyWith(
                    color: kTitleColor, fontWeight: FontWeight.bold),
              ),

              DebtBalance(debitData),

              Divider(color: Colors.black,),
              Text(
                'custody_balance'.tr,
                style: fontSizeMedium.copyWith(
                    color: kTitleColor, fontWeight: FontWeight.bold),
              ), DebtBalance(custodyData),
            ],
          ),
          )),) ;
    });
}}
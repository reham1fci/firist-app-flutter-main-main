import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../util/constant.dart';
import '../util/styles.dart';

class ListLayouts extends StatefulWidget {
  const ListLayouts({Key? key}) : super(key: key);

  @override
  _ListLayoutsState createState() => _ListLayoutsState();
}

class _ListLayoutsState extends State<ListLayouts> {
  Future<dynamic> getData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://marsalogistics.com/new/resting/api/show_request_permission_api_mohran.php'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return "error";
      }
    } catch (e) {
      print("Error: $e");
      return "error";
    }
  }

  @override
  void initState() {
    _loadData();

    super.initState();
  }

  List<dynamic> viewdata = [];
  _loadData() async {
    var data = await getData();
    if (data != 'error') {
      setState(() {
        viewdata = (data['data'] as List);
      });
    }
    print("1111111111111111111111111111111111111111111111111111111111111");
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFirstColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kTitleColor),
        centerTitle: true,
        title: Text(
          'List Layout moh123',
          style: kTextStyle,
        ),
        backgroundColor: kFirstColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(

        child: Column(
          children: [
            Text(
              'This is the example of List Layout ${viewdata.length}',
              style: kTextStyle.copyWith(color: kGreyTextColor),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: Center(
                      child: viewdata == null || viewdata.isEmpty
                          ? CircularProgressIndicator()
                          : ListView.separated(
                              separatorBuilder: (context, index) => Divider(),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: viewdata.length,
                              itemBuilder: (context, index) {
                                //  print(viewdata[index]['request_per_type']);
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: kGreyTextColor.withOpacity(0.5)),
                                  ),
                                  child: ListTile(
                                    leading: Image.asset('images/person.png'),
                                    title: Text(
                                      viewdata[index]['request_per_type']
                                          .toString()
                                          .tr,
                                      style: fontSizeBlack,
                                    ),
                                    subtitle: Text(
                                      viewdata[index]['request_per_details'],
                                      style: kTextStyle.copyWith(
                                          color: kGreyTextColor),
                                    ),
                                    trailing: const Icon(
                                      Icons.attachment,
                                      color: kGreyTextColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    
    );
  }
}

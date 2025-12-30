import 'package:betakety_app/model/pending_check.dart';
import 'package:betakety_app/view/base/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingPopup extends StatelessWidget {
  final PendingCheck pendingCheck;

  const PendingPopup({super.key, required this.pendingCheck});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(pendingCheck.message) ,
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoItem("pending_requests".tr, pendingCheck.countRequests),
                  _infoItem("pending_forms".tr, pendingCheck.countForms),
                  _infoItem("pending_total".tr, pendingCheck.totalAll),

                ],
              ),

              const SizedBox(height: 16),

               TabBar(
                tabs: [
                  Tab(text: "pending_requests".tr),
                  Tab(text: "pending_forms".tr),
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 200,
                child: TabBarView(
                  children: [
                    _buildList(pendingCheck.requestIds),
                    _buildList(pendingCheck.formIds),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child:  Text("close".tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(String title, int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: ColorResources.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(title),
      ],
    );
  }

  Widget _buildList(List<String> items) {
    if (items.isEmpty) {
      return  Center(
        child: Text("no_data".tr),
      );
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        return ListTile(
          leading:  Icon(Icons.info_outline),
            title: Text("${'id'.tr}: ${items[index]}"),
        );
      },
    );
  }
}

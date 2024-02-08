// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../view/base/animated_custom_dialog.dart';
import '../view/base/custom_divider.dart';
import '../controllers/permission_controller.dart';
import '../util/dimensions.dart';
import '../model/requests_permissions_model.dart';
import '../util/styles.dart';
import 'add_request_permission.dart';

class PermissionRequestScreen extends StatefulWidget {
  const PermissionRequestScreen({super.key});

  @override
  State<PermissionRequestScreen> createState() =>
      _PermissionRequestScreenState();
}

class _PermissionRequestScreenState extends State<PermissionRequestScreen> {
  @override
  void initState() {
    // Get.find<PermissionController>().getRequestsPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PermissionController>(builder: (pController) {
      return Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: Dimensions.RADIUS_LARGE,
            ),
            pController.isGetRequestsPermissions
                ? Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      SpinKitCircle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  )
                : pController.isGetRequestsPermissionsError
                    ? Text("No Data")
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              // Get.find<PermissionController>()
                              //     .getRequestsPermissions();
                            },
                            child: ListView.builder(
                              itemCount: pController.selectedIndex == 0
                                  ? pController.waitingList.length
                                  : pController.donePorcceningList.length,
                              itemBuilder: (context, index) {
                                RequestsPermissionsModel request =
                                    pController.selectedIndex == 0
                                        ? pController.waitingList[index]
                                        : pController.donePorcceningList[index];

                                return GestureDetector(
                                  onTap: () {
                                    // showAnimatedDialog(
                                    //     context,
                                    //     AttachmentDialog(
                                    //       attachments: request.attatchement,
                                    //     ));
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .PADDING_SIZE_MEDIUM_BORDER,
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_MEDIUM_BORDER,
                                          ),
                                          Text(
                                            'request_permission'.tr,
                                            style: fontSizeBlack,
                                          ),
                                          const SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_MEDIUM_BORDER,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                title: "type".tr,
                                                value:
                                                    request.requestPerType!.tr,
                                              ),
                                              CustomText(
                                                title: "request_type".tr,
                                                value: request.requestType!
                                                    .toLowerCase()
                                                    .tr,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_MEDIUM_BORDER,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                title: "from_time".tr,
                                                value:
                                                    request.requestPerTimeFrom!,
                                              ),
                                              CustomText(
                                                title: "to_time".tr,
                                                value:
                                                    request.requestPerTimeTo!,
                                              ),
                                              SizedBox()
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                title: "date".tr,
                                                value: request.requestPerDate!,
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_DEFAULT),
                                            child: CustomDivider(
                                              height: 1,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_MEDIUM_BORDER,
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: CustomText(
                                                title: "details".tr,
                                                value:
                                                    request.requestPerDetails!),
                                          ),
                                          const SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_MEDIUM_BORDER,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      )
          ],
        ),
      );
    });
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '$title : ',
        style: const TextStyle(fontWeight: FontWeight.w700),
        children: <TextSpan>[
          TextSpan(
              text: value, style: const TextStyle(fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}

class CustomeAppBarButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomeAppBarButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: RawMaterialButton(
        onPressed: onPressed,
        elevation: 0.0,
        fillColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.add,
              size: 24.0,
              color: Colors.white,
            ),
            const SizedBox(width: 8.0),
            Text(
              'add'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class AttachmentDialog extends StatelessWidget {
  final List<AttatchementModel>? attachments;

  const AttachmentDialog({Key? key, this.attachments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'attachments'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            attachments != null && attachments!.isNotEmpty
                ? ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: attachments!.length,
                    itemBuilder: (context, index) {
                      final attachment = attachments![index];
                      return attachment.attachLink != null &&
                              (attachment.attachLink!.endsWith('.jpg') ||
                                  attachment.attachLink!.endsWith('.png'))
                          ? Center(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(FullImageScreen(
                                    imageUrl: attachment.attachLink!,
                                  ));
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: Get.height / 4,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 3.0,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: CustomImage(
                                            fit: BoxFit.cover,
                                            image: attachment.attachLink,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: IconButton(
                                        onPressed: () {
                                          if (attachment.attachLink != null) {
                                            launchUrl(
                                              Uri.parse(attachment.attachLink!),
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          }
                                        },
                                        icon: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Icon(
                                            Icons.open_in_new,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      '${"display".tr} ${'file'.tr} ${'number'.tr} ${index + 1}'),
                                  CustomButton(
                                    width: Get.width / 4,
                                    buttonText: 'display'.tr,
                                    onPressed: () {
                                      if (attachment.attachLink != null) {
                                        launchUrl(
                                          Uri.parse(attachment.attachLink!),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('no_attachments'.tr),
                  ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final String imageUrl;
  const FullImageScreen({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBarX(
            title: '',
          ),
          Expanded(
            child: Center(
              child: InteractiveViewer(
                maxScale: 5.0,
                child: Image.network(imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
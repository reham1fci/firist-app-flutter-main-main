
import 'dart:io';

import 'package:betakety_app/controllers/fingerprint_controller.dart';
import 'package:betakety_app/controllers/maintenance_controller.dart';
import 'package:betakety_app/main.dart';
import 'package:betakety_app/model/login_model.dart';
import 'package:betakety_app/model/maintenance.dart';
import 'package:betakety_app/util/dimensions.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/view/base/custom_field_with_title.dart';
import 'package:betakety_app/view/base/custom_snackbar.dart';
import 'package:betakety_app/view/base/custom_text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller.dart';
import '../../../util/constant.dart';
import '../../../util/images.dart';
import '../../base/custom_button.dart';

class AddMaintenanceRequest extends StatefulWidget {
  const AddMaintenanceRequest({super.key});

  @override
  State<AddMaintenanceRequest> createState() => AddRequestState();
}

class AddRequestState extends State<AddMaintenanceRequest> {
  String languageCode  ="ar";
   Position? currentLocation  ;
 getCurrentLocation() async {
    Get.put(FingerPrintController() );
    Get.find<FingerPrintController>().checkPermission();
    currentLocation = await Geolocator .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(currentLocation);

  }
 @override
  void initState() {
    // TODO: implement initState
   Get.find<MaintenanceController>().resetData();

   getCurrentLocation() ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

      return GetBuilder<MaintenanceController>(builder: (maintainController) {
        return  Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kTitleColor),
            centerTitle: true,
            title: Text('add_maintenance_request'.tr, style: fontSizeMedium),
            backgroundColor: Colors.white,
            elevation: 2.0,
          ),
          body: SafeArea(child:LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      child: Column(
                        children: [
                          CustomFieldWithTitle(
                            requiredField: true,
                            title: "cost".tr,
                            customTextField: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: CustomTextField(
                                  maxLines: 1,
                                  hintText: 'cost'.tr,
                                  inputType: TextInputType.text,
                                  controller: maintainController.costController,
                                )),
                          ),
                          const SizedBox(height: 16),
                          _buildSectionCard(
                            context,
                            title: 'car_images'.tr,
                            icon: Icons.directions_car_filled,
                            images: maintainController.carImages,
                            onAdd: () => maintainController.pickImage(fileName: 'car[]', imagesList: maintainController.carImages),
                            onRemove: (index) => maintainController.removeImage(index, maintainController.carImages),
                          //  maxHeight: constraints.maxHeight * 0.45,
                          ),
                          const SizedBox(height: 16),

                          _buildSectionCard(
                            context,
                            title: 'invoice_images'.tr,
                            icon: Icons.receipt_long,
                            images: maintainController.invoiceImages,
                            onAdd: () => maintainController.pickImage(fileName: 'invoice[]', imagesList: maintainController.invoiceImages),
                            onRemove: (index) => maintainController.removeImage(index, maintainController.invoiceImages),
                           // maxHeight: constraints.maxHeight * 0.45,
                          ),
                          CustomFieldWithTitle(
                            requiredField: false,
                            title: "details".tr,
                            customTextField: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: CustomTextField(
                                  maxLines: 2,
                                  hintText: 'details'.tr,
                                  inputType: TextInputType.text,
                                  controller: maintainController.detailsController,
                                )),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 16,
                    right: 16,
                    child: maintainController.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : CustomButton(
                      buttonText: "save".tr,
                      onPressed: () async {
                         if(maintainController.costController.text.isEmpty){
                           showCustomSnackBar('cost'.tr);
                           return;
                         }
                         else if (maintainController.carImages.isEmpty) {
                           showCustomSnackBar('car_images'.tr);
                          return;
                        } else if (maintainController.invoiceImages.isEmpty) {
                          showCustomSnackBar('invoice_images'.tr);
                          return;
                        }



                        try {
                          Maintenance body = Maintenance(
                            lat: currentLocation!.latitude,
                            lng: currentLocation!.longitude,
                             cost:double.parse( maintainController.costController.text ) ,
                            details:  maintainController.detailsController.text
                          );

                          LoginResponsModel user = await AuthController().getLoginData();

                          await maintainController.addMaintenanceRequest(
                            body.maintenanceToJson(user.id!),
                          );

                          // Success => optionally navigate or show success message
                        } catch (e) {
                          showCustomSnackBar('حدث خطأ أثناء الإرسال');
                        } finally {
                          setState(() {
                            maintainController.isLoading = false;
                          });
                        }
                      },
                    ),
                  )

                ],
              );
            },
          ),
        ));});

      }

  Widget _buildSectionCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List images,
        required VoidCallback onAdd,
        required Function(int) onRemove,
        // ❌ هنشيل maxHeight
      }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),

            /// ✅ بقى shrinkWrap ListView
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: images.length + 1,
              itemBuilder: (context, index) {
                return index == images.length
                    ? _buildAddImageButton(context, onAdd)
                    : _buildImageItem(context, images[index].path, () => onRemove(index));
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildAddImageButton(BuildContext context, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[200],
        ),
        height: MediaQuery.of(context).size.width / 4.3,
        width: double.infinity,
        child: Center(
          child: Icon(Icons.add_a_photo, size: 32, color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Widget _buildImageItem(BuildContext context, String path, VoidCallback onDelete) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(path),
              width: double.infinity,
              height: MediaQuery.of(context).size.width / 4.3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: onDelete,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(4),
              child: const Icon(Icons.close, size: 18, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

}

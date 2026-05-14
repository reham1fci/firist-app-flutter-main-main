import 'package:betakety_app/controllers/shipment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/permission_controller.dart';

Future<String?> showFileSourceDialog(
    BuildContext context,
    PermissionController controller,
    String key,
{TextEditingController? controllerName,}
    ) async {

  return await showDialog<String>(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "اختيار مصدر الصورة",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  /// 📷 Camera
                  _buildOptionButton(
                    context: context,
                    icon: Icons.camera_alt_rounded,
                    label: "camera".tr,
                    onTap: () async {
                      TextEditingController fileNameController =
                      TextEditingController();

                      String? path;

                      if (key == "options_files[]") {
                        path = await controller.pickImageFromCamera(
                          controllerName!,
                          key,
                          nameDialog: false,
                        );
                        Navigator.pop(context, path); // 👈 رجّعي القيمة هنا

                      } else {
         Navigator.pop(context);
                        path = await controller.pickImageFromCamera(
                          fileNameController,
                          key,
                          nameDialog: true,
                        );
                      }

                    },
                  ),

                  /// 🖼 Gallery
                  _buildOptionButton(
                    context: context,
                    icon: Icons.photo_library_rounded,
                    label: "gallery".tr,
                    onTap: () async {
                      TextEditingController fileNameController =
                      TextEditingController();

                      String? path;

                      if (key == "options_files[]") {
                        path = await controller.selectSingleFile(
                          controllerName!,
                          key,
                        );
                        Navigator.pop(context, path); // 👈 رجّعي القيمة هنا

                      } else {
     Navigator.pop(context);
                        path = await controller.selectSingleFileWithName(
                          fileNameController,
                          key,
                        );
                      }

                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () => Navigator.pop(context, null),
                child: Text(
                  "إلغاء",
                  style: TextStyle(color: Colors.redAccent),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildOptionButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required BuildContext context
}) {
  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: onTap,
    child: Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: Theme.of(context).primaryColor),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

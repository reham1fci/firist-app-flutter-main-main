import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachView extends StatelessWidget {
  String? url ;

  AttachView(this.url);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
        Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kTitleColor),
            centerTitle: true,
            title: Text(
              'attachment'.tr,
              style: fontSizeMedium,
            ),
            actions: const [
              SizedBox(
                width: 5.0,
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 2.0,
          ),
          body: Image.network(url!,width: double.infinity,
              height: double.infinity,
    fit: BoxFit.fill,
    loadingBuilder: (BuildContext context, Widget child,
    ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    } ) ) ;
  }

}
import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class AttachView extends StatefulWidget {
  String? url ;

  AttachView(this.url);

  @override
  State<AttachView> createState() => _AttachViewState();
}

class _AttachViewState extends State<AttachView> {
  String? s="" ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.url!.isNotEmpty){
      int start   = (widget.url!.length )-3 ;
      String s  =widget.url!.substring( start)  ;
      print(s);
    }
  }
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
          body:s=="pdf" ?

          PDFView(
            filePath: widget.url,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: false,
            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },

          ):

          Image.network(widget.url!,width: double.infinity,
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
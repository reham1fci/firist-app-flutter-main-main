import 'package:betakety_app/util/constant.dart';
import 'package:betakety_app/util/resizer/fetch_pixels.dart';
import 'package:betakety_app/util/styles.dart';
import 'package:betakety_app/util/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AttahmentViewScreen extends StatefulWidget {

   String? url  ;
   String? name  ;
   //Attachment? attachment ;
   AttahmentViewScreen({this.url , this.name });

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<AttahmentViewScreen> {
  //WebViewController? controller  ;
  String finalUrl = "";
  bool isLoading = true;
  late InAppWebViewController webController;
  bool visable = false  ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     print(widget.url!) ;
    print("https://docs.google.com/viewer?url="+widget.url!) ;
    print(widget.url!) ;
     finalUrl = widget.url!;
    if (finalUrl.endsWith(".pdf")) {
     finalUrl = "https://docs.google.com/viewer?embedded=true&url=${widget.url}";
    }
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   webController.reload();
    // });
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //  ..setNavigationDelegate(
    //  NavigationDelegate(
    //  onProgress: (int progress) {
    //  // Update loading bar.
    //  },
    //  onPageStarted: (String url) {},
    //  onPageFinished: (String url) {},
    //  onWebResourceError: (WebResourceError error) {},
    //  onNavigationRequest: (NavigationRequest request) {
    //  if (request.url.startsWith('https://www.youtube.com/')) {
    //  return NavigationDecision.prevent;
    //  }
    //  return NavigationDecision.navigate;
    //  },
    //  ),
    //  )
    //  ..loadRequest(Uri.parse("https://docs.google.com/viewer?url="+widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kTitleColor),
        centerTitle: true,
        title: Text(
          'attachments'.tr,
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
      body: Column(
        children: [

          // اسم الملف أو الصورة بشكل شيك
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(20),
                vertical: FetchPixels.getPixelHeight(10)),
            child: Text(
              widget.name ?? "",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),

          // WebView + Loading
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri(finalUrl),
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true,
                    ),
                  ),
                    onWebViewCreated: (controller) {
                      print("✅ WebView Created");
                      webController = controller;
                    },
                    onLoadStart: (controller, url) {
                      print("🚀 Started loading: $url");
                      setState(() {
                        isLoading = true;
                         visable = true  ;
                      });
                    },
                    onLoadStop: (controller, url) async {
                      print("✅ Finished loading: $url");
                      setState(() {
                        isLoading = false;
                         if(!visable) {
                           Navigator.pop(context);

                           // ونعيد فتحها من جديد
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => AttahmentViewScreen(url: widget.url, name: widget.name)),
                           );
                         }
                      });
                    },
                    onLoadError: (controller, url, code, message) {
                      print("❌ Error loading $url: $message");
                      setState(() {
                        isLoading = false;
                      });
                    },)  ,
                if (isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );


  }

}

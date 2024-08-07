import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/controllers/order_controller.dart';
import 'package:multivendor_app/widgets/order/PaymentFailed.dart';
import 'package:multivendor_app/widgets/order/SuccessFul.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({super.key});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
 late final WebViewController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final orderController=Get.put(OrderController());
   late final PlatformWebViewControllerCreationParams params;
   if(WebViewPlatform.instance is WebKitWebViewPlatform){
    params=WebKitWebViewControllerCreationParams(
      allowsInlineMediaPlayback: true,
      mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{}
    );

   }else{
    params=const PlatformWebViewControllerCreationParams();
    
   }
   final WebViewController controller=WebViewController.fromPlatformCreationParams(params);
   controller..setJavaScriptMode(JavaScriptMode.unrestricted)..setBackgroundColor(Color(0x00000000))..setNavigationDelegate(
    NavigationDelegate(
      onPageStarted:(String url){

    },
    onPageFinished:(String url){
      
    },
    onNavigationRequest: (NavigationRequest request){
      return NavigationDecision.navigate;
    },
    onUrlChange: (UrlChange change){
      if(change.url!.contains("checkout-success")){
        orderController.setPaymentUrl='';
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccessFul()));
      } else if(change.url!.contains("cancel")){
        orderController.setPaymentUrl='';
 Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentFailed()));
      }
    }
    )
   )..addJavaScriptChannel('Toaster', onMessageReceived: (JavaScriptMessage message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message.message))
    );
   })..loadRequest(Uri.parse(orderController.paymentUrl));
   if(controller.platform is AndroidWebViewController){
    AndroidWebViewController.enableDebugging(true);
    (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
   }
   _controller=controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 20,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
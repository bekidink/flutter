import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/controllers/phone_controller.dart';
import 'package:multivendor_app/services/verification_services.dart';
import 'package:phone_otp_verification/phone_verification.dart';

import '../../common/app_style.dart';
import '../../constants/constants.dart';

class PhoneVerificationPage extends StatefulWidget {
   PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
VerificationServices _verificationServices=VerificationServices();

    final controller=Get.put(PhoneController());

    String _verification='';

  @override
  Widget build(BuildContext context) {
    
    return Obx(() => controller.isLoading==false? PhoneVerification(
      isFirstPage: false,
      enableLogo: false,
      themeColor: const Color.fromARGB(255, 50, 55, 65),
      backgroundColor: kLightWhite,
      initialPageText: "Verify Phone Number",
      initialPageTextStyle: appStyle(20,kPrimary,FontWeight.bold),
      textColor: kDark,
      onSend: (String value) {
    controller.setPhone=value;
    _verifyPhoneNumber(value);
      },
      onVerification: (String value) {
        submitVerificationCode(value);
      },
    ):Container(
      width: width,
      height: height,
      color: kLightWhite,
      child: CircularProgressIndicator(),));
  }

void _verifyPhoneNumber(String phoneNumber)async{
await _verificationServices.verifyPhoneNumber(controller.phone, codeSent: (String verificationId,int? resendToken){
setState(() {
  _verification=verificationId;
});
});
}
void submitVerificationCode(String code)async{
  await _verificationServices.verifySmsCode(_verification, code);
}
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/controllers/phone_controller.dart';
final FirebaseAuth _auth=FirebaseAuth.instance;
void setFirebaseLocale(String locale) {
  _auth.setLanguageCode(locale);
}
class VerificationServices{
  final controller=Get.put(PhoneController());
  
  
  Future<void>verifyPhoneNumber(String phoneNumber,{required Null Function(String verificationId,int? resendToken)codeSent}) async{
    setFirebaseLocale('en');
    await _auth.verifyPhoneNumber(verificationCompleted: (PhoneAuthCredential credentials) async{
      debugPrint('Verification completed with credentials: $credentials');
      // controller.verifyPhone();
    }, verificationFailed: (FirebaseAuthException e){
      debugPrint('Verification failed: ${e.message}');
    }, codeSent: (String verificationId,int? resendToken){
      debugPrint('Code sent to $phoneNumber $resendToken');
      codeSent(verificationId,resendToken);
    }, codeAutoRetrievalTimeout: (String verificationId){
debugPrint('Code auto retrieval timeout for $verificationId');
    },phoneNumber: phoneNumber,timeout: Duration(seconds: 60));
  }
  Future<void> verifySmsCode(String verificationId,String smsCode)async{
 PhoneAuthCredential credential=PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
 print(credential);
await _auth.signInWithCredential(credential).then((value) {
  controller.verifyPhone();
});
  }
}
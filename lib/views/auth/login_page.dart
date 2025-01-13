import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/backgroundContainer.dart';
import 'package:multivendor_app/common/custom_button.dart';
import 'package:multivendor_app/common/email_text_field.dart';
import 'package:multivendor_app/common/password_text_filed.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/login_controller.dart';
import 'package:multivendor_app/model/fetch_model/LoginModel.dart';
import 'package:multivendor_app/views/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 late final TextEditingController editingController=TextEditingController();
 late final TextEditingController passwordController=TextEditingController();
 final FocusNode _passwordFocusNode=FocusNode();
 @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocusNode.dispose();
    editingController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(LoginController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimary,
        title: Center(
          child: ReusableText(style: appStyle(20,kLightWhite,  FontWeight.bold),text: 'Foodly Family',),
        ),
      ),
      body: BackGroundContainer(color: kOffWhite, child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.r),
          topLeft: Radius.circular(30.r)
        ),
        child: ListView(
          children: [
            Lottie.asset('assets/anime/delivery.json')
          ,
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              EmailTextField(
hintText: 'Email',
prefixIcon: const Icon(CupertinoIcons.mail,size: 22,color: kGrayLight,),
controller: editingController,

              ),
              SizedBox(
                height: 25.h,
              ),
             PasswordTextField(
controller: passwordController,
             ),
             
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector
                    (
                      onTap: (){
                        Get.to(()=>const RegisterPage());
                      },
                      child: ReusableText(style: appStyle(12, Colors.blue, FontWeight.normal), text: 'Sign Up')),
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomButton(
                text:  'L O G I N' ,
                onTap: () {
                 if(editingController.text.isNotEmpty && passwordController.text.length>=8){
                  LoginModel model=LoginModel(email: editingController.text, password: passwordController.text);
                  String data=loginModelToJson(model);
                  controller.loginFunction(data);
                  
                 }
                },
                btnHeight: 40.h,
                btnWidth: width,
              ),
              
            ],
          ),
          )
          ],
        ),
      ))
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_app/model/fetch_model/RegisterModel.dart';

import '../../common/app_style.dart';
import '../../common/backgroundContainer.dart';
import '../../common/custom_button.dart';
import '../../common/email_text_field.dart';
import '../../common/password_text_filed.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';
import '../../controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
 late final TextEditingController editingController=TextEditingController();
 late final TextEditingController passwordController=TextEditingController();
 final FocusNode _passwordFocusNode=FocusNode();
 late final TextEditingController usernameController=TextEditingController();
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
    final controller=Get.put(RegisterController());
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
hintText: 'User Name',
prefixIcon: const Icon(CupertinoIcons.person_2,size: 22,color: kGrayLight,),
controller: usernameController,

              ),
               SizedBox(
                height: 25.h,
              ),
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

                      },
                      child: ReusableText(style: appStyle(12, Colors.blue, FontWeight.normal), text: 'Sign In')),
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomButton(
                text: 'R E G I S T E R',
                onTap: () {
                 if(editingController.text!.isNotEmpty && usernameController.text!.isNotEmpty && passwordController.text.length>=8){
                  RegisterModel model=RegisterModel(email: editingController.text, password: passwordController.text,username: usernameController.text);
                  String data=registerModelToJson(model);
                  controller.registerFunction(data);
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
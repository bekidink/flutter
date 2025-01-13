import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_app/common/custom_button.dart';
import 'package:multivendor_app/controllers/login_controller.dart';
import 'package:multivendor_app/model/fetch_model/LoginResponse.dart';
import 'package:multivendor_app/views/auth/login_redirect.dart';
import 'package:multivendor_app/views/orders/user_orders.dart';
import 'package:multivendor_app/widgets/profile/address_page.dart';
import 'package:multivendor_app/widgets/profile/profile_appbar.dart';
import 'package:multivendor_app/widgets/profile/profile_title.dart';
import 'package:multivendor_app/widgets/profile/user_widget.dart';

import '../../common/custome_container.dart';
import '../../constants/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;
    final controller=Get.put(LoginController());
    final box=GetStorage();
    String?token=box.read("token");
    if(token !=null){
     user=controller.getUserInfo();
    }
    if(token==null){
      Get.to(()=>const LoginRedirect());
    }
    // if(user!=null && user.verification==false){
    //   return const VerificationPage();
    // }
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: PreferredSize(preferredSize: Size.fromHeight(50.h), child:const ProfileAppBar()),
   body: SafeArea(child: CustomContainer(widgetContent:Column(
    children: [
      SizedBox(
        height: 10.h,

      ),
      Container(
        height: 175.h,
        decoration: const BoxDecoration(
          color: kLightWhite
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            UserInfoWidget(user: user,),
            ProfileTileWidget(title: "My Orders", icon:Ionicons.fast_food_outline,onTap: (){
              Get.to(()=>const UserOrders(),transition: Transition.rightToLeft,duration: const Duration(
                milliseconds: 500
              ));
            }, ),
             ProfileTileWidget(title: "My Favorite", icon:Ionicons.heart_outline,onTap: (){}, ),
              ProfileTileWidget(title: "Review", icon:Ionicons.chatbubble_outline,onTap: (){}, ),
               ProfileTileWidget(title: "Coupons", icon:MaterialCommunityIcons.tag_outline,onTap: (){}, ),

          ],
        ),
      )
   
   
   ,
    SizedBox(
        height: 10.h,

      ),
      Container(
        height: 215.h,
        decoration: const BoxDecoration(
          color: kLightWhite
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ProfileTileWidget(title: "Shipping Address", icon:SimpleLineIcons.location_pin,onTap: (){
              Get.to(()=>const AddressPage(),transition: Transition.rightToLeft,duration: const Duration(
                milliseconds: 500
              ));
            }, ),
             ProfileTileWidget(title: "Service Center", icon:AntDesign.customerservice,onTap: (){}, ),
              ProfileTileWidget(title: "App FeedBack", icon:Ionicons.chatbubble_outline,onTap: (){}, ),
               ProfileTileWidget(title: "Coupons", icon:MaterialIcons.rss_feed,onTap: (){}, ),
              ProfileTileWidget(title: "Settings", icon:AntDesign.setting,onTap: (){}, ),
             
          ],
        ),
      )
   ,
   SizedBox(height:20.h ,),
    CustomButton(text: 'Logout',btnColor: kRed,onTap: (){
      controller.logout();
    },)
   
    ],
   ) )),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/model/fetch_model/cartResponse.dart';
import 'package:multivendor_app/widgets/cart/cart_tile.dart';
import 'package:multivendor_app/widgets/shimmers/FoodListShimmer.dart';

import '../../common/custome_container.dart';
import '../../constants/constants.dart';
import '../../controllers/login_controller.dart';
import '../../fetch/fetch_cart.dart';
import '../../model/fetch_model/LoginResponse.dart';
import '../auth/login_redirect.dart';

class CartPage extends HookWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;
    final controller=Get.put(LoginController());
    final box=GetStorage();
    final hookResult=useFetchCart();
    print(hookResult.data);
    final List<CartResponse> carts=hookResult.data ?? [];
    final isLoading=hookResult.isLoading;
    final error=hookResult.error;
    final refetch=hookResult.refetch;
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        title: ReusableText(style:appStyle(14, kGray, FontWeight.w600),text: "Cart"),
      ),
    body: SafeArea(child: CustomContainer(widgetContent:isLoading?const FoodShimmer(): SizedBox(
      height: height,
      width: width,
      child: ListView.builder(
        itemCount: carts.length,
        itemBuilder: (context,i){
          var cart=carts[i];
return CartTile(
  color: kLightWhite,
  cart: cart,refetch: refetch,);
      }),
    ) )),
    );
  }
}
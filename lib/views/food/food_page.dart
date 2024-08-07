import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/custom_button.dart';
import 'package:multivendor_app/common/custom_text_field.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/cart_controller.dart';
import 'package:multivendor_app/controllers/food_controller.dart';
import 'package:multivendor_app/controllers/login_controller.dart';
import 'package:multivendor_app/fetch/fetch_default.dart';
import 'package:multivendor_app/fetch/fetch_restaurant.dart';
import 'package:multivendor_app/model/fetch_model/AddressResponse.dart';
import 'package:multivendor_app/model/fetch_model/LoginResponse.dart';
import 'package:multivendor_app/model/fetch_model/Restaurant.dart';
import 'package:multivendor_app/model/fetch_model/cartRequest.dart';
import 'package:multivendor_app/model/fetch_model/cartResponse.dart';
import 'package:multivendor_app/model/fetch_model/foodModel.dart';
import 'package:multivendor_app/views/auth/login_page.dart';
import 'package:multivendor_app/views/orders/order_page.dart';
import 'package:multivendor_app/views/restaurants/restaurant_page.dart';
import 'package:multivendor_app/widgets/profile/shipping_page.dart';

import '../../common/address_bottom_sheet.dart';
import '../../model/fetch_model/OrderRequest.dart';
import '../Verification/phone_verification_page.dart';

class FoodPage extends HookWidget {
 FoodPage({super.key, required this.food});
  final FoodModel food;

  

  @override
  Widget build(BuildContext context) {
    LoginResponse? user;
    final pageController=PageController();
    final TextEditingController preferences=TextEditingController();
    final hookResult=useFetchRestaurant(food.restaurant);
    RestaurantModel? restaurant=hookResult.data;
    final loginController=Get.put(LoginController());
    final controller=Get.put(FoodController());
    user=loginController.getUserInfo();
    controller.loadAdditivesList(food.additives);
    final cartController=Get.put(CartController());
    final box=GetStorage();
    var defaultaddress=box.read('defaultAddress');
    final data=useFetchDefault();
    AddressResponse? address=data.data;


    return  Scaffold(
      body: ListView(
        
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.r),
                
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 230.h,
                    child: PageView.builder(controller: pageController,onPageChanged:(i){
                      controller.changePage(i);
                    } , itemCount: food.imageUrl.length, itemBuilder: (context,i){
                      return Container(
                        width: width,
                        height: 230.h,
                        color: kLightWhite,
                        child: CachedNetworkImage(imageUrl: food.imageUrl[i],fit: BoxFit.cover,),
                      );
                    }),
                  ),
                  Positioned(
                    bottom: 10,
                    child:
                    Obx(() =>  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(food.imageUrl.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(left: 12),
                          width: 10.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            // ignore: unrelated_type_equality_checks
                            shape: BoxShape.circle,color:controller.currentPage==index? kSecondary:kGray
                          ),
                        );
                      }),
                    ))
                    ),
                    Positioned(
                      top: 12.h,
                      left: 12.w,
                      child: GestureDetector(
                        
                      onTap: (){
                        Get.back();
                      },
                      child:const Icon(Ionicons.chevron_back_circle,color: kPrimary,size: 30,),
                    )),
                    Positioned(
                      bottom: 10,
                      right: 12.w,
                      child: CustomButton(
                        onTap: () {
                          Get.to(()=> RestaurantPage(restaurant: hookResult.data!,));
                        },
                      btnWidth: 120.w,
                      text: "Open Restaurant",
                    ))
                ],
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(style: appStyle(18, kDark, FontWeight.w600), text: food.title),
                    Obx(() =>  ReusableText(style: appStyle(18, kPrimary, FontWeight.w600), text: "\$ ${((food.price + controller.additivePrice)*controller.count.value)}"),)
                  ],
                ),
                SizedBox(height: 1.h,),
                Text(food.description,maxLines:8 ,textAlign: TextAlign.justify, style: appStyle(14, kGray, FontWeight.w400),),
                SizedBox(height: 5.h,),
                SizedBox(
                  height: 18.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(food.foodTags.length, (index) {
                      final tag=food.foodTags[index];
                      return Container(
                        height: 15,
                        width: 50.w,
                        margin: EdgeInsets.only(right: 5.w),
                        decoration: BoxDecoration(
                          color: kPrimary,
                          borderRadius: BorderRadius.all(Radius.circular(15.r))
                        ),
                        child: Center(
                          child: Padding(padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: ReusableText(text: tag,style: appStyle(11, kWhite, FontWeight.w400),),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 15.h,),
                ReusableText(style: appStyle(18, kDark, FontWeight.w600), text: "Additives and Toppings"),
                Obx(() => Column(
                  children: List.generate(controller.additivesList.length, (index) {
                    final additive=controller.additivesList[index];
                    return CheckboxListTile(
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      activeColor: kSecondary,
                      tristate: false,
                      value: additive.isChecked.value, onChanged: (bool? value){
                        additive.toggleChecked();
                        controller.getTotalPrice();
                        controller.getCartAdditive();
                      },title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       ReusableText(style: appStyle(11, kDark, FontWeight.w400), text: additive.title),
                      ReusableText(style: appStyle(11, kPrimary, FontWeight.w400), text: "\$ ${additive.price}")
                    ],),);
                  }),
                ),
                
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(style: appStyle(11, kDark, FontWeight.w400), text: "Quantity"),
                    SizedBox(
                      width: 5.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            controller.increament();
                          },
                          child: Icon(AntDesign.pluscircleo),
                        ),
                        SizedBox(width: 5.w,),
                      Obx(() =>    ReusableText(style: appStyle(11, kDark, FontWeight.w400), text: "${controller.count.value}"),),
                         SizedBox(width: 5.w,),
                         GestureDetector(
                          onTap: (){
                            controller.decreament();
                          },
                          child: Icon(AntDesign.minuscircleo),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20.h,),
            ReusableText(style: appStyle(18, kDark, FontWeight.w600), text: "Preferences"),
            SizedBox(height: 15.h,),
            SizedBox(height: 65.h,child: CustomTextWidget(
              controller: preferences,
              hintText: "Add a note with your preferences",
              maxLines: 3,
            ),),
            SizedBox(height: 10.h,),
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(30.r)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(user==null){
                        Get.to(()=>LoginPage());
                      } else if(user.phoneVerification==false){
 _showVerficationSheet(context);
                      }
                      else if(defaultaddress==false){
                        showAddressSheet(context);
                      }
                      else{
                        double price=(food.price+controller.additivePrice)*controller.count.value;
                        OrderItems item=OrderItems(foodId: food.id,quantity:controller.count.value,price: price ,additives: controller.getCartAdditive(),instructions: preferences.text);
                        Get.to(()=> OrderPage(restaurant: restaurant!,food: food,item: item,address:address!),transition: Transition.cupertino,duration: const Duration(milliseconds: 900));
                      }
                     
                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 8.w),
                      child: ReusableText(style: appStyle(18, kLightWhite, FontWeight.w600), text: "Place Order"),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      //  _showVerficationSheet(context);
                      var data=CartRequest(productId: food.id, additives: controller.getCartAdditive(), totalPrice: food.price*controller.additivePrice*controller.count.value, quantity: controller.count.value);
                      String cart=cartRequestToJson(data);
                      cartController.addToCart(cart);
                    },
                    child: CircleAvatar(
                      backgroundColor: kSecondary,
                      radius: 20.r,
                      child:const Icon(
                        Ionicons.cart,
                        color: kLightWhite,
                      ),
                    ),
                  )
                ],
              ),
            )
              ],
            ),

            )
          ],
         
        
      ),
    );
  }
  Future<dynamic>_showVerficationSheet(BuildContext context){
    return showModalBottomSheet(context: context, builder: (BuildContext context ){
      return Container(
        height: 500.h,
        width: width,
        decoration: BoxDecoration(
          
          image: DecorationImage(image: AssetImage('assets/images/bg4.jpg'),fit: BoxFit.fill,),color: kLightWhite,borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r)
          )
        ),
        child: Padding(padding:EdgeInsets.all(8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            ReusableText(style: appStyle(18, kPrimary, FontWeight.w600), text: "Verify Your Phone Number"),
            SizedBox(
              height: 250.h,
              child: Column(
                children: List.generate(verficationReasons.length, (index) {
                return ListTile(
                  leading: Icon(Icons.check_circle_outline,color: kPrimary,),
                  title: Text(
                    textAlign: TextAlign.justify,
                    verficationReasons[index],style: appStyle(11, kGray, FontWeight.normal),
                  ),
                ) ; 
                }),
              )
            ),
            SizedBox(height: 5.h,),
            CustomButton(text: "Verify Phone Number",onTap: (){
              Get.to(()=> PhoneVerificationPage());
            },btnHeight: 35.h,)
          ],
        ),
         ),
      );
    });
  }
}
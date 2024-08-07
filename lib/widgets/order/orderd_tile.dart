import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/controllers/cart_controller.dart';
import 'package:multivendor_app/model/fetch_model/OrderResponses.dart';
import 'package:multivendor_app/model/fetch_model/cartRequest.dart';
import 'package:multivendor_app/model/fetch_model/foodModel.dart';
import 'package:multivendor_app/views/food/food_page.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';

class OrderedTile extends StatelessWidget {
  const OrderedTile({super.key, required this.food, this.color});
  final OrderItem food;
  final Color?color;
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CartController());
    return GestureDetector(
      onTap: (){
        // Get.to(()=>FoodPage(food: food));
      },
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 70.h,
            width: width,
            decoration: BoxDecoration(
              color:color?? kOffWhite,
              borderRadius: BorderRadius.circular(9.r)
            ),
            child: Container(
              
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 70.w,
                          height: 70.h,
                          child: Image.network(food.foodId.imageUrl[0],fit: BoxFit.cover,),
                        ),
                        Positioned(
                          bottom: 0,
                          
                          child:Container(
                            padding: EdgeInsets.only(left: 6.w,bottom: 2.h),
                            color: kGray.withOpacity(0.6),
                            height: 16.h,
                            width: width,
                            child: RatingBarIndicator(itemBuilder:(context,i)=>Icon(Icons.star,color: kSecondary,),rating: 5, itemCount: 5,itemSize: 15.h,),
                          ) )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column( mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(style: appStyle(11, kDark, FontWeight.w400), text: food.foodId.title),
                    ReusableText(style: appStyle(11, kGray, FontWeight.w400), text: 'Delivery time: ${food.foodId.time}'),
                    SizedBox(
                      width: width*.7,
                      height: 15.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: food.additives.length,
                        itemBuilder: (context,i){
                          var additive=food.additives[i];
                          return Container(
                            margin: EdgeInsets.only(right: 5.w),
                            decoration: BoxDecoration(
                              color: kSecondaryLight,
                              borderRadius: BorderRadius.all(Radius.circular(9.r))
                            ),
                            child: Center(
                              child: Padding(padding: EdgeInsets.all(2.h),
                              child: ReusableText(style: appStyle(8, kGray, FontWeight.w400), text: additive),
                              
                              ),
                            ),
                          );
                        }),
                    )
                 
                  ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 25.w,
            top: 6.h,
            child: Container(
              width: 40.w,
              height: 19.h,
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(10.r)
              ),
              child: Center(child: ReusableText(style: appStyle(12, kLightWhite, FontWeight.w600), text: "\$ ${food.price.toStringAsFixed(2)}")),
            )),
            Positioned(
            right: 75.w,
            top: 6.h,
            child: GestureDetector(
              onTap: (){
                var data=CartRequest(additives:[] ,productId: food.id,quantity: 1,totalPrice: food.price.dg);
                String cart=cartRequestToJson(data);
                controller.addToCart(cart);
              },
              child: Container(
                width: 19.w,
                height: 19.h,
                decoration: BoxDecoration(
                  color: kSecondary,
                  borderRadius: BorderRadius.circular(10.r)
                ),
                child: Center(child: Icon(MaterialCommunityIcons.cart_plus,size:15.h,color:kLightWhite)),
              ),
            ))
        ],
      ),
    );
  }
}
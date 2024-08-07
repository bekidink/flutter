import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/backgroundContainer.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/order_controller.dart';
import 'package:multivendor_app/model/fetch_model/AddressResponse.dart';
import 'package:multivendor_app/model/fetch_model/Restaurant.dart';
import 'package:multivendor_app/widgets/restaurant/row_text.dart';

import '../../common/custom_button.dart';
import '../../model/fetch_model/OrderRequest.dart';
import '../../model/fetch_model/foodModel.dart';
import '../../widgets/order/order_tile.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key, required this.restaurant, required this.food, required this.item, required this.address});
  final RestaurantModel restaurant;
  final FoodModel food;
  final OrderItems item;
  final AddressResponse address;
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(OrderController());
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(

        backgroundColor: kPrimary,title: ReusableText(style: appStyle(13, kLightWhite, FontWeight.w600), text: "Complete Ordering"),),
        body: BackGroundContainer(color: Colors.white, child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height:10.h
              ),
              OrderTile(food: widget.food,),
              Container(
                width: width,
                height:height/4.5,
                decoration: BoxDecoration(
                  color: kOffWhite,
                  borderRadius: BorderRadius.circular(12.r)
                ),
child: Column(
  children: [
    SizedBox(height: 5),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReusableText(style: appStyle(18, kGray,FontWeight.bold ), text: widget.restaurant.title),
        CircleAvatar(
          radius: 18.r,
          backgroundColor: kPrimary,
          backgroundImage: NetworkImage(widget.restaurant.logoUrl),
        )
      ],
    ),
    SizedBox(height: 5.h,),
    RowText(first: "Business hours", second: widget.restaurant.time),
    SizedBox(height: 5.h,),
    const RowText(first: "Distance from Restaurant", second: "3 Km"),
    SizedBox(height: 5.h,),
    RowText(first: "Order Total", second:widget.item.price.toString()),
    SizedBox(height: 10.h,),
    ReusableText(style: appStyle(18, kGray, FontWeight.bold), text: "Additives"),
    SizedBox(height: 10.h,),
    SizedBox(
      height: 15.h,
      width: width,
      child: ListView.builder(
        itemCount: widget.item.additives.length,
        itemBuilder: (context,i){
     var additive=widget.item.additives[i];
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
),
              ),
              SizedBox(
                height:20.h
              ),
              CustomButton(text: "Proceed to Payment",btnHeight: 45,onTap: (){
                OrderRequest orderData=OrderRequest(orderItems: widget.item, orderTotal: 67, deliveryFee: 23, grandTotal: 90,paymentMethod: "Stripe", deliveryAddress: widget.address.id, restaurantAddress: widget.restaurant!.coords.address,   restaurantId: widget.restaurant!.id, restaurantCoords: [
                  widget.restaurant.coords.latitude,
                  widget.restaurant.coords.longitude
                ], recipientCoords: [widget.address.latitude,
                
                  widget.address.longtitude]);
                String order=orderRequestToJson(orderData);
                controller.createOrder(order,orderData);
              },)
            ],
          ),
        )),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/custom_button.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/constants/uidata.dart';
import 'package:multivendor_app/model/fetch_model/Restaurant.dart';
import 'package:multivendor_app/views/restaurants/rating_page.dart';
import 'package:multivendor_app/widgets/direction_page.dart';
import 'package:multivendor_app/widgets/restaurant/restaurant_explore.dart';
import 'package:multivendor_app/widgets/restaurant/restaurant_menu.dart';
import 'package:multivendor_app/widgets/restaurant/row_text.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key, required this.restaurant});
final  RestaurantModel? restaurant;

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> with TickerProviderStateMixin{
 late TabController _tabController=TabController(length: 2,vsync: this);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      backgroundColor: kLightWhite,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
        Stack(
          children: [
              SizedBox(
            height: 230.h,
            width: width,
            child: CachedNetworkImage(imageUrl: widget.restaurant!.imageUrl,fit: BoxFit.cover,),
          ),
          Positioned(bottom: 0, child: 
          Container(width: width,height: 40.h, decoration: BoxDecoration(
            color: kPrimary.withOpacity(0.4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r)
            )

          ),child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            RatingBarIndicator(
              itemCount:5,
              itemSize: 25,
              rating: widget.restaurant!.rating.toDouble(),
              itemBuilder: (context,i)=>const Icon(Icons.star,color: Colors.yellow,)),
              CustomButton(
                onTap: (){
                  Get.to(()=>RatingPage());
                },
                btnColor: kSecondary,
                btnWidth:width/3 ,
                text: 'Rate Restaurant',
              )
          ],),)
          )
        ,
        Positioned(
          top: 40.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Get.back();
                },
                child:const Icon(Ionicons.chevron_back_circle,size: 28,color: kLightWhite,)),
                ReusableText(style: appStyle(13, kDark, FontWeight.w600), text: widget.restaurant!.title),
                GestureDetector(
                onTap: (){
                  Get.to(()=>const DirectionPage());
                },
                child:const Icon(Ionicons.location,size: 28,color: kLightWhite,)),
                
            ],
          ),
        ))
        
          ],
        ),
        SizedBox(height: 10.h,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 8.w),child: Column(
          children: [
            RowText(first: "Distance to Restaurant", second: "2.7km"),
            SizedBox(height: 3.h,),
             RowText(first: "Estimated Price", second: "\$2.7"),
              SizedBox(height: 3.h,),
              RowText(first: "Estimated Time", second: "3omin"),
Divider(thickness: 0.7,)
          ],
        ),),
Padding(
  padding:  EdgeInsets.symmetric(horizontal: 8.w),
  child: Container(
    height: 40.h,
    width: width,
    decoration:BoxDecoration(
      color: kOffWhite,
      borderRadius: BorderRadius.circular(25.r)
    ) ,
    child:TabBar(
      controller: _tabController,
      tabs: [
      Tab(
        
        child: SizedBox(
          width: width/2,
          height: 25,
          child:const Center(child: Text('Menu'),),),
      ), Tab(
        
        child: SizedBox(
          width: width/2,
          height: 25,
          child:const Center(child: Text('Explore'),),),
      )
    ],indicator: BoxDecoration(
      color: kPrimary,
      borderRadius: BorderRadius.circular(25.r)
    ),labelPadding: EdgeInsets.zero,labelColor: kLightWhite,unselectedLabelColor: kGrayLight,labelStyle: appStyle(12, kLightWhite, FontWeight.normal),) ,
  ),
),
Padding(padding: EdgeInsets.symmetric(horizontal: 8.w),
child: SizedBox(
  height: height,
  child: TabBarView(
    controller: _tabController,
    children: [
      RestaurantMenu(restaurantId: widget.restaurant!.id),
      RestaurantExplore(code: widget.restaurant!.code)
    ],
  ),
),
)
        ],
      ),
    ));
  }
}
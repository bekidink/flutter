import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/backgroundContainer.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/widgets/order/pending_status.dart';
import 'package:multivendor_app/widgets/order/tab_widget.dart';

import '../../widgets/order/prepared.dart';

class UserOrders extends StatefulHookWidget {
  const UserOrders({super.key});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> with TickerProviderStateMixin{
  late final TabController _tabController=TabController(length: orderList.length, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        title: Text('User Orders',style: appStyle(14, kPrimary, FontWeight.w600),),
      ),
      body: BackGroundContainer(color: kLightWhite,child: Column(
        children: [
           SizedBox(height: 10.h,),
          TabBar( controller: _tabController, isScrollable: true, indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            color: kPrimary
          ),labelColor: kOffWhite,
          dividerColor: Colors.transparent,
          labelStyle: appStyle(12, kOffWhite, FontWeight.normal),
          unselectedLabelColor:kGrayLight ,
          tabAlignment:TabAlignment.start,
          tabs: List.generate(orderList.length, (index) => TabWidget(text: orderList[index])),
          
          )
        ,
        SizedBox(height: 10.h,),
        SizedBox(
          height: height*.7,
          width: width,
          child: TabBarView(
            controller: _tabController,
            children: [
         const  Pending(),
            const Prepared(),
            Container(),
            Container(),
            Container()
          ]),
        )
        
        ],
      ),),
    );
  }
}
List<String>orderList=[
  "Pending",
  "Preparing",
  "Delivering",
  "Delivered",
  "Cancelled"

];
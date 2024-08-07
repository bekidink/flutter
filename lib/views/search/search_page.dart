import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/custom_appbar.dart';
import 'package:multivendor_app/common/custom_text_field.dart';
import 'package:multivendor_app/views/search/loading_widget.dart';
import 'package:multivendor_app/views/search/search_result.dart';
import 'package:multivendor_app/widgets/shimmers/FoodListShimmer.dart';

import '../../common/custome_container.dart';
import '../../constants/constants.dart';
import '../../controllers/search_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
    final TextEditingController _searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(SearchFormController());
    return Obx(() =>  Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
toolbarHeight: 74.h,
elevation: 0,
automaticallyImplyLeading: false,
backgroundColor: kOffWhite,
title: Padding(padding: EdgeInsets.only(top: 12.h),child: CustomTextWidget(
  maxLines: 1,
controller: _searchController,
keyboardType: TextInputType.text,
hintText: "Search For Foods",
suffixIcon: GestureDetector(
  onTap: (){
    if(controller.isTriggersws==false){
       controller.searchFoods(_searchController.text);
       controller.setTriggersws=true;
    }else{
      controller.searchResults=null;
      controller.setTriggersws=false;
     _searchController.clear();
    }
  },child:controller.searchResults ==null ?Icon(Ionicons.search_circle,size: 40.h,color: kPrimary,):  Icon(Ionicons.close,size: 40.h,color: kRed,),
),
),),
      ),
   body: SafeArea(child: CustomContainer(widgetContent:controller.isLoading?FoodShimmer():controller.searchResults==null? LoadingWidget():const SearchResult(),color: Colors.white, )),
    )
  );
   
  
  }
}
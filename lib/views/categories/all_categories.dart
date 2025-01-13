import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/backgroundContainer.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/categoryModel.dart';
import 'package:multivendor_app/widgets/home/category_tile.dart';
import 'package:multivendor_app/widgets/shimmers/FoodListShimmer.dart';

import '../../fetch/fetch_all_categories.dart';

class AllCategories extends HookWidget {
  const AllCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults=useFetchAllCategories();
    List<CategoryModel>? categories=hookResults.data;
    final isLoading=hookResults.isLoading;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        title: ReusableText(text: "All Categories",style: appStyle(12, kGray, FontWeight.w600),),
      ),
      body: BackGroundContainer(color: Colors.white, child:   Container(
        padding: EdgeInsets.only(left: 12.w,top: 10.h),
        height: height,
        child:isLoading?const FoodShimmer() :ListView(
          scrollDirection: Axis.vertical,
          children: List.generate(categories!.length, (index)  {
            var category=categories[index];
return CategoryTile(category:category);
    
          }),
        ),
      ))
     
   
    );
  }
}
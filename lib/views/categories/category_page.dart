import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/backgroundContainer.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/category_controller.dart';
import 'package:multivendor_app/widgets/shimmers/FoodListShimmer.dart';

import '../../fetch/fetch_category_food.dart';
import '../../model/fetch_model/foodModel.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CategoryController());
    final hookResults=useCategoryFoods("234567");
    List<FoodModel>?foods=hookResults.data;
    final isLoading=hookResults.isLoading;
    print(hookResults.data);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(onPressed: (){
          controller.updateCategory='';
          controller.updateTitle='';
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: kOffWhite,
        title: ReusableText(style: appStyle(13, kDark, FontWeight.w600), text: "${controller.categoryValue} Category"),
      ),
      body: BackGroundContainer(color: Colors.white, child: Container(
        padding: EdgeInsets.only(left: 12.w,top: 10.h),
        height: height,
        child: isLoading?FoodShimmer():Padding(padding: EdgeInsets.all(12.h)),
      ),),
    );
  }
}
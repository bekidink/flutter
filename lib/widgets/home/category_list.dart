import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/category_controller.dart';
import 'package:multivendor_app/fetch/fetch_categories.dart';
import 'package:multivendor_app/model/fetch_model/categoryModel.dart';
import 'package:multivendor_app/widgets/shimmers/CategoryShimmer.dart';

import '../../views/categories/all_categories.dart';

class CategoryList extends HookWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult=useFetchCategories();
    
    List<CategoryModel>? categoriesList=hookResult.data;
    final isLoading=hookResult.isLoading;
    final error=hookResult.error;
    print(hookResult.isLoading);
    return Container(
      height: 75.h,
      padding:EdgeInsets.only(left: 12.w,top: 10.h) ,
      // ignore: dead_code
      child:isLoading?const CategoryShimmer()
      : 
      ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(categoriesList!.length, (index){
          CategoryModel category=categoriesList[index];
          return CategoryWidget(category: category);
      
        }),
      )
    );
  }
  
}

class CategoryWidget extends StatelessWidget {
   const CategoryWidget({super.key,required this.category});
final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CategoryController());
    return     GestureDetector(
            onTap: (){
// if(controller.categoryValue==category['_id']);
   if(controller.categoryValue==category.id){
    controller.updateCategory='';
    controller.updateTitle='';
    // Get.to(()=>const AllCategories(),transition: Transition.fadeIn,duration: Duration(milliseconds: 900));
   }
   else if(category.value=="more"){
    Get.to(()=>const AllCategories(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 900));
   }
    else{
    controller.updateCategory=category.id;
    controller.updateTitle=category.title;
    print(category.id);
    // Get.to(()=>const AllCategories(),transition: Transition.fadeIn,duration: Duration(milliseconds: 900));
   }
            },
            child: Container(
              margin: EdgeInsets.only(right: 5.w),
              padding: EdgeInsets.only(top:4.h),
              width: width*0.19,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color:
                // controller.categoryValue==category['_id']?kSecondary:kOffWhite;
                 kSecondary,width: .5.w)
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 35.h,
                    child: Image.network(category.imageUrl,fit: BoxFit.contain,),
                  ),
                  ReusableText(style: appStyle(12, kDark, FontWeight.normal), text: category.title)
                ],
              ),
            ),
         
         
            
          );
       
       
       
  }
}

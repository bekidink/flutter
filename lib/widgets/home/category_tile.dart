import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/controllers/category_controller.dart';
import 'package:multivendor_app/model/fetch_model/categoryModel.dart';

import '../../common/app_style.dart';
import '../../common/reusable_text.dart';
import '../../constants/constants.dart';
import '../../views/categories/category_page.dart';

class CategoryTile extends StatelessWidget {
   CategoryTile({super.key,required this.category});
   final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CategoryController());
    return ListTile(
  onTap: (){
     controller.updateCategory=category.id;
    controller.updateTitle=category.title;
    Get.to(()=>const CategoryPage(),transition: Transition.fadeIn,duration: const Duration(milliseconds: 900));
  },
  leading: CircleAvatar(
    radius: 18.r,
    backgroundColor: kGrayLight,
    backgroundImage:  NetworkImage(category.imageUrl),
  ),
  title: ReusableText(style: appStyle(12, kGray, FontWeight.w600), text: category.title),
trailing: Icon(Icons.arrow_forward_ios_rounded,color: kGray, size: 15.r,),
);

       
   
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/controllers/tab_index_controller.dart';
import 'package:multivendor_app/views/cart/cart_page.dart';
import 'package:multivendor_app/views/home/home_page.dart';
import 'package:multivendor_app/views/profile/profile_page.dart';
import 'package:multivendor_app/views/search/search_page.dart';

import '../constants/constants.dart';

class MainScreen extends StatelessWidget {
   MainScreen({super.key});
List<Widget> pageList=const[
  HomePage(),
  SearchPage(),
  CartPage(),
  ProfilePage()
];

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(TabIndexController());
    return Obx(()=>  Scaffold(
      body: Stack(
        children: [
         pageList[controller.tabIndex],
          Align(alignment:Alignment.bottomCenter ,
          child: Theme(data: Theme.of(context).copyWith(canvasColor: kPrimary),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedIconTheme:const IconThemeData(color: Colors.black38),
            selectedIconTheme:const IconThemeData(color: kSecondary),
            onTap: (value) {
              controller.setTabIndex=value;
            },
            currentIndex: controller.tabIndex,
            items: [
            BottomNavigationBarItem(icon:  controller.tabIndex==0? Icon(AntDesign.appstore1):Icon(AntDesign.appstore_o),label: 'Home'),
             BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search'),
              BottomNavigationBarItem(icon: Badge(
                label: Text('1'),
                child: Icon(FontAwesome.opencart)),label: 'Cart'),
               BottomNavigationBarItem(icon: controller.tabIndex==3? Icon(FontAwesome.user_circle):Icon(FontAwesome.user_circle_o),label: 'Profile'),
          ]),
          ),
          
          )
        ],
      ),
    )
  
  );
   
  }
}
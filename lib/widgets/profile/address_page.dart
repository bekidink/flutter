import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/backgroundContainer.dart';
import 'package:multivendor_app/common/custom_button.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/fetch/fetch_address.dart';
import 'package:multivendor_app/model/fetch_model/AddressResponse.dart';
import 'package:multivendor_app/widgets/profile/address_list.dart';
import 'package:multivendor_app/widgets/profile/shipping_page.dart';

class AddressPage extends HookWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult=useFetchAddress();
    final List<AddressResponse> addresses=hookResult.data?? [];
     
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kOffWhite,
        title: ReusableText(text: "Addresses",style: appStyle(13, kGray, FontWeight.w600),),
      ),
      body: BackGroundContainer(color: kOffWhite, child: Stack(
        children: [
          AddressList(addresses: addresses),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child:Padding(padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 30.h),child: CustomButton(
              onTap: () {
                Get.to(()=> const ShippingPage());
              },
              text: "Add Address",
            ),),
          )
        ],
      )),
    );
  }
}
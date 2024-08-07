import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/model/fetch_model/AddressResponse.dart';

class AddressTile extends StatelessWidget {
  const AddressTile({super.key, this.address});
  final AddressResponse? address;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){},
      visualDensity: VisualDensity.compact,
      leading: Icon(SimpleLineIcons.location_pin,color: kPrimary,size: 28.h,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r)
      ),
      title: ReusableText(style: appStyle(11, kGray, FontWeight.w500), text: address!.addressLine1,),
      subtitle:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReusableText(style: appStyle(11, kGray, FontWeight.w500), text: address!.postalCode,),
        ],
      ) ,
    );
  }
}
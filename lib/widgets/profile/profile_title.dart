import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget({super.key, required this.title, required this.icon, this.onTap});
 final String title;
 final IconData icon;
 final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      minLeadingWidth: 0,
      onTap: onTap,
      leading: Icon(icon,size: 20,),
      title: ReusableText(style: appStyle(11, kGray, FontWeight.normal), text: title),
      trailing: title!="Settings"?const Icon(AntDesign.right,size: 16,):SvgPicture.asset('assets/icons/us.svg',width: 15.w,height: 20.h,),
    );
  }
}
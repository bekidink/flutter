import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/userlocation_controller.dart';
import 'package:multivendor_app/fetch/fetch_default.dart';

class CustomAppBar extends StatefulHookWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }
  final controller=Get.put(UserLocationController());

  @override
  Widget build(BuildContext context) {
    final box=GetStorage();
    String? accessToken=box.read('token');
    if(accessToken!=null){
      useFetchDefault();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 6.h),
      height: 110.h,
      width: width,
      color: kOffWhite,
      child: Container(
        margin: EdgeInsets.only(top: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                   CircleAvatar(
              radius: 23.r,
              backgroundColor: kSecondary,
              // backgroundImage: NetworkImage(url),
            ),
           Padding(padding: EdgeInsets.only(bottom: 6.h,left: 8.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
ReusableText(style: appStyle(13, kSecondary, FontWeight.w600), text: 'Deliver to')
     ,Obx(() => SizedBox(
      width: width*0.65,
      child: Text(controller.address==""? "1534,playmouth,mn 55447":controller.address,overflow: TextOverflow.ellipsis, style: appStyle(11, kGrayLight, FontWeight.normal),))
           ),
          
              ],
            ),
            ),
           Text(getTimeOfDay(),style: TextStyle(fontSize: 35),)
              ],
            )
         
           
            
          ],
        ),
      ),
    );
  }

  String getTimeOfDay(){
    DateTime now=DateTime.now();
    int hour=now.hour;
    if(hour>=0 && hour<12){
      return '';
    } else if(hour>=12 && hour<16){
return '';
    }else{
      return '';
    }
  }

  Future<void> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  }
  _getCurrentlocation();
   }

  Future<void> _getCurrentlocation()async{
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    LatLng currentLocation=LatLng(position.latitude,position.longitude);
    print(currentLocation);
    controller.setPostion(currentLocation);
    controller.getUserAddress(currentLocation);
  }
}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multivendor_app/common/app_style.dart';
import 'package:multivendor_app/common/backgroundContainer.dart';
import 'package:multivendor_app/common/custom_button.dart';
import 'package:multivendor_app/common/email_text_field.dart';
import 'package:multivendor_app/common/reusable_text.dart';
import 'package:multivendor_app/constants/constants.dart';
import 'package:multivendor_app/controllers/address_controller.dart';
import 'package:multivendor_app/controllers/userlocation_controller.dart';
import "package:http/http.dart" as http;
import 'package:multivendor_app/model/fetch_model/addressModel.dart';
class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  final PageController _pageController=PageController(initialPage: 0);
  final locationController=Get.put(UserLocationController());
  LatLng? selectedpostion;
  GoogleMapController? _mapController;
  final TextEditingController _searchController=TextEditingController();
  final TextEditingController _postalCode=TextEditingController();
  final TextEditingController _instructions=TextEditingController();
  final controller=Get.put(AddressController());
  List<dynamic> _placeList=[];
   List<dynamic> _selectedPlace=[];
  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        
      });
    });
    // TODO: implement initState
    super.initState();

  }
  void _onSearchChanged(String searchQuery)async{
    if(searchQuery.isNotEmpty){
final url=Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?query=${searchQuery}&key=$googleApiKey');
    final response=await http.get(url);
    if(response.statusCode==200){
      final data=response.body;
      print(data);
      setState(() {
        _placeList=json.decode(response.body)["predictions"];
      });
    }
    }
  }
  void  _getPlaceDetails(String placeId)async{
    final url=Uri.parse('https://maps.googleapis.com/maps/api/place/detail/json?place_id=$placeId&key=$googleApiKey');
    final response=await http.get(url);
    if(response.statusCode==200){
      final location=json.decode(response.body);
      final lat=location['result']['geometry']['location']['lat'] as double;
      final lng=location['result']['geometry']['location']['lng'] as double;
      final address=location['result']['formatted_address'] as String;
      String postalCode="";
      final addressComponents=location['result']['address_components'];
      for(var component in addressComponents){
        if(component['types'].contains('postal_code')){
          postalCode=component['long_name'];
          break;
        }
      }

      setState(() {
selectedpostion=LatLng(lat, lng);
_searchController.text=address;

      });
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng),zoom: 15)
      ));
    }

  }
  @override
  void dispose() {
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:const Text("Shipping Address"),
        leading: Obx(() => Padding(padding: EdgeInsets.only(right: 0.w),
        child:locationController.tabIndex==0? IconButton(onPressed: (){
          Get.back();
        }, icon:const Icon(Icons.arrow_back_ios,color: kPrimary,)):IconButton(onPressed: (){
locationController.setTabIndex=0;
_pageController.previousPage(
  duration: Duration(milliseconds: 500),
  curve: Curves.easeIn
);
        }, icon:const Icon(AntDesign.leftcircle,color: kDark,)),
        )),
        actions: [
          Obx(() => locationController.tabIndex==1?SizedBox.shrink():IconButton(onPressed: (){
            locationController.setTabIndex=1;
            _pageController.nextPage(duration:const Duration(
              milliseconds: 500
            ), curve: Curves.easeIn);
          }, icon:const Icon(
            AntDesign.rightcircleo,
            color: kDark,
          )))
        ],
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: PageView(
controller: _pageController,
physics:const NeverScrollableScrollPhysics(),
pageSnapping: false,
onPageChanged: (index){
   _pageController.jumpToPage(index);
  
},
children: [
 Stack(
  children: [
    GoogleMap(
      onMapCreated: (GoogleMapController controller 

      ){
        _mapController=controller;
      },
      markers: selectedpostion==null?
      Set.of([
Marker(markerId: MarkerId(""),
        position: locationController.position!,
        draggable: true,
        onDragEnd: (LatLng position){
          locationController.getUserAddress(position);
          selectedpostion=position;
        }
        )
      ]):Set.of([
        Marker(markerId: const MarkerId(""),
        position: selectedpostion!,
        draggable: true,
        onDragEnd: (LatLng position){
          locationController.getUserAddress(position);
          selectedpostion=position;
        }
        )
      ])
      ,
      initialCameraPosition: CameraPosition(target:selectedpostion ?? LatLng(9.0058578, 38.7675902),zoom: 15,)),
      Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w
            ),
            color: Colors.white,
            child: TextField(
              controller: _searchController,
              onChanged:_onSearchChanged ,
              decoration: InputDecoration(
                hintText: "s"
              ),
            ),

          ),
          _placeList.isEmpty?SizedBox.shrink():Expanded(child: ListView(
            children: List.generate(_placeList.length, (index) {
              return Container(
                color: Colors.white,
                child: ListTile(
                  visualDensity: VisualDensity.compact,
                  title: Text(_placeList[index]["description"]),onTap: (){
                    _getPlaceDetails(_placeList[index]["place_id"]);
                    _selectedPlace.add(_placeList[index]);
                  },
                ),
              );
            }),
          ))
        ],
      )
  ],
 ),
  BackGroundContainer(color: kOffWhite, child: Container(
    child: ListView(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      children: [
        SizedBox(
          height: 30.h,
        ),
        EmailTextField(
          controller: _searchController,
          hintText: "Address",
          keyboardType: TextInputType.text,
          prefixIcon:const Icon(Ionicons.location_sharp),
        ),
        SizedBox(
          height: 15.h,
        ),
         EmailTextField(
          controller: _postalCode,
          hintText: "Postal Code",
          keyboardType: TextInputType.number,
          prefixIcon:const Icon(Ionicons.location_sharp),
        ),
 SizedBox(
          height: 15.h,
        ),
        EmailTextField(
          controller: _instructions,
          hintText: "Delivery Instructions",
          keyboardType: TextInputType.text,
          prefixIcon:const Icon(Ionicons.add_circle),
        ),
 SizedBox(
          height: 15.h,
        ),
        Padding(padding: EdgeInsets.only(left: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReusableText(style: appStyle(12, kDark, FontWeight.w600), text: "Set address as default"),
            Obx(() => CupertinoSwitch(value: locationController.isDefault, onChanged: (value){
              locationController.setIsDefault=value;
            },thumbColor: kSecondary,trackColor: kPrimary,))
          ],
        ),
        ),
        SizedBox(
          height: 15.h,
        ),

        CustomButton(
          btnHeight: 40,
          text: 'S U B M I T',
          onTap: (){
            if(_searchController.text.isNotEmpty && _postalCode.text.isNotEmpty && _instructions.text.isNotEmpty){
              AddressModel model=AddressModel( 
              addressLine1: _searchController.text, postalCode: _postalCode.text, addressModelDefault: locationController.isDefault, latitude: selectedpostion!.latitude, longtitude: selectedpostion!.longitude);
              String data=addressModelToJson(model);
              // print(data);
              controller.addAddress(data);
            }
          },
        )
      ],
    ),
  ))
],
        ),
      ),
    );
  }
}
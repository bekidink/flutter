// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddressModel addressModelFromJson(String str) => AddressModel.fromJson(json.decode(str));

String addressModelToJson(AddressModel data) => json.encode(data.toJson());

class AddressModel {
  
    final String addressLine1;
    final String postalCode;
    final bool addressModelDefault;
    final double latitude;
    final double longtitude;

    AddressModel({
        required this.addressLine1,
        required this.postalCode,
        required this.addressModelDefault,
        required this.latitude,
        required this.longtitude,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        addressLine1: json["addressLine1"],
        postalCode: json["postalCode"],
        addressModelDefault: json["default"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
    );

    Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "postalCode": postalCode,
        "default": addressModelDefault,
        "latitude": latitude,
        "longtitude": longtitude,
    };
}

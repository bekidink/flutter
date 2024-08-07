// To parse this JSON data, do
//
//     final addressResponse = addressResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AddressResponse> addressResponseFromJson(String str) => List<AddressResponse>.from(json.decode(str).map((x) => AddressResponse.fromJson(x)));

String addressResponseToJson(List<AddressResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressResponse {
    final String id;
    final String userId;
    final String addressLine1;
    final String postalCode;
    final bool addressResponseDefault;
    final double latitude;
    final double longtitude;
    final int v;

    AddressResponse({
        required this.id,
        required this.userId,
        required this.addressLine1,
        required this.postalCode,
        required this.addressResponseDefault,
        required this.latitude,
        required this.longtitude,
        required this.v,
    });

    factory AddressResponse.fromJson(Map<String, dynamic> json) => AddressResponse(
        id: json["_id"],
        userId: json["userId"],
        addressLine1: json["addressLine1"],
        postalCode: json["postalCode"],
        addressResponseDefault: json["default"],
        latitude: json["latitude"]?.toDouble(),
        longtitude: json["longtitude"]?.toDouble(),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "addressLine1": addressLine1,
        "postalCode": postalCode,
        "default": addressResponseDefault,
        "latitude": latitude,
        "longtitude": longtitude,
        "__v": v,
    };
}

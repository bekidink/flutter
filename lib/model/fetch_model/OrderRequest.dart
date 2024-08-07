// To parse this JSON data, do
//
//     final orderRequest = orderRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderRequest orderRequestFromJson(String str) => OrderRequest.fromJson(json.decode(str));

String orderRequestToJson(OrderRequest data) => json.encode(data.toJson());

class OrderRequest {
    final OrderItems orderItems;
    final int orderTotal;
    final int deliveryFee;
    final int grandTotal;
    final String deliveryAddress;
    final String restaurantAddress;
    final String? paymentMethod;
    final String? paymentStatus;
    final String? orderStatus;
    final String restaurantId;
    final List<dynamic> restaurantCoords;
    final List<dynamic> recipientCoords;
    final String? driverId;
    final int? rating;
    final String? feedback;
    final String? promoCode;
    final int? discountAmount;
    final String? notes;

    OrderRequest({
        required this.orderItems,
        required this.orderTotal,
        required this.deliveryFee,
        required this.grandTotal,
        required this.deliveryAddress,
        required this.restaurantAddress,
         this.paymentMethod,
         this.paymentStatus,
         this.orderStatus,
        required this.restaurantId,
        required this.restaurantCoords,
        required this.recipientCoords,
         this.driverId,
         this.rating,
         this.feedback,
         this.promoCode,
         this.discountAmount,
         this.notes,
    });

    factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        orderItems: OrderItems.fromJson(json["orderItems"]),
        orderTotal: json["orderTotal"],
        deliveryFee: json["deliveryFee"],
        grandTotal: json["grandTotal"],
        deliveryAddress: json["deliveryAddress"],
        restaurantAddress: json["restaurantAddress"],
        paymentMethod: json["paymentMethod"],
        paymentStatus: json[" paymentStatus"],
        orderStatus: json["orderStatus"],
        restaurantId: json["restaurantId"],
        restaurantCoords: List<dynamic>.from(json["restaurantCoords"].map((x) => x)),
        recipientCoords: List<dynamic>.from(json["recipientCoords"].map((x) => x)),
        driverId: json["driverId"],
        rating: json["rating"],
        feedback: json["feedback"],
        promoCode: json["promoCode"],
        discountAmount: json["discountAmount"],
        notes: json["notes"],
    );

    Map<String, dynamic> toJson() => {
        "orderItems": orderItems.toJson(),
        "orderTotal": orderTotal,
        "deliveryFee": deliveryFee,
        "grandTotal": grandTotal,
        "deliveryAddress": deliveryAddress,
        "restaurantAddress": restaurantAddress,
        "paymentMethod": paymentMethod,
        " paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "restaurantId": restaurantId,
        "restaurantCoords": List<dynamic>.from(restaurantCoords.map((x) => x)),
        "recipientCoords": List<dynamic>.from(recipientCoords.map((x) => x)),
        "driverId": driverId,
        "rating": rating,
        "feedback": feedback,
        "promoCode": promoCode,
        "discountAmount": discountAmount,
        "notes": notes,
    };
}

class OrderItems {
    final String foodId;
    final int quantity;
    final double price;
    final List<dynamic> additives;
    final String instructions;

    OrderItems({
        required this.foodId,
        required this.quantity,
        required this.price,
        required this.additives,
        required this.instructions,
    });

    factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
        foodId: json["foodId"],
        quantity: json["quantity"],
        price: json["price"],
        additives: List<dynamic>.from(json["additives"].map((x) => x)),
        instructions: json["instructions"],
    );

    Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "quantity": quantity,
        "price": price,
        "additives": List<dynamic>.from(additives.map((x) => x)),
        "instructions": instructions,
    };
}

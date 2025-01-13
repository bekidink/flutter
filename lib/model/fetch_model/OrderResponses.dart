// To parse this JSON data, do
//
//     final orderResponses = orderResponsesFromJson(jsonString);

import 'dart:convert';

List<OrderResponses> orderResponsesFromJson(String str) => List<OrderResponses>.from(json.decode(str).map((x) => OrderResponses.fromJson(x)));

String orderResponsesToJson(List<OrderResponses> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderResponses {
    final String id;
    final String userId;
    final List<OrderItem> orderItems;
    final int orderTotal;
    final int deliveryFee;
    final int grandTotal;
    final String deliveryAddress;
    final String restaurantAddress;
    final dynamic paymentMethod;
    final String paymentStatus;
    final dynamic orderStatus;
    final String restaurantId;
    final List<double> restaurantCoords;
    final List<double> recipientCoords;
    final dynamic driverId;
    final dynamic rating;
    final dynamic feedback;
    final dynamic promoCode;
    final dynamic discountAmount;
    final dynamic notes;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    OrderResponses({
        required this.id,
        required this.userId,
        required this.orderItems,
        required this.orderTotal,
        required this.deliveryFee,
        required this.grandTotal,
        required this.deliveryAddress,
        required this.restaurantAddress,
        required this.paymentMethod,
        required this.paymentStatus,
        required this.orderStatus,
        required this.restaurantId,
        required this.restaurantCoords,
        required this.recipientCoords,
        required this.driverId,
        required this.rating,
        required this.feedback,
        required this.promoCode,
        required this.discountAmount,
        required this.notes,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory OrderResponses.fromJson(Map<String, dynamic> json) => OrderResponses(
        id: json["_id"],
        userId: json["userId"],
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderTotal: json["orderTotal"],
        deliveryFee: json["deliveryFee"],
        grandTotal: json["grandTotal"],
        deliveryAddress: json["deliveryAddress"],
        restaurantAddress: json["restaurantAddress"],
        paymentMethod: json["paymentMethod"],
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        restaurantId: json["restaurantId"],
        restaurantCoords: List<double>.from(json["restaurantCoords"].map((x) => x?.toDouble())),
        recipientCoords: List<double>.from(json["recipientCoords"].map((x) => x?.toDouble())),
        driverId: json["driverId"],
        rating: json["rating"],
        feedback: json["feedback"],
        promoCode: json["promoCode"],
        discountAmount: json["discountAmount"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderTotal": orderTotal,
        "deliveryFee": deliveryFee,
        "grandTotal": grandTotal,
        "deliveryAddress": deliveryAddress,
        "restaurantAddress": restaurantAddress,
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class OrderItem {
    final FoodId foodId;
    final int quantity;
    final int price;
    final List<String> additives;
    final String instructions;
    final String id;

    OrderItem({
        required this.foodId,
        required this.quantity,
        required this.price,
        required this.additives,
        required this.instructions,
        required this.id,
    });

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: FoodId.fromJson(json["foodId"]),
        quantity: json["quantity"],
        price: json["price"],
        additives: List<String>.from(json["additives"].map((x) => x)),
        instructions: json["instructions"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "foodId": foodId.toJson(),
        "quantity": quantity,
        "price": price,
        "additives": List<String>.from(additives.map((x) => x)),
        "instructions": instructions,
        "_id": id,
    };
}

class FoodId {
    final String id;
    final String title;
    final List<String> imageUrl;
    final String time;
    final int rating;

    FoodId({
        required this.id,
        required this.title,
        required this.imageUrl,
        required this.time,
        required this.rating,
    });

    factory FoodId.fromJson(Map<String, dynamic> json) => FoodId(
        id: json["_id"],
        title: json["title"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        time: json["time"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "time": time,
        "rating": rating,
    };
}

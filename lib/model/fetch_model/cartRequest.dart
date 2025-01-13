// To parse this JSON data, do
//
//     final cartRequest = cartRequestFromJson(jsonString);

import 'dart:convert';

CartRequest cartRequestFromJson(String str) => CartRequest.fromJson(json.decode(str));

String cartRequestToJson(CartRequest data) => json.encode(data.toJson());

class CartRequest {
    final String productId;
    final List<String> additives;
    final double totalPrice;
    final int quantity;

    CartRequest({
        required this.productId,
        required this.additives,
        required this.totalPrice,
        required this.quantity,
    });

    factory CartRequest.fromJson(Map<String, dynamic> json) => CartRequest(
        productId: json["productId"],
        additives: List<String>.from(json["additives"].map((x) => x)),
        totalPrice: json["totalPrice"]?.toDouble(),
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "additives": List<dynamic>.from(additives.map((x) => x)),
        "totalPrice": totalPrice,
        "quantity": quantity,
    };
}

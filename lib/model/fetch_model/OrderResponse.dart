// To parse this JSON data, do
//
//     final apiError = apiErrorFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
    bool status;
    String message;
    String orderId;

    OrderResponse({
        required this.status,
        required this.message,
        required this.orderId,
    });

    factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        status: json["status"],
        message: json["message"],
        orderId: json["orderId"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "orderId":orderId
    };
}

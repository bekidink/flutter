import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));
String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    String id;
    String username;
    String email;
    String fcm;
    bool verification;
    String phone;
    bool phoneVerification;
    String userType;
    String profile;
    
    DateTime updatedAt;
    String userToken;

    LoginResponse({
        required this.id,
        required this.username,
        required this.email,
        required this.fcm,
        required this.verification,
        required this.phone,
        required this.phoneVerification,
        required this.userType,
        required this.profile,
        required this.updatedAt,
        required this.userToken,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        fcm: json["fcm"],
        verification: json["verification"],
        phone: json["phone"],
        phoneVerification: json["phoneVerification"],
        userType: json["userType"],
        profile: json["profile"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        userToken: json["userToken"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "fcm": fcm,
        "verification": verification,
        "phone": phone,
        "phoneVerification": phoneVerification,
        "userType": userType,
        "profile": profile,
        "updatedAt": updatedAt.toIso8601String(),
        "userToken": userToken,
    };
}

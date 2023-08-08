// To parse this JSON data, do
//
//     final logoutResponse = logoutResponseFromJson(jsonString);

import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) => LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
    int? statusCode;
    List<String>? logoutData;

    LogoutResponse({
        this.statusCode,
        this.logoutData,
    });

    LogoutResponse copyWith({
        int? statusCode,
        List<String>? data,
    }) => 
        LogoutResponse(
            statusCode: statusCode ?? this.statusCode,
            logoutData: data ?? logoutData,
        );

    factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
        statusCode: json["status_code"],
        logoutData: json["data"] == null ? [] : List<String>.from(json["data"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": logoutData == null ? [] : List<dynamic>.from(logoutData!.map((x) => x)),
    };
}

// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) => OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
    int? statusCode;
    Data? data;

    OrderResponse({
        this.statusCode,
        this.data,
    });

    OrderResponse copyWith({
        int? statusCode,
        Data? data,
    }) => 
        OrderResponse(
            statusCode: statusCode ?? this.statusCode,
            data: data ?? this.data,
        );

    factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
    };
}

class Data {
    String? message;
    String? noStruk;

    Data({
        this.message,
        this.noStruk,
    });

    Data copyWith({
        String? message,
        String? noStruk,
    }) => 
        Data(
            message: message ?? this.message,
            noStruk: noStruk ?? this.noStruk,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        noStruk: json["no_struk"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "no_struk": noStruk,
    };
}

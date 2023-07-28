// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DiscountResponse welcomeFromJson(String str) => DiscountResponse.fromJson(json.decode(str));

String welcomeToJson(DiscountResponse data) => json.encode(data.toJson());

class DiscountResponse {
    int? statusCode;
    List<Discount>? data;

    DiscountResponse({
        this.statusCode,
        this.data,
    });

    factory DiscountResponse.fromJson(Map<String, dynamic> json) => DiscountResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<Discount>.from(json["data"]!.map((x) => Discount.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Discount {
    int? idDiskon;
    int? idUser;
    String? namaUser;
    String? nama;
    int? diskon;

    Discount({
        this.idDiskon,
        this.idUser,
        this.namaUser,
        this.nama,
        this.diskon,
    });

    factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        idDiskon: json["id_diskon"],
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        nama: json["nama"],
        diskon: json["diskon"],
    );

    Map<String, dynamic> toJson() => {
        "id_diskon": idDiskon,
        "id_user": idUser,
        "nama_user": namaUser,
        "nama": nama,
        "diskon": diskon,
    };
}

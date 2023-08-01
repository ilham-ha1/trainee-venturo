// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MenuResponse welcomeFromJson(String str) => MenuResponse.fromJson(json.decode(str));

String welcomeToJson(MenuResponse data) => json.encode(data.toJson());

class MenuResponse {
    int? statusCode;
    List<MenuDataList>? data;

    MenuResponse({
        this.statusCode,
        this.data,
    });

    factory MenuResponse.fromJson(Map<String, dynamic> json) => MenuResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<MenuDataList>.from(json["data"]!.map((x) => MenuDataList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class MenuDataList {
    int? idMenu;
    String? nama;
    String? kategori;
    int? harga;
    String? deskripsi;
    String? foto;
    int? status;

    MenuDataList({
        this.idMenu,
        this.nama,
        this.kategori,
        this.harga,
        this.deskripsi,
        this.foto,
        this.status,
    });

    factory MenuDataList.fromJson(Map<String, dynamic> json) => MenuDataList(
        idMenu: json["id_menu"],
        nama: json["nama"],
        kategori: json["kategori"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        foto: json["foto"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "nama": nama,
        "kategori": kategori,
        "harga": harga,
        "deskripsi": deskripsi,
        "foto": foto,
        "status": status,
    };
}
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DetailMenuResponse welcomeFromJson(String str) => DetailMenuResponse.fromJson(json.decode(str));

String welcomeToJson(DetailMenuResponse data) => json.encode(data.toJson());

class DetailMenuResponse {
    int? statusCode;
    DataDetailMenu? data;

    DetailMenuResponse({
        this.statusCode,
        this.data,
    });

    factory DetailMenuResponse.fromJson(Map<String, dynamic> json) => DetailMenuResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? null : DataDetailMenu.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
    };
}

class DataDetailMenu {
    DataMenu? menu;
    List<Topping>? topping;
    List<Level>? level;

    DataDetailMenu({
        this.menu,
        this.topping,
        this.level,
    });

    factory DataDetailMenu.fromJson(Map<String, dynamic> json) => DataDetailMenu(
        menu: json["menu"] == null ? null : DataMenu.fromJson(json["menu"]),
        topping: json["topping"] == null ? [] : List<Topping>.from(json["topping"]!.map((x) => Topping.fromJson(x))),
        level: json["level"] == null ? [] : List<Level>.from(json["level"]!.map((x) => Level.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menu": menu?.toJson(),
        "topping": topping == null ? [] : List<dynamic>.from(topping!.map((x) => x.toJson())),
        "level": level == null ? [] : List<dynamic>.from(level!.map((x) => x.toJson())),
    };
}

class Level {
    int? idDetail;
    int? idMenu;
    String? keterangan;
    String? type;
    int? harga;

    Level({
        this.idDetail,
        this.idMenu,
        this.keterangan,
        this.type,
        this.harga,
    });

    factory Level.fromJson(Map<String, dynamic> json) => Level(
        idDetail: json["id_detail"],
        idMenu: json["id_menu"],
        keterangan: json["keterangan"],
        type: json["type"],
        harga: json["harga"],
    );

    Map<String, dynamic> toJson() => {
        "id_detail": idDetail,
        "id_menu": idMenu,
        "keterangan": keterangan,
        "type": type,
        "harga": harga,
    };
}

class Topping {
    int? idDetail;
    int? idMenu;
    String? keterangan;
    String? type;
    int? harga;

    Topping({
        this.idDetail,
        this.idMenu,
        this.keterangan,
        this.type,
        this.harga,
    });

    factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        idDetail: json["id_detail"],
        idMenu: json["id_menu"],
        keterangan: json["keterangan"],
        type: json["type"],
        harga: json["harga"],
    );

    Map<String, dynamic> toJson() => {
        "id_detail": idDetail,
        "id_menu": idMenu,
        "keterangan": keterangan,
        "type": type,
        "harga": harga,
    };
}
class DataMenu {
    int? idMenu;
    String? nama;
    String? kategori;
    int? harga;
    String? deskripsi;
    String? foto;
    int? status;

    DataMenu({
        this.idMenu,
        this.nama,
        this.kategori,
        this.harga,
        this.deskripsi,
        this.foto,
        this.status,
    });

    factory DataMenu.fromJson(Map<String, dynamic> json) => DataMenu(
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

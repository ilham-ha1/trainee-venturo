// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

PromoResponse welcomeFromJson(String str) => PromoResponse.fromJson(json.decode(str));

String welcomeToJson(PromoResponse data) => json.encode(data.toJson());

class PromoResponse {
    int? statusCode;
    List<Promo>? data;

    PromoResponse({
        this.statusCode,
        this.data,
    });

    factory PromoResponse.fromJson(Map<String, dynamic> json) => PromoResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<Promo>.from(json["data"]!.map((x) => Promo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Promo {
    int? idPromo;
    String? type;
    String? nama;
    int? diskon;
    int? nominal;
    int? kadaluarsa;
    String? syaratKetentuan;
    dynamic foto;

    Promo({
        this.idPromo,
        this.type,
        this.nama,
        this.diskon,
        this.nominal,
        this.kadaluarsa,
        this.syaratKetentuan,
        this.foto,
    });

    factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        idPromo: json["id_promo"],
        type: json["type"],
        nama: json["nama"],
        diskon: json["diskon"],
        nominal: json["nominal"],
        kadaluarsa: json["kadaluarsa"],
        syaratKetentuan: json["syarat_ketentuan"],
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "id_promo": idPromo,
        "type": type,
        "nama": nama,
        "diskon": diskon,
        "nominal": nominal,
        "kadaluarsa": kadaluarsa,
        "syarat_ketentuan": syaratKetentuan,
        "foto": foto,
    };
}

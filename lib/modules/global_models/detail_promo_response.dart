// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DetailPromoResponse welcomeFromJson(String str) => DetailPromoResponse.fromJson(json.decode(str));

String welcomeToJson(DetailPromoResponse data) => json.encode(data.toJson());

class DetailPromoResponse {
    int? statusCode;
    DetailPromo? data;

    DetailPromoResponse({
        this.statusCode,
        this.data,
    });

    factory DetailPromoResponse.fromJson(Map<String, dynamic> json) => DetailPromoResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? null : DetailPromo.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
    };
}

class DetailPromo {
    int? idPromo;
    String? nama;
    dynamic diskon;
    int? nominal;
    int? kadaluarsa;
    String? syaratKetentuan;
    dynamic foto;

    DetailPromo({
        this.idPromo,
        this.nama,
        this.diskon,
        this.nominal,
        this.kadaluarsa,
        this.syaratKetentuan,
        this.foto,
    });

    factory DetailPromo.fromJson(Map<String, dynamic> json) => DetailPromo(
        idPromo: json["id_promo"],
        nama: json["nama"],
        diskon: json["diskon"],
        nominal: json["nominal"],
        kadaluarsa: json["kadaluarsa"],
        syaratKetentuan: json["syarat_ketentuan"],
        foto: json["foto"],
    );

    Map<String, dynamic> toJson() => {
        "id_promo": idPromo,
        "nama": nama,
        "diskon": diskon,
        "nominal": nominal,
        "kadaluarsa": kadaluarsa,
        "syarat_ketentuan": syaratKetentuan,
        "foto": foto,
    };
}

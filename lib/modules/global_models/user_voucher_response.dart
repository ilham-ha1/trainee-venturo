// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

VoucherResponse welcomeFromJson(String str) =>
    VoucherResponse.fromJson(json.decode(str));

String welcomeToJson(VoucherResponse data) => json.encode(data.toJson());

class VoucherResponse {
  int? statusCode;
  List<Voucher>? data;

  VoucherResponse({
    this.statusCode,
    this.data,
  });

  factory VoucherResponse.fromJson(Map<String, dynamic> json) =>
      VoucherResponse(
        statusCode: json["status_code"],
        data: json["data"] == null
            ? []
            : List<Voucher>.from(json["data"]!.map((x) => Voucher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Voucher {
  int? idVoucher;
  String? nama;
  int? idUser;
  int? nominal;
  String? infoVoucher;
  int? periodeMulai;
  int? periodeSelesai;
  int? type;
  int? status;
  dynamic catatan;
  bool? selected;

  Voucher({
    this.idVoucher,
    this.nama,
    this.idUser,
    this.nominal,
    this.infoVoucher,
    this.periodeMulai,
    this.periodeSelesai,
    this.type,
    this.status,
    this.catatan,
    this.selected
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        idVoucher: json["id_voucher"],
        nama: json["nama"],
        idUser: json["id_user"],
        nominal: json["nominal"],
        infoVoucher: json["info_voucher"],
        periodeMulai: json["periode_mulai"],
        periodeSelesai: json["periode_selesai"],
        type: json["type"],
        status: json["status"],
        catatan: json["catatan"],
        selected: json["selected"]
      );

  Map<String, dynamic> toJson() => {
        "id_voucher": idVoucher,
        "nama": nama,
        "id_user": idUser,
        "nominal": nominal,
        "info_voucher": infoVoucher,
        "periode_mulai": periodeMulai,
        "periode_selesai": periodeSelesai,
        "type": type,
        "status": status,
        "catatan": catatan,
        "selected": selected
      };
}

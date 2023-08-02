// To parse this JSON data, do
//
//     final userOrderCancelResponse = userOrderCancelResponseFromJson(jsonString);

import 'dart:convert';

UserOrderCancelResponse userOrderCancelResponseFromJson(String str) => UserOrderCancelResponse.fromJson(json.decode(str));

String userOrderCancelResponseToJson(UserOrderCancelResponse data) => json.encode(data.toJson());

class UserOrderCancelResponse {
    int? statusCode;
    UserOrderCancelData? data;

    UserOrderCancelResponse({
        this.statusCode,
        this.data,
    });

    UserOrderCancelResponse copyWith({
        int? statusCode,
        UserOrderCancelData? data,
    }) => 
        UserOrderCancelResponse(
            statusCode: statusCode ?? this.statusCode,
            data: data ?? this.data,
        );

    factory UserOrderCancelResponse.fromJson(Map<String, dynamic> json) => UserOrderCancelResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? null : UserOrderCancelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
    };
}

class UserOrderCancelData {
    int? idOrder;
    String? noStruk;
    int? idUser;
    DateTime? tanggal;
    int? idVoucher;
    String? idDiskon;
    int? diskon;
    int? potongan;
    int? totalBayar;
    int? status;
    int? isDeleted;

    UserOrderCancelData({
        this.idOrder,
        this.noStruk,
        this.idUser,
        this.tanggal,
        this.idVoucher,
        this.idDiskon,
        this.diskon,
        this.potongan,
        this.totalBayar,
        this.status,
        this.isDeleted,
    });

    UserOrderCancelData copyWith({
        int? idOrder,
        String? noStruk,
        int? idUser,
        DateTime? tanggal,
        int? idVoucher,
        String? idDiskon,
        int? diskon,
        int? potongan,
        int? totalBayar,
        int? status,
        int? isDeleted,
    }) => 
        UserOrderCancelData(
            idOrder: idOrder ?? this.idOrder,
            noStruk: noStruk ?? this.noStruk,
            idUser: idUser ?? this.idUser,
            tanggal: tanggal ?? this.tanggal,
            idVoucher: idVoucher ?? this.idVoucher,
            idDiskon: idDiskon ?? this.idDiskon,
            diskon: diskon ?? this.diskon,
            potongan: potongan ?? this.potongan,
            totalBayar: totalBayar ?? this.totalBayar,
            status: status ?? this.status,
            isDeleted: isDeleted ?? this.isDeleted,
        );

    factory UserOrderCancelData.fromJson(Map<String, dynamic> json) => UserOrderCancelData(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        idUser: json["id_user"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        idVoucher: json["id_voucher"],
        idDiskon: json["id_diskon"],
        diskon: json["diskon"],
        potongan: json["potongan"],
        totalBayar: json["total_bayar"],
        status: json["status"],
        isDeleted: json["is_deleted"],
    );

    Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "no_struk": noStruk,
        "id_user": idUser,
        "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "id_voucher": idVoucher,
        "id_diskon": idDiskon,
        "diskon": diskon,
        "potongan": potongan,
        "total_bayar": totalBayar,
        "status": status,
        "is_deleted": isDeleted,
    };
}

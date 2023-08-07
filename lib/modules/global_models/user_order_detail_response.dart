// To parse this JSON data, do
//
//     final userOrderDetailResponse = userOrderDetailResponseFromJson(jsonString);

import 'dart:convert';

UserOrderDetailResponse userOrderDetailResponseFromJson(String str) => UserOrderDetailResponse.fromJson(json.decode(str));

String userOrderDetailResponseToJson(UserOrderDetailResponse data) => json.encode(data.toJson());

class UserOrderDetailResponse {
    int? statusCode;
    UserOrderDetailData? data;

    UserOrderDetailResponse({
        this.statusCode,
        this.data,
    });

    UserOrderDetailResponse copyWith({
        int? statusCode,
        UserOrderDetailData? data,
    }) => 
        UserOrderDetailResponse(
            statusCode: statusCode ?? this.statusCode,
            data: data ?? this.data,
        );

    factory UserOrderDetailResponse.fromJson(Map<String, dynamic> json) => UserOrderDetailResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? null : UserOrderDetailData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
    };
}

class UserOrderDetailData {
    OrderDetail? order;
    List<Detail>? detail;

    UserOrderDetailData({
        this.order,
        this.detail,
    });

    UserOrderDetailData copyWith({
        OrderDetail? order,
        List<Detail>? detail,
    }) => 
        UserOrderDetailData(
            order: order ?? this.order,
            detail: detail ?? this.detail,
        );

    factory UserOrderDetailData.fromJson(Map<String, dynamic> json) => UserOrderDetailData(
        order: json["order"] == null ? null : OrderDetail.fromJson(json["order"]),
        detail: json["detail"] == null ? [] : List<Detail>.from(json["detail"]!.map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
        "detail": detail == null ? [] : List<dynamic>.from(detail!.map((x) => x.toJson())),
    };
}

class Detail {
    int? idMenu;
    String? kategori;
    String? topping;
    String? nama;
    String? foto;
    int? jumlah;
    String? harga;
    int? total;
    String? catatan;

    Detail({
        this.idMenu,
        this.kategori,
        this.topping,
        this.nama,
        this.foto,
        this.jumlah,
        this.harga,
        this.total,
        this.catatan,
    });

    Detail copyWith({
        int? idMenu,
        String? kategori,
        String? topping,
        String? nama,
        String? foto,
        int? jumlah,
        String? harga,
        int? total,
        String? catatan,
    }) => 
        Detail(
            idMenu: idMenu ?? this.idMenu,
            kategori: kategori ?? this.kategori,
            topping: topping ?? this.topping,
            nama: nama ?? this.nama,
            foto: foto ?? this.foto,
            jumlah: jumlah ?? this.jumlah,
            harga: harga ?? this.harga,
            total: total ?? this.total,
            catatan: catatan ?? this.catatan,
        );

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        idMenu: json["id_menu"],
        kategori: json["kategori"],
        topping: json["topping"],
        nama: json["nama"],
        foto: json["foto"],
        jumlah: json["jumlah"],
        harga: json["harga"],
        total: json["total"],
        catatan: json["catatan"],
    );

    Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "kategori": kategori,
        "topping": topping,
        "nama": nama,
        "foto": foto,
        "jumlah": jumlah,
        "harga": harga,
        "total": total,
        "catatan": catatan,
    };
}

class OrderDetail {
    int? idOrder;
    String? noStruk;
    String? nama;
    int? idVoucher;
    dynamic namaVoucher;
    int? diskon;
    int? potongan;
    int? totalBayar;
    DateTime? tanggal;
    int? status;

    OrderDetail({
        this.idOrder,
        this.noStruk,
        this.nama,
        this.idVoucher,
        this.namaVoucher,
        this.diskon,
        this.potongan,
        this.totalBayar,
        this.tanggal,
        this.status,
    });

    OrderDetail copyWith({
        int? idOrder,
        String? noStruk,
        String? nama,
        int? idVoucher,
        dynamic namaVoucher,
        int? diskon,
        int? potongan,
        int? totalBayar,
        DateTime? tanggal,
        int? status,
    }) => 
        OrderDetail(
            idOrder: idOrder ?? this.idOrder,
            noStruk: noStruk ?? this.noStruk,
            nama: nama ?? this.nama,
            idVoucher: idVoucher ?? this.idVoucher,
            namaVoucher: namaVoucher ?? this.namaVoucher,
            diskon: diskon ?? this.diskon,
            potongan: potongan ?? this.potongan,
            totalBayar: totalBayar ?? this.totalBayar,
            tanggal: tanggal ?? this.tanggal,
            status: status ?? this.status,
        );

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        idVoucher: json["id_voucher"],
        namaVoucher: json["nama_voucher"],
        diskon: json["diskon"],
        potongan: json["potongan"],
        totalBayar: json["total_bayar"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "no_struk": noStruk,
        "nama": nama,
        "id_voucher": idVoucher,
        "nama_voucher": namaVoucher,
        "diskon": diskon,
        "potongan": potongan,
        "total_bayar": totalBayar,
        "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "status": status,
    };
}

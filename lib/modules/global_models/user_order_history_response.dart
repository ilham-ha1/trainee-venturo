// To parse this JSON data, do
//
//     final userOrderHistoryResponse = userOrderHistoryResponseFromJson(jsonString);

import 'dart:convert';

UserOrderHistoryResponse userOrderHistoryResponseFromJson(String str) => UserOrderHistoryResponse.fromJson(json.decode(str));

String userOrderHistoryResponseToJson(UserOrderHistoryResponse data) => json.encode(data.toJson());

class UserOrderHistoryResponse {
    int? statusCode;
    List<UserOrderHistoryData>? data;

    UserOrderHistoryResponse({
        this.statusCode,
        this.data,
    });

    UserOrderHistoryResponse copyWith({
        int? statusCode,
        List<UserOrderHistoryData>? data,
    }) => 
        UserOrderHistoryResponse(
            statusCode: statusCode ?? this.statusCode,
            data: data ?? this.data,
        );

    factory UserOrderHistoryResponse.fromJson(Map<String, dynamic> json) => UserOrderHistoryResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<UserOrderHistoryData>.from(json["data"]!.map((x) => UserOrderHistoryData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class UserOrderHistoryData {
    int? idOrder;
    String? noStruk;
    String? nama;
    int? totalBayar;
    DateTime? tanggal;
    int? status;
    List<OrderHistoryMenu>? menu;

    UserOrderHistoryData({
        this.idOrder,
        this.noStruk,
        this.nama,
        this.totalBayar,
        this.tanggal,
        this.status,
        this.menu,
    });

    UserOrderHistoryData copyWith({
        int? idOrder,
        String? noStruk,
        String? nama,
        int? totalBayar,
        DateTime? tanggal,
        int? status,
        List<OrderHistoryMenu>? menu,
    }) => 
        UserOrderHistoryData(
            idOrder: idOrder ?? this.idOrder,
            noStruk: noStruk ?? this.noStruk,
            nama: nama ?? this.nama,
            totalBayar: totalBayar ?? this.totalBayar,
            tanggal: tanggal ?? this.tanggal,
            status: status ?? this.status,
            menu: menu ?? this.menu,
        );

    factory UserOrderHistoryData.fromJson(Map<String, dynamic> json) => UserOrderHistoryData(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        totalBayar: json["total_bayar"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        status: json["status"],
        menu: json["menu"] == null ? [] : List<OrderHistoryMenu>.from(json["menu"]!.map((x) => OrderHistoryMenu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id_order": idOrder,
        "no_struk": noStruk,
        "nama": nama,
        "total_bayar": totalBayar,
        "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "status": status,
        "menu": menu == null ? [] : List<dynamic>.from(menu!.map((x) => x.toJson())),
    };
}

class OrderHistoryMenu {
    int? idMenu;
    String? kategori;
    String? nama;
    String? foto;
    int? jumlah;
    String? harga;
    int? total;
    String? catatan;

    OrderHistoryMenu({
        this.idMenu,
        this.kategori,
        this.nama,
        this.foto,
        this.jumlah,
        this.harga,
        this.total,
        this.catatan,
    });

    OrderHistoryMenu copyWith({
        int? idMenu,
        String? kategori,
        String? nama,
        String? foto,
        int? jumlah,
        String? harga,
        int? total,
        String? catatan,
    }) => 
        OrderHistoryMenu(
            idMenu: idMenu ?? this.idMenu,
            kategori: kategori ?? this.kategori,
            nama: nama ?? this.nama,
            foto: foto ?? this.foto,
            jumlah: jumlah ?? this.jumlah,
            harga: harga ?? this.harga,
            total: total ?? this.total,
            catatan: catatan ?? this.catatan,
        );

    factory OrderHistoryMenu.fromJson(Map<String, dynamic> json) => OrderHistoryMenu(
        idMenu: json["id_menu"],
        kategori: json["kategori"],
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
        "nama": nama,
        "foto": foto,
        "jumlah": jumlah,
        "harga": harga,
        "total": total,
        "catatan": catatan,
    };
}

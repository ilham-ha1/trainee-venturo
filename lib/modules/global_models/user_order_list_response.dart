// To parse this JSON data, do
//
//     final userOrderListResponse = userOrderListResponseFromJson(jsonString);

import 'dart:convert';

UserOrderListResponse userOrderListResponseFromJson(String str) => UserOrderListResponse.fromJson(json.decode(str));

String userOrderListResponseToJson(UserOrderListResponse data) => json.encode(data.toJson());

class UserOrderListResponse {
    int? statusCode;
    List<UserOrderListData>? data;

    UserOrderListResponse({
        this.statusCode,
        this.data,
    });

    UserOrderListResponse copyWith({
        int? statusCode,
        List<UserOrderListData>? data,
    }) => 
        UserOrderListResponse(
            statusCode: statusCode ?? this.statusCode,
            data: data ?? this.data,
        );

    factory UserOrderListResponse.fromJson(Map<String, dynamic> json) => UserOrderListResponse(
        statusCode: json["status_code"],
        data: json["data"] == null ? [] : List<UserOrderListData>.from(json["data"]!.map((x) => UserOrderListData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class UserOrderListData {
    int? idOrder;
    String? noStruk;
    String? nama;
    int? totalBayar;
    DateTime? tanggal;
    int? status;
    List<OrderListMenu>? menu;

    UserOrderListData({
        this.idOrder,
        this.noStruk,
        this.nama,
        this.totalBayar,
        this.tanggal,
        this.status,
        this.menu,
    });

    UserOrderListData copyWith({
        int? idOrder,
        String? noStruk,
        String? nama,
        int? totalBayar,
        DateTime? tanggal,
        int? status,
        List<OrderListMenu>? menu,
    }) => 
        UserOrderListData(
            idOrder: idOrder ?? this.idOrder,
            noStruk: noStruk ?? this.noStruk,
            nama: nama ?? this.nama,
            totalBayar: totalBayar ?? this.totalBayar,
            tanggal: tanggal ?? this.tanggal,
            status: status ?? this.status,
            menu: menu ?? this.menu,
        );

    factory UserOrderListData.fromJson(Map<String, dynamic> json) => UserOrderListData(
        idOrder: json["id_order"],
        noStruk: json["no_struk"],
        nama: json["nama"],
        totalBayar: json["total_bayar"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        status: json["status"],
        menu: json["menu"] == null ? [] : List<OrderListMenu>.from(json["menu"]!.map((x) => OrderListMenu.fromJson(x))),
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

class OrderListMenu {
    int? idMenu;
    String? kategori;
    String? nama;
    String? foto;
    int? jumlah;
    String? harga;
    int? total;
    String? catatan;

    OrderListMenu({
        this.idMenu,
        this.kategori,
        this.nama,
        this.foto,
        this.jumlah,
        this.harga,
        this.total,
        this.catatan,
    });

    OrderListMenu copyWith({
        int? idMenu,
        String? kategori,
        String? nama,
        String? foto,
        int? jumlah,
        String? harga,
        int? total,
        String? catatan,
    }) => 
        OrderListMenu(
            idMenu: idMenu ?? this.idMenu,
            kategori: kategori ?? this.kategori,
            nama: nama ?? this.nama,
            foto: foto ?? this.foto,
            jumlah: jumlah ?? this.jumlah,
            harga: harga ?? this.harga,
            total: total ?? this.total,
            catatan: catatan ?? this.catatan,
        );

    factory OrderListMenu.fromJson(Map<String, dynamic> json) => OrderListMenu(
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

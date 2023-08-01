// To parse this JSON data, do
//
//     final orderBody = orderBodyFromJson(jsonString);

import 'dart:convert';

OrderBody orderBodyFromJson(String str) => OrderBody.fromJson(json.decode(str));

String orderBodyToJson(OrderBody data) => json.encode(data.toJson());

class OrderBody {
  Order? order;
  List<Menu>? menu;

  OrderBody({
    this.order,
    this.menu,
  });

  OrderBody copyWith({
    Order? order,
    List<Menu>? menu,
  }) =>
      OrderBody(
        order: order ?? this.order,
        menu: menu ?? this.menu,
      );

  factory OrderBody.fromJson(Map<String, dynamic> json) => OrderBody(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        menu: json["menu"] == null
            ? []
            : List<Menu>.from(json["menu"]!.map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
        "menu": menu == null
            ? []
            : List<dynamic>.from(menu!.map((x) => x.toJson())),
      };
}

class Menu {
  int? idMenu;
  int? harga;
  int? level;
  List<int>? topping;
  int? jumlah;
  String? catatan;

  Menu({
    this.idMenu,
    this.harga,
    this.level,
    this.topping,
    this.jumlah,
    this.catatan,
  });

  Menu copyWith({
    int? idMenu,
    int? harga,
    int? level,
    List<int>? topping,
    int? jumlah,
    String? catatan,
  }) =>
      Menu(
        idMenu: idMenu ?? this.idMenu,
        harga: harga ?? this.harga,
        level: level ?? this.level,
        topping: topping ?? this.topping,
        jumlah: jumlah ?? this.jumlah,
        catatan: catatan ?? this.catatan,
      );

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        idMenu: json["id_menu"],
        harga: json["harga"],
        level: json["level"],
        topping: json["topping"] == null
            ? []
            : List<int>.from(json["topping"]!.map((x) => x)),
        jumlah: json["jumlah"],
        catatan: json["catatan"]
      );

  Map<String, dynamic> toJson() => {
        "id_menu": idMenu,
        "harga": harga,
        "level": level,
        "topping":
            topping == null ? [] : List<dynamic>.from(topping!.map((x) => x)),
        "jumlah": jumlah,
        "catatan":catatan
      };
}

class Order {
  int? idUser;
  int? idVoucher;
  int? potongan;
  int? totalBayar;

  Order({
    this.idUser,
    this.idVoucher,
    this.potongan,
    this.totalBayar,
  });

  Order copyWith({
    int? idUser,
    int? idVoucher,
    int? potongan,
    int? totalBayar,
  }) =>
      Order(
        idUser: idUser ?? this.idUser,
        idVoucher: idVoucher ?? this.idVoucher,
        potongan: potongan ?? this.potongan,
        totalBayar: totalBayar ?? this.totalBayar,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        idUser: json["id_user"],
        idVoucher: json["id_voucher"],
        potongan: json["potongan"],
        totalBayar: json["total_bayar"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "id_voucher": idVoucher,
        "potongan": potongan,
        "total_bayar": totalBayar,
      };
}
